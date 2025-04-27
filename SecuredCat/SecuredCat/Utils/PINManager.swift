//
//  PINManager.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//


import Foundation
import SimpleKeychain

final class PINManager {
    static let shared = PINManager()
    private let pinKey = "userPin"
    private let keychain = SimpleKeychain()

    private init() {}

    private var currentPIN: String? {
        do {
            return try keychain.string(forKey: pinKey)
        } catch {
            print("Error fetching current PIN: \(error)")
            return nil
        }
    }

    func savePIN(_ pin: String) {
        do {
            try keychain.set(pin, forKey: pinKey)
        } catch {
            print("Error saving PIN: \(error)")
        }
    }

    func resetPIN() {
        do {
            try keychain.deleteItem(forKey: pinKey)
        } catch {
            print("Error resetting PIN: \(error)")
        }
    }

    func isPINSet() -> Bool {
        return currentPIN != nil
    }

    func verifyPIN(_ pin: String) -> Bool {
        guard let storedPin = currentPIN else { return false }
        return storedPin == pin
    }
}
