// View/GeometricBackground.swift
import SwiftUI

struct GeometricBackground: View {
    var body: some View {
        ZStack {
            // ベースカラー（薄い水色）
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()
            
            // 幾何学模様
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                ForEach(0..<20, id: \.self) { i in
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: CGFloat.random(in: 40...120), height: CGFloat.random(in: 40...120))
                        .position(
                            x: CGFloat.random(in: 0...width),
                            y: CGFloat.random(in: 0...height)
                        )
                }
                
                ForEach(0..<15, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.cyan.opacity(0.08))
                        .frame(width: CGFloat.random(in: 60...100), height: CGFloat.random(in: 60...100))
                        .rotationEffect(.degrees(Double.random(in: 0...45)))
                        .position(
                            x: CGFloat.random(in: 0...width),
                            y: CGFloat.random(in: 0...height)
                        )
                }
                
                ForEach(0..<10, id: \.self) { i in
                    Triangle()
                        .fill(Color.blue.opacity(0.06))
                        .frame(width: CGFloat.random(in: 50...90), height: CGFloat.random(in: 50...90))
                        .rotationEffect(.degrees(Double.random(in: 0...360)))
                        .position(
                            x: CGFloat.random(in: 0...width),
                            y: CGFloat.random(in: 0...height)
                        )
                }
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}