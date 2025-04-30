//
//  LoggedView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI

struct LoggedView: View {
    var body: some View {
        TabView {
            CatList()
                .tabItem {
                    Image(systemName: "house")
                    Text("Cats")
                }
//                .background(Color.background)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
//                .background(Color.background)
        }
    }
}

#Preview {
    LoggedView()
}
