//
//  SignUpViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
  
  private let pSign = SignProvider()
  
  private let vSignUp = SignUpView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    setConstraint()
  }
}



// MARK: - UI

extension SignUpViewController {
  private func setUI() {
    view.backgroundColor = .systemBackground
    
    vSignUp.delegate = self
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
      
    view.addSubview(vSignUp)
    vSignUp.translatesAutoresizingMaskIntoConstraints = false
  
    NSLayoutConstraint.activate([
      vSignUp.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
      vSignUp.bottomAnchor.constraint(equalTo: guide.centerYAnchor),
      vSignUp.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.8)
    ])
  }
}



// MARK: - SingUpDelegate

extension SignUpViewController: SignUpViewViewDelegate {
  func signUpButtonDidTap(emailTF: UITextField, passwordTF: UITextField, nickNameTF: UITextField) {
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
    
    guard let nickName = nickNameTF.text else {
      alertNormal(title: "경고", message: "별명를 입력하세요") { (_) in
        nickNameTF.becomeFirstResponder()
      }
      return
    }
    
    presentIndicatorViewController()
    pSign.signUp(email: email, password: password, nickName: nickName) { [weak self] (result) in
      guard let self = self else { return }
      self.dismissIndicatorViewController()
      
      switch result {
      case .failure(.firebase(let error)):
        self.alertNormal(title: "경고", message: error.localizedDescription)
        
      case .failure(.notice(let notice)):
        self.alertNormal(title: "경고", message: notice)
        
      case .success:
        self.dismiss(animated: true)
      }
    }
  }
}

