//
//  TestScreenView.swift
//  hearXTest
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import SwiftUI

struct TestScreenView: View {
    @ObservedObject var viewModel: TestScreenViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Round \(viewModel.currentRound + 1) / 10")
                .font(.headline)
            
            TextField("Enter the digits you heard", text: $viewModel.userInput)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            
            HStack(spacing: 20) {
                Button("Exit Test") {
                    viewModel.resetTest()
                }
                .buttonStyle(.bordered)
                
                Button("Submit") {
                    viewModel.submit()
                }
                .buttonStyle(.borderedProminent)
            }
            NavigationLink("Back to Home Screen", destination: HomeScreenView())
                .buttonStyle(.bordered)
        }
        .padding()
        .onAppear {
            viewModel.startTest()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Results"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    TestScreenView(viewModel: TestScreenViewModel())
}
