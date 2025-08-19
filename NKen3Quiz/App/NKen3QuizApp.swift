// App/NKen3QuizApp.swift
import SwiftUI

@main
struct NKen3QuizApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup { HomeView() }
    }
}