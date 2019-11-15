//
//  LoginViewController.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var mainView: UIView!
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        
        mainView = UIView()
        loginTextField = UITextField()
        passwordTextField = UITextField()
        loginButton = UIButton(type: .roundedRect)
        progressView = UIProgressView(progressViewStyle: .default)
        
        loginTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderWidth = 0.5
        loginButton.layer.borderWidth = 0.5
        progressView.layer.borderWidth = 0.5

        loginTextField.layer.cornerRadius = 4
        passwordTextField.layer.cornerRadius = 4
        loginButton.layer.cornerRadius = 4
        progressView.layer.cornerRadius = 4

        loginButton.setTitle("Log In", for: .normal)
        passwordTextField.isSecureTextEntry = true
        loginTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        
        progressView.setProgress(0.0, animated: true)
        progressView.trackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        progressView.isHidden = true
        
        mainView.backgroundColor = .white
        
        mainView.addSubview(loginTextField)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(loginButton)
        mainView.addSubview(progressView)
        
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -55),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 8),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 100),
            progressView.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        
        
        loginButton.addTarget(self, action: #selector(logInButtonTap), for: .touchUpInside)
        
    }
    
    @objc private func logInButtonTap() {
        
        guard !(passwordTextField.text!.isEmpty) || !(loginTextField.text!.isEmpty) else {createAlert(); return }
        guard passwordTextField.text == PASSWORD_CONST && loginTextField.text == LOGIN_CONST else { createAlert(); return }
        progressView.isHidden = false
        loginButton.isEnabled = false
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(setNewValueForProgressView(timer:)), userInfo: nil, repeats: true)
    }
    
    
    @objc private func setNewValueForProgressView(timer: Timer) {
        
        if progressView.progress != 1 {
            let prevProgress = progressView.progress
            progressView.setProgress(prevProgress + 0.025, animated: true)
        } else {
            timer.invalidate()
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func createAlert() {
        
        let alert  = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(actionOK)
        present(alert, animated: true)
    }
}
