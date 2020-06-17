//
//  WindowManager.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

final class WindowManager {
  enum VisibleViewControllerType {
    case sign
    case main
    
    var controller: UIViewController {
      switch self {
      case .sign:     return SignInViewController()
      case .main:     return MainTabBarController()
      }
    }
  }
  
  class func set(_ type: VisibleViewControllerType) {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .systemBackground
    window.rootViewController = type.controller
    window.makeKeyAndVisible()
    
    delegate.window = window
  }
}
