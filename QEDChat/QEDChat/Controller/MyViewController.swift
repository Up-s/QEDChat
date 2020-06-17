//
//  MyViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MyViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigation()
    setUI()
    setConstraint()
  }
}



// MARK: - UI

extension MyViewController {
  private func setNavigation() {
    navigationItem.title = "My"
  }
  
  private func setUI() {
    view.backgroundColor = .blue
    
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
  }
}

