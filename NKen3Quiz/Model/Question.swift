// Model/Question.swift
import Foundation

struct Question: Identifiable, Codable {
    let id: String
    let category: String
    let text: String
    let choices: [String]   // 必ず4件
    let answerIndex: Int    // 0...3
    let explanation: String?
}