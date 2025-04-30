//
//  SkeletonImageView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import SwiftUI

struct SkeletonImageView: View {
    @State private var isAnimating: Bool = false

    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.4))
            .opacity(isAnimating ? 0.6 : 1)
            .overlay {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primaryLabel))
            }
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

#Preview {
    SkeletonImageView()
}
