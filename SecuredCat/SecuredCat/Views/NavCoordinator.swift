//
//  NavCoordinator.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//


import SwiftUI

class NavCoordinator: ObservableObject, SplashScreenCoordinatorProtocol, LoginCoordinatorProtocol {
    @Published var isSplashScreenFinished: Bool = false
    @Published var isLogged: Bool = false
    
    @ViewBuilder
    var currentView: some View {
        if !isSplashScreenFinished {
            SplashScreen(coordinator: self)
        } else if !isLogged {
            LoginViewControllerRepresentable(coordinator: self)
        } else {
            CatList()
        }
    }
}

protocol SplashScreenCoordinatorProtocol {
    var isSplashScreenFinished: Bool { get set }
}

protocol LoginCoordinatorProtocol {
    var isLogged: Bool { get set }
}
