// View/ResultView.swift
import SwiftUI

struct ResultView: View {
    let score: Int
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        ZStack {
            GeometricBackground()
            
            VStack(spacing: 0) {
                // Top purple header
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.4, green: 0.4, blue: 1.0), Color(red: 0.6, green: 0.4, blue: 1.0)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(height: 150)
                    
                    VStack(spacing: 8) {
                        Text("結果発表")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("お疲れ様でした！")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                
                // White content area
                VStack(spacing: 30) {
                    Spacer().frame(height: 40)
                    
                    // Score circle
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                            .frame(width: 120, height: 120)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(score) / 10.0)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 4) {
                            Text("\(score)")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("/ 10")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Accuracy percentage
                    Text("正答率: \(score * 10)%")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Text("また挑戦してみてください！")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 20)
                    
                    // "頑張ろう！" button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "book.fill")
                                .foregroundColor(.blue)
                            Text("頑張ろう！")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer().frame(height: 20)
                    
                    // "最初に戻る" button
                    Button {
                        // ★ユーザー操作時のみ戻る：広告 → dismiss → ルートへ
                        func goHome() {
                            print("[Nav] popToRoot by user")
                            router.popToRoot()
                        }
                        if let root = UIRoot.rootViewController() {
                            AdsManager.shared.show(from: root) { goHome() }
                        } else {
                            goHome()
                        }
                    } label: {
                        Text("最初に戻る")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 0))
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden(true)
        // ★自動遷移は禁止。onAppear/onDisappearでのdismissやpopは絶対に入れない。
    }
}