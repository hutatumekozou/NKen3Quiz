// View/QuizView.swift
import SwiftUI

struct QuizView: View {
    let category: String
    @State private var index = 0
    @State private var score = 0
    @State private var answered = false
    @State private var selected: Int? = nil
    @State private var navigateToResult = false

    private var questions: [Question] {
        QuestionStore.shared.pick(category: category, count: 10)
    }

    var body: some View {
        ZStack {
            GeometricBackground()
            
            VStack(alignment: .leading, spacing: 16) {
            Text(category).font(.title2).bold()
            Text("第 \(index + 1) / 10 問").font(.subheadline)

            if index < 10 && index < questions.count {
                let q = questions[index]
                Text(q.text).font(.title).bold()

                ForEach(0..<q.choices.count, id: \.self) { i in
                    Button {
                        guard !answered else { return }
                        selected = i
                        answered = true
                        if i == q.answerIndex { score += 1 }
                    } label: {
                        HStack {
                            Text(q.choices[i])
                            Spacer()
                            if answered && i == q.answerIndex { Image(systemName: "checkmark.circle") }
                        }
                        .padding()
                        .background(rowBG(i: i, q: q))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                    .disabled(answered)
                }

                if let exp = q.explanation, answered {
                    Text(exp).font(.title).bold()
                }

                Spacer()

                Button {
                    if index < 9 {
                        index += 1
                        answered = false
                        selected = nil
                        // 各設問の間で軽くプリロードを維持
                        AdsManager.shared.preload()
                    } else {
                        // 10問目の場合は結果画面へ遷移
                        navigateToResult = true
                    }
                } label: {
                    Text(index < 9 ? "次へ" : "結果へ")
                        .frame(maxWidth: .infinity).padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(!answered)
                
                NavigationLink(destination: ResultView(score: score), isActive: $navigateToResult) {
                    EmptyView()
                }
            }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            AdsManager.shared.preload()
        }
        .onChange(of: index) { new in
            if new == 10 { /* safety */ }
        }
    }

    private func rowBG(i: Int, q: Question) -> Color {
        guard answered else { return Color.white.opacity(0.9) }
        return i == q.answerIndex ? .green.opacity(0.3)
             : (i == selected ? .red.opacity(0.3) : Color.white.opacity(0.9))
    }
}