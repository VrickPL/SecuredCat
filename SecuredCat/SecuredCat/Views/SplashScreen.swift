//
//  SplashScreen.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import SwiftUI

struct SplashScreen: View {
    var coordinator: SplashScreenCoordinatorProtocol? = nil

    private let duration: Double = 1.5

    @State private var scale: CGFloat = 0.9
    @State private var opacity: Double = 0.7

    var body: some View {
        Image("Icon")
            .resizable()
            .renderingMode(.template)
            .frame(width: 220, height: 220)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: duration * 2 / 3)) {
                    self.scale = 1.0
                    self.opacity = 1.0
                }
                
                var coordinatorRef = self.coordinator
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    coordinatorRef?.isSplashScreenFinished = true
                }
            }
    }
}

#Preview {
    SplashScreen(coordinator: NavCoordinator())
}
