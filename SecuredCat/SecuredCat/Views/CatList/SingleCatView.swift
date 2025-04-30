//
//  SingleCatView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 29/04/2025.
//

import SwiftUI

struct SingleCatView: View {
    let cat: Cat

    var body: some View {
        AsyncImage(url: URL(string: cat.url)) { phase in
            switch phase {
            case .empty:
                SkeletonImageView()
            case .success(let image):
                ZStack(alignment: .bottom) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 150)
                    
                    if let breed = cat.breeds?.first {
                        ZStack {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                            
                            Text(breed.name)
                                .font(.caption)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                        }
                        .frame(height: 30)
                    }
                }
            case .failure:
                ZStack {
                    Rectangle()
                        .fill(Color.red.opacity(0.3))
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                }
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 170, height: 150)
        .cornerRadius(8)
    }
}

#Preview {
    SingleCatView(
        cat: Cat(
            id: "ai8",
            url: "https://cdn2.thecatapi.com/images/ai8.jpg",
            breeds: [
                Breed(id: "", name: "chesscat", temperament: nil, lifeSpan: nil, origin: nil, wikipediaUrl: "")
            ]
        )
    )
}
