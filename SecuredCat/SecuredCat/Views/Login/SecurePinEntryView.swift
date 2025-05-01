//
//  SecurePinEntryView.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import UIKit

protocol SecurePinEntryViewDelegate: AnyObject {
    func didEnterCompletePin(_ pin: String)
}

class SecurePinEntryView: UIView {
    private let numberOfDigits = 6
    private var currentText = "" {
        didSet {
            updateLabels()
            if currentText.count == numberOfDigits {
                delegate?.didEnterCompletePin(currentText)
                textField.resignFirstResponder()
            }
        }
    }
    
    weak var delegate: SecurePinEntryViewDelegate?
    
    private lazy var labels: [UILabel] = {
        var arr = [UILabel]()
        for _ in 0..<numberOfDigits {
            let label = UILabel()
            label.text = "_"
            label.textAlignment = .center
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 32, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            arr.append(label)
        }
        return arr
    }()
    
    private let textField = PinEntryTextField()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(stackView)
        addSubview(textField)
        
        textField.delegate = self
        textField.onDeleteBackward = { [weak self] in
            self?.handleDeletion()
        }
        labels.forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewTapped() {
        textField.becomeFirstResponder()
    }
    
    private func handleDeletion() {
        if !currentText.isEmpty {
            currentText.removeLast()
        }
    }
    
    private func updateLabels() {
        let isActive = textField.isFirstResponder
        
        for i in 0..<numberOfDigits {
            if i < currentText.count {
                if i == currentText.count - 1 {
                    let index = currentText.index(currentText.startIndex, offsetBy: i)
                    labels[i].text = String(currentText[index])
                } else {
                    labels[i].text = "•"
                }
                labels[i].textColor = .label
            } else {
                labels[i].text = "_"
                labels[i].textColor = (i == currentText.count && isActive) ? .systemBlue : .secondaryLabel
            }
        }
    }
    
    func clearTextField() {
        currentText.removeAll()
    }
    
    func simulatePinFill() {
        for label in labels {
            label.text = "•"
            label.textColor = .label
        }
    }
}

extension SecurePinEntryView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return false
        }
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
            return false
        }
        if currentText.count < numberOfDigits {
            currentText.append(contentsOf: string)
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateLabels()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLabels()
    }
}
