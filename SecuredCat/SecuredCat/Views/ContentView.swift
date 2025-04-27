//
//  ContentView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 26/04/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navCoordinator = NavCoordinator()
    
    var body: some View {
        navCoordinator.currentView
    }
}

#Preview {
    ContentView()
}
