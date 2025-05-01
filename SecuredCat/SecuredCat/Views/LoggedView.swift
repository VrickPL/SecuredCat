//
//  LoggedView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI

struct LoggedView: View {
    let catService = CatService()

    var body: some View {
        TabView {
            CatList(catService: catService)
                .tabItem {
                    Image(systemName: "cat.fill")
                    Text("Cats")
                }
            
            FavoritesView(catService: catService)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    LoggedView()
}
