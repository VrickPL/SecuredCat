//
//  LoginViewController.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import UIKit

class LoginViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Your PIN"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let securePinEntryView: SecurePinEntryView = {
        let view = SecurePinEntryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset PIN", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        securePinEntryView.delegate = self

        setupUI()
        setupActions()
        setupDismissKeyboardGesture()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(securePinEntryView)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            securePinEntryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            securePinEntryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            securePinEntryView.widthAnchor.constraint(equalToConstant: 300),
            securePinEntryView.heightAnchor.constraint(equalToConstant: 60),

            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupActions() {
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func resetTapped() {
        // TODO: to implement
    }
}

extension LoginViewController: SecurePinEntryViewDelegate {
    func didEnterCompletePin(_ pin: String) {
        // TODO: to implement
    }
}
