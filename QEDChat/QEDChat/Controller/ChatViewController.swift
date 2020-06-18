//
//  ChatListViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
  
  private let pChat = ChatProvider()
  
  private let tableView = UITableView()
  private let messageTextField = UITextField()
  
  private var bottomViewConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavination()
    setUI()
    setConstraint()
    setKeyboardNotification()
    setNetwork()
  }
  
  private func setNetwork() {
    pChat.addListener { (result) in
      switch result {
      case .failure(.firebase(let error)):
        self.alertNormal(title: "네트워크 에러", message: error.localizedDescription)
        
      case .failure(.notice(let notice)):
        self.alertNormal(title: notice)
        
      case .success:
        self.tableView.reloadData()
        self.tableViewBottomScroll()
      }
    }
  }
}



// MARK: - UI

extension ChatViewController {
  private func setNavination() {
    navigationController?.title = "Chat"
    let signOutBarButton = UIBarButtonItem(title: "종료", style: .done, target: self, action: #selector(signOutBarButtonDidTap))
    navigationItem.leftBarButtonItem = signOutBarButton
  }
  
  @objc private func signOutBarButtonDidTap() {
    switch SignProvider().signOut() {
    case .failure(let error):
      alertNormal(title: error.localizedDescription)
      
    case .success:
      pChat.out()
      WindowManager.set(.sign)
    }
  }
  
  private func setUI() {
    view.backgroundColor = .systemBackground
    
    tableView.keyboardDismissMode = .onDrag
    tableView.dataSource = self
    
    messageTextField.font = UIFont.systemFont(ofSize: 35)
    messageTextField.backgroundColor = .red
    messageTextField.delegate = self
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    [tableView, messageTextField].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: guide.topAnchor),
      messageTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor)
    ])
    
    bottomViewConstraint = messageTextField.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    bottomViewConstraint?.isActive = true
  }
  
  private func tableViewBottomScroll() {
    guard !pChat.messages.isEmpty else { return }
    tableView.scrollToRow(at: (IndexPath(row: self.pChat.messages.count - 1, section: 0)), at: .bottom, animated: true)
  }
}



// MARK: - Notification

extension ChatViewController {
  private func setKeyboardNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationAction(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationAction(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc private func keyboardNotificationAction(_ notification: Notification) {
    guard
      let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
      let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
      let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
      else { return }
    let height = keyboardFrame.cgRectValue.height - view.safeAreaInsets.bottom
    
    UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
      switch notification.name {
      case UIResponder.keyboardWillShowNotification:
        self.bottomViewConstraint?.constant = -height
        
      case UIResponder.keyboardWillHideNotification:
        self.bottomViewConstraint?.constant = 0
        
      default:
        break
      }
      self.view.layoutIfNeeded()
    })
    
    tableViewBottomScroll()
  }
}



// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    pChat.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    
    let message = pChat.messages[indexPath.row]
    cell.textLabel?.text = message.content
    cell.detailTextLabel?.text = message.nickName
    
    return cell
  }
}



// MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pChat.addMessage(content: textField.text)
    textField.text = nil
    return true
  }
}
