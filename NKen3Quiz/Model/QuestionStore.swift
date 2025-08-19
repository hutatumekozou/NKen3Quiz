// Model/QuestionStore.swift
import Foundation

final class QuestionStore: ObservableObject {
    static let shared = QuestionStore()
    @Published private(set) var questions: [Question] = []
    let categories = ["政治","経済","国際","社会","科学・技術","文化","スポーツ","環境・エネルギー","防災・安全","生活・ことば"]

    private init() { load() }

    private func load() {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Question].self, from: data)
        else {
            print("[QuestionStore] Failed to load questions.json")
            return
        }
        self.questions = decoded
        print("[QuestionStore] Loaded \(decoded.count) questions")
    }

    func pick(category: String, count: Int = 10) -> [Question] {
        let pool = questions.filter { $0.category == category }
        return Array(pool.prefix(count))
    }
}