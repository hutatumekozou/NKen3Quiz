// View/HomeView.swift
import SwiftUI

struct HomeView: View {
    @StateObject private var store = QuestionStore.shared
    @State private var selectedCategory: String?

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ZStack {
                // 薄い水色の幾何学模様背景
                GeometricBackground()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(store.categories, id: \.self) { cat in
                            NavigationLink(destination: QuizView(category: cat)) {
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            // 起動時に一度広告をプリロードしておく
            AdsManager.shared.preload()
        }
    }
}