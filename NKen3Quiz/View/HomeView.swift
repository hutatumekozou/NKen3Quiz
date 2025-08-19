// View/HomeView.swift
import SwiftUI

struct HomeView: View {
    @StateObject private var store = QuestionStore.shared
    @StateObject private var router = NavigationRouter()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                // 薄い水色の幾何学模様背景
                GeometricBackground()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(store.categories, id: \.self) { cat in
                            Button {
                                print("[Nav] push quiz:", cat)
                                router.push(.quiz(cat))
                            } label: {
                                Text(cat)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, minHeight: 64)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("N検定3級試験用クイズ")
            .navigationDestination(for: NavigationRouter.Route.self) { route in
                switch route {
                case .quiz(let cat):
                    QuizView(category: cat).environmentObject(router)
                case .result(let score):
                    ResultView(score: score).environmentObject(router)
                }
            }
        }
        .environmentObject(router)
        .onAppear { AdsManager.shared.preload() }
    }
}