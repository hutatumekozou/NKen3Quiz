// View/QuizView.swift
import SwiftUI

struct QuizView: View {
    let category: String
    @EnvironmentObject var router: NavigationRouter
    @State private var index = 0
    @State private var score = 0
    @State private var answered = false
    @State private var selected: Int? = nil
    @State private var qs: [Question] = []

    var body: some View {
        ZStack {
            GeometricBackground()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(category).font(.title2).bold()
                Text("第 \(index + 1) / 10 問").font(.subheadline)

                if index < qs.count {
                    let q = qs[index]
                    Text(q.text).font(.title).bold()

                    ForEach(0..<q.choices.count, id: \.self) { i in
                        Button {
                            guard !answered else { return }
                            selected = i; answered = true
                            if i == q.answerIndex { score += 1 }
                        } label: {
                            HStack { 
                                Text(q.choices[i]); Spacer()
                                if answered && i == q.answerIndex { Image(systemName: "checkmark.circle") }
                            }
                            .padding()
                            .background(rowBG(i: i, q: q))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                        }
                        .disabled(answered)
                    }

                    if answered {
                        // 正解/不正解表示
                        if let selectedIndex = selected {
                            Text(selectedIndex == q.answerIndex ? "正解" : "不正解")
                                .font(.title)
                                .bold()
                                .foregroundColor(selectedIndex == q.answerIndex ? .red : .blue)
                        }
                        
                        // 解説文
                        if let exp = q.explanation {
                            Text(exp).font(.title).bold()
                        }
                    }

                    Spacer()

                    Button {
                        if index < 9 {
                            index += 1
                            answered = false; selected = nil
                            AdsManager.shared.preload()
                        } else {
                            print("[Nav] push result score:", score)
                            // ★最終問題後：結果画面へ"push"のみ（自動で戻らない）
                            router.push(.result(score))
                        }
                    } label: {
                        Text(index < 9 ? "次へ" : "結果へ")
                            .frame(maxWidth: .infinity).padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(!answered)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if qs.isEmpty {
                qs = QuestionStore.shared.pick(category: category, count: 10)
            }
            AdsManager.shared.preload()
        }
    }

    private func rowBG(i: Int, q: Question) -> Color {
        guard answered else { return Color.white.opacity(0.9) }
        return i == q.answerIndex ? .green.opacity(0.3)
             : (i == selected ? .red.opacity(0.3) : Color.white.opacity(0.9))
    }
}