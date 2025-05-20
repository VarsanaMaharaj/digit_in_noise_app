//
//  TestResult.swift
//  hearXTest
//
//  Created by Varsana Maharaj on 2025/05/19.
//

import SwiftUI
import AVFoundation

struct TestResult: Identifiable, Codable {
    var id = UUID()
    let score: Int
    let date: Date
}
