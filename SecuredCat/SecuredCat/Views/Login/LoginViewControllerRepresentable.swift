//
//  LoginViewControllerRepresentable.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import UIKit
import SwiftUI

struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    var coordinator: LoginCoordinatorProtocol? = nil
    
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController(coordinator: coordinator)
    }
    
    func updateUIViewController(_ vc: LoginViewController, context: Context) {}
}
