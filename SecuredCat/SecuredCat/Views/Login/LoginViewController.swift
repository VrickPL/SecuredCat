//
//  LoginViewController.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    var coordinator: LoginCoordinatorProtocol?

    init(coordinator: LoginCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = UIColor.label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
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
    
    private let faceIDButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Face ID Login", for: .normal)
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
        view.addSubview(lockImageView)
        view.addSubview(titleLabel)
        view.addSubview(securePinEntryView)
        
        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lockImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lockImageView.widthAnchor.constraint(equalToConstant: 50),
            lockImageView.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.topAnchor.constraint(equalTo: lockImageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            securePinEntryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            securePinEntryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            securePinEntryView.widthAnchor.constraint(equalToConstant: 300),
            securePinEntryView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        if PINManager.shared.isPINSet() {
            view.addSubview(faceIDButton)
            view.addSubview(resetButton)

            NSLayoutConstraint.activate([
                faceIDButton.topAnchor.constraint(equalTo: securePinEntryView.bottomAnchor, constant: 20),
                faceIDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
        
        updateTitleLabel()
    }

    private func setupActions() {
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        faceIDButton.addTarget(self, action: #selector(faceIDTapped), for: .touchUpInside)
    }
    
    @objc private func resetTapped() {
        let alert = UIAlertController(
            title: "Reset PIN",
            message: "Are you sure you want to reset your PIN and clear all saved app data?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { [weak self] _ in
            PINManager.shared.resetPIN()
            FavoritesManager.shared.clearFavorites()
            self?.updateTitleLabel()
            self?.securePinEntryView.clearTextField()
            self?.faceIDButton.isHidden = true
            self?.resetButton.isHidden = true

        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc private func faceIDTapped() {
        BiometricAuthenticationManager.shared.authenticateUser { [weak self] success, _ in
            if success {
                self?.login()
            } else {
                self?.animateShake()
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateTitleLabel() {
        if PINManager.shared.isPINSet() {
            titleLabel.text = "Enter Your PIN"
        } else {
            titleLabel.text = "Set Your PIN"
        }
    }
    
    private func login() {
        animateLockOpening {
            self.coordinator?.isLogged = true
        }
    }

    private func animateLockOpening(completion: @escaping () -> Void) {
        UIView.transition(with: lockImageView, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.lockImageView.image = UIImage(systemName: "lock.open.fill")
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                completion()
            }
        }
    }

    private func animateShake() {
        lockImageView.shake()
        titleLabel.shake()
        securePinEntryView.shake()
    }
}

extension LoginViewController: SecurePinEntryViewDelegate {
    func didEnterCompletePin(_ pin: String) {
        if PINManager.shared.isPINSet() {
            if PINManager.shared.verifyPIN(pin) {
                login()
            } else {
                animateShake()
                securePinEntryView.clearTextField()
            }
        } else {
            PINManager.shared.savePIN(pin)
            login()
        }
    }
}
