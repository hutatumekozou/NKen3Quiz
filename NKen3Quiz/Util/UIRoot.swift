// Util/UIRoot.swift
import UIKit

enum UIRoot {
    static func rootViewController() -> UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
        return windowScene?.windows.first(where: { $0.isKeyWindow })?.rootViewController
    }
}