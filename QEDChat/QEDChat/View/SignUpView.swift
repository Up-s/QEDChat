//
//  SignUpView.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

protocol SignUpViewViewDelegate: AnyObject {
  func signUpButtonDidTap(emailTF: UITextField, passwordTF: UITextField, nickNameTF: UITextField)
}

class SignUpView: UIView {
  
  weak var delegate: SignUpViewViewDelegate?
  
  private let emailTextField = UITextField()
  private let passwordTextField = UITextField()
  private let nickNameTextField = UITextField()
  private let signUpButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUI() {
    emailTextField.placeholder = "이메일를 입력해주세요"
    emailTextField.keyboardType = .emailAddress
    
    passwordTextField.placeholder = "비밀번호를 입력해주세요"
    passwordTextField.isSecureTextEntry = true
    
    nickNameTextField.placeholder = "별명을 입력해주세요"
    
    [emailTextField, passwordTextField, nickNameTextField].forEach {
      $0.font = UIFont.systemFont(ofSize: 30)
      $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.1)
    }
    
    signUpButton.setTitle("회원가입", for: .normal)
    signUpButton.backgroundColor = .systemBlue
    signUpButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
  }
  
  @objc private func buttonDidTap(_ sender: UIButton) {
    delegate?.signUpButtonDidTap(
      emailTF: emailTextField,
      passwordTF: passwordTextField,
      nickNameTF: nickNameTextField
    )
  }
  
  private struct Standard {
    static let space: CGFloat = 16
  }
  
  private func setConstraint() {
    [emailTextField, passwordTextField, nickNameTextField, signUpButton].forEach {
      self.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      
      switch $0 {
      case is UITextField:
        $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
      case is UIButton:
        $0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 120).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
      default:
        break
      }
    }
    
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.space),
      
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Standard.space),
      
      nickNameTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Standard.space),
      
      signUpButton.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: Standard.space),
      signUpButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Standard.space)
    ])
  }
}
