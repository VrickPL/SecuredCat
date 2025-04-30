//
//  ImageActions.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI
import UIKit

public struct ImageActions {
    public static func saveImage(from imageURL: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: imageURL) else {
            completion(false)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else {
                completion(false)
                return
            }
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            DispatchQueue.main.async {
                completion(true)
            }
        }.resume()
    }
}

public struct ShareSheet: UIViewControllerRepresentable {
    public let items: [Any]
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
         UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
