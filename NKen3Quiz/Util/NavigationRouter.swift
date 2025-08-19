// Util/NavigationRouter.swift
import SwiftUI

final class NavigationRouter: ObservableObject {
    enum Route: Hashable {
        case quiz(String)   // category
        case result(Int)    // score
    }

    @Published var path = NavigationPath()

    func push(_ route: Route) { path.append(route) }
    func popToRoot() { path.removeLast(path.count) }
}