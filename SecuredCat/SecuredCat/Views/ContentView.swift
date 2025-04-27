//
//  ContentView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 26/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
