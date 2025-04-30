//
//  ErrorView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//


import SwiftUI

struct ErrorView: View {
    let error: Error
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Text("Error")
                .font(.title)
                .bold()
            
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
            
            Button(action: onRetry) {
                Text("Try again")
                    .fontWeight(.semibold)
                    .cornerRadius(30)
            }
            .padding(.vertical, 4)
        }
        .padding()
        .cornerRadius(12)
        .background(Color.red.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red, lineWidth: 2)
        )
        .padding(.horizontal, 40)
    }
}

#Preview {
    ErrorView(error: NetworkServiceError.invalidResponse(statusCode: 500)) {}
}
