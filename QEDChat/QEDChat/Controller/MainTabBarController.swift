//
//  MainTabBarController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let vcChatList = UINavigationController(rootViewController: ChatListViewController())
    let vcMy = UINavigationController(rootViewController: MyViewController())
    
    vcChatList.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "bubble.right"), tag: 0)
    vcMy.tabBarItem = UITabBarItem(title: "My", image: UIImage(systemName: "person"), tag: 1)
    
    viewControllers = [vcChatList, vcMy]
  }
}
