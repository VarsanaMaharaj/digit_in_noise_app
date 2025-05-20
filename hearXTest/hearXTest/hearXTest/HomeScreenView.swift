//
//  HomeScreenView.swift
//  hearXTest
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import SwiftUI

struct HomeScreenView: View {
    @StateObject private var viewModel = TestScreenViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink("Start Test", destination: TestScreenView(viewModel: viewModel))
                .buttonStyle(.bordered)
                
                NavigationLink("View Results", destination: ResultsScreenView(viewModel: viewModel))
                .buttonStyle(.bordered)
                .sheet(isPresented: $viewModel.showResultsView) {
                    ResultsScreenView(viewModel: viewModel)
                }
            }
            .navigationTitle("Digit in Noise Test")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Info"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
