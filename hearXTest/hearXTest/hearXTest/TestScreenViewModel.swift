//
//  TestScreenViewModel.swift
//  hearXTest
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import Foundation
import AVFoundation
import CoreData

class TestScreenViewModel: ObservableObject {
    @Published var currentRound: Int = 0
    @Published var currentTriplet = ""
    @Published var score: Int = 0
    @Published var userInput: String = ""
    @Published var results: [TestResult] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showResultsView = false
    
    private var difficulty = 5
    private var previousTriplet: [Int]?
    private var audioPlayer: AVAudioPlayer?
    private var testRounds: [[String: Any]] = []
    private var usedTriplets: Set<String> = []

    private let maxRounds = 10
    private let apiUrl = URL(string: "https://example.com/api/results")!
    
    init() {
        loadResults()
    }

    func startTest() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.playTriplet()
        }
    }
    
    func generateTriplet() -> String {
        var triplet: String
        repeat {
            triplet = (1...3).map { _ in String(Int.random(in: 1...9)) }.joined()
        } while usedTriplets.contains(triplet)
        usedTriplets.insert(triplet)
        return triplet
    }
    
    func playTriplet() {
        currentTriplet = generateTriplet()
        playAudio(fileName: "noise_\(difficulty)") {
            self.playDigits()
        }
    }
    
    private func playDigits() {
        for (index, digit) in currentTriplet.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                self.playAudio(fileName: "\(digit)", completion: nil)
            }
        }
    }
    
    private func playAudio(fileName: String, completion: (() -> Void)? = nil) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "m4a") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            completion?()
        } catch {
            print("Audio error: \(error.localizedDescription)")
        }
    }
    
    func submit() {
        if userInput == currentTriplet {
            score += difficulty
            difficulty = min(difficulty + 1, 10)
        } else {
            difficulty = max(difficulty - 1, 1)
        }
        
        userInput = ""
        currentRound += 1
        
        if currentRound >= maxRounds {
            endTest()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.playTriplet()
            }
        }
    }
    
    func endTest() {
        let result = TestResult(score: score, date: Date())
        results.append(result)
        saveResults()
        uploadResults(result: result) { success in
            DispatchQueue.main.async {
                self.alertMessage = "Test completed! Your score is \(String(describing: self.results.last?.score))."
                self.showAlert = true
            }
        }
        resetTest()
    }

    private func uploadResults(result: TestResult, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "score": result.score,
            "date": ISO8601DateFormatter().string(from: result.date)
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to upload results: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    private func saveResults() {
        if let data = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(data, forKey: "testResults")
        }
    }
    
    private func loadResults() {
        if let data = UserDefaults.standard.data(forKey: "testResults"),
           let savedResults = try? JSONDecoder().decode([TestResult].self, from: data) {
            results = savedResults
        }
    }
    
    func resetTest() {
        currentRound = 0
        score = 0
        difficulty = 5
        usedTriplets.removeAll()
    }
}

