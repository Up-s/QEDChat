//
//  SignInViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
  
  private let pSign = SignProvider()
  
  private let vSignIn = SignInView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    setConstraint()
  }
}


// MARK: - UI

extension SignInViewController {
  private func setUI() {
    view.backgroundColor = .systemBackground
    
    vSignIn.delegate = self
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    view.addSubview(vSignIn)
    vSignIn.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      vSignIn.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
      vSignIn.bottomAnchor.constraint(equalTo: guide.centerYAnchor),
      vSignIn.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.8)
    ])
  }
}



// MARK: - SignInDelegate

extension SignInViewController: SignInViewDelegate {
  func signInButtonDidTap(emailTF: UITextField, passwordTF: UITextField) {
    guard let email = emailTF.text else {
      alertNormal(title: "경고", message: "이메일을 입력하세요") { (_) in
        emailTF.becomeFirstResponder()
      }
      return
    }
    
    guard let password = passwordTF.text else {
      alertNormal(title: "경고", message: "비밀번호를 입력하세요") { (_) in
        passwordTF.becomeFirstResponder()
      }
      return
    }
    
    pSign.signIn(email: email, password: password) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .failure(.firebase(let error)):
        self.alertNormal(title: "경고", message: error.localizedDescription)
        
      case .failure(.notice(let notice)):
        self.alertNormal(title: "경고", message: notice)
        
      case .success:
        WindowManager.set(.chat)
      }
    }
  }
  
  func signUpButtonDidTap() {
    let vcSignUP = SignUpViewController()
    present(vcSignUP, animated: true)
  }
}
