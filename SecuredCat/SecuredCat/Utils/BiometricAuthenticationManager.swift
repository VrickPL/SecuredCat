//
//  BiometricAuthenticationManager.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//


import Foundation
import LocalAuthentication

final class BiometricAuthenticationManager {
    static let shared = BiometricAuthenticationManager()
    
    private init() {}
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            completion(false, error)
            return
        }
        let reason = "Use Face ID to log in"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
            DispatchQueue.main.async {
                completion(success, authError)
            }
        }
    }
}