// View/ResultView.swift
import SwiftUI

struct ResultView: View {
    let score: Int
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            GeometricBackground()
            
            VStack(spacing: 16) {
            Text("結果").font(.title).bold()
            Text("スコア：\(score) / 10").font(.title2)
            Text("おつかれさまです！").foregroundStyle(.secondary)

            Spacer()

            Button {
                // 「最初に戻る」押下後に広告 → 閉じたらホームへ戻る
                if let root = UIRoot.rootViewController() {
                    AdsManager.shared.show(from: root) {
                        dismissToRoot()
                    }
                } else {
                    dismissToRoot()
                }
            } label: {
                Text("最初に戻る")
                    .frame(maxWidth: .infinity).padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }

    private func dismissToRoot() {
        // NavigationStack のトップに戻す
        dismiss() // Result → Quiz
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            dismiss() // Quiz → Home（2段戻し想定）
        }
    }
}