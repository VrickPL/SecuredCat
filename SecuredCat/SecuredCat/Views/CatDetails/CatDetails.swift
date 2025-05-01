//
//  CatDetails.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI

struct CatDetails: View {
    @StateObject var favoritesManager = FavoritesManager.shared
    @StateObject private var viewModel: CatDetailsViewModel
    
    private var cat: Cat {
        viewModel.cat
    }
    
    init(cat: Cat, catService: CatService) {
        _viewModel = StateObject(wrappedValue: CatDetailsViewModel(cat: cat, catService: catService))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CatImageView(imageURL: cat.url)
                    .padding(.horizontal)
                
                if let breed = cat.breeds?.first {
                    BreedDetailsView(breed: breed)
                        .padding()
                } else if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding()
                        Spacer()
                    }
                } else if let error = viewModel.error {
                    ErrorView(error: error, onRetry: viewModel.loadCatDetails)
                } else {
                    Text("No information about the breed.")
                        .padding()
                }
            }
        }
        .navigationTitle("Cat details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                favoritesManager.toggleFavorite(cat: cat)
            } label: {
                Image(systemName: favoritesManager.isFavorite(catID: cat.id) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }
        .refreshable {
            viewModel.loadCatDetails()
        }
    }
    
    struct CatImageView: View {
        let imageURL: String
        
        @State private var isShowingShareSheet = false
        @State private var showSaveSuccessAlert = false

        var body: some View {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    SkeletonImageView()
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, idealHeight: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .contextMenu {
                            Button {
                                ImageActions.saveImage(from: imageURL) { isSuccess in
                                    self.showSaveSuccessAlert = isSuccess
                                }
                            } label: {
                                Label("Save Image", systemImage: "square.and.arrow.down")
                            }
                            
                            Button {
                                isShowingShareSheet = true
                            } label: {
                                Label("Share Image", systemImage: "square.and.arrow.up")
                            }
                        }
                        .sheet(isPresented: $isShowingShareSheet) {
                            if #available(iOS 16.0, *) {
                                ShareSheet(items: [URL(string: imageURL)!])
                                    .presentationDetents([.medium, .large])
                            } else {
                                ShareSheet(items: [URL(string: imageURL)!])
                            }
                        }
                        .alert("Saved!", isPresented: $showSaveSuccessAlert) {
                           Button("OK", role: .cancel) { }
                        }
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }

    struct BreedDetailsView: View {
        let breed: Breed

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(breed.name)
                    .fontWeight(.bold)
                    .font(.title)
                
                BreedInfoRow(systemImageName: "face.smiling", label: "Temperament", value: breed.temperament)
                BreedInfoRow(systemImageName: "heart", label: "Life span", value: breed.lifeSpan, labelAfter: " years")
                BreedInfoRow(systemImageName: "mappin.and.ellipse", label: "Origin", value: breed.origin)
                
                if let wikipediaUrl = breed.wikipediaUrl,
                   !wikipediaUrl.isEmpty,
                   let url = URL(string: wikipediaUrl) {
                    MoreInfoLink(url: url)
                        .padding(.top, 20)
                }
            }
        }
    }

    struct BreedInfoRow: View {
        let systemImageName: String
        let label: String
        let value: String?
        var labelAfter: String? = nil
        
        var body: some View {
            if let value = value {
                HStack(alignment: .center) {
                    Image(systemName: systemImageName)
                        .foregroundColor(.blue)
                        .frame(width: 30, alignment: .center)
                        .font(.title3)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(label)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(value)\(labelAfter ?? "")")
                            .font(.body)
                    }
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            }
        }
    }

    struct MoreInfoLink: View {
        let url: URL
        
        var body: some View {
            Link(destination: url) {
                Text("More info")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(45)
            }
        }
    }
}

#Preview {
    CatDetails(
        cat: Cat(
            id: "ai8",
            url: "https://cdn2.thecatapi.com/images/ai8.jpg",
            breeds: [
                Breed(
                    id: "b1",
                    name: "Chesscat",
                    temperament: "Nice",
                    lifeSpan: "12-15",
                    origin: "Poland",
                    wikipediaUrl: "aaa"
                )
            ]
        ),
        catService: CatService()
    )
}
