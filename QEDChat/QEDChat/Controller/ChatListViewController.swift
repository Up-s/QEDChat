//
//  ChatListViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ChatListViewController: UITabBarController {
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigation()
    setUI()
    setConstraint()
  }
}



// MARK: - UI

extension ChatListViewController {
  private func setNavigation() {
    navigationItem.title = "List"
  }
  
  private func setUI() {
    view.backgroundColor = .red
    
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
  }
}
