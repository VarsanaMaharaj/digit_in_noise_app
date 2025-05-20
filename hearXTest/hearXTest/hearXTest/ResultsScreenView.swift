//
//  ResultsScreenView.swift
//  hearXTest
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import SwiftUI

struct ResultsScreenView: View {
    @ObservedObject var viewModel: TestScreenViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.results.sorted { $0.score > $1.score }) { result in
                VStack(alignment: .leading) {
                    Text("Score: \(result.score)")
                        .font(.headline)
                    Text("Date: \(result.date, formatter: DateFormatter.shortDate)")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Test Results")
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    ResultsScreenView(viewModel: TestScreenViewModel())
}
