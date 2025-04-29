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
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(1.0, contentMode: .fit)
                    ProgressView()
                }
            case .success(let image):
                ZStack(alignment: .bottom) {
                    image
                        .resizable()
                        .scaledToFill()
                    
                    if let breed = cat.breeds?.first {
                        ZStack {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .blur(radius: 5)
                            
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
                .frame(width: 170, height: 150)
                .clipped()
            case .failure:
                ZStack {
                    Rectangle()
                        .fill(Color.red.opacity(0.3))
                        .aspectRatio(1.0, contentMode: .fit)
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                }
            @unknown default:
                EmptyView()
            }
        }
        .cornerRadius(8)
    }
}

#Preview {
    SingleCatView(
        cat: Cat(
            id: "ai8",
            url: "https://cdn2.thecatapi.com/images/ai8.jpg",
            breeds: [
                Breed(id: "", name: "chesscat", temperament: nil, lifeSpan: nil, origin: nil)
            ]
        )
    )
}
