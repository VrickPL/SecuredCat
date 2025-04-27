//
//  PinEntryTextField.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//


import UIKit

class PinEntryTextField: UITextField {
    var onDeleteBackward: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        keyboardType = .numberPad
        autocorrectionType = .no
        spellCheckingType = .no
        isHidden = true
    }
    
    override func deleteBackward() {
        onDeleteBackward?()
        super.deleteBackward()
    }
}
