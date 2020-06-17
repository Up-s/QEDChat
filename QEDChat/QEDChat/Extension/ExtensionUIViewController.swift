//
//  ExtensionUIViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

extension UIViewController {
  
  // MARK: - AlertController
  func alertNormal(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: handler)
    alert.addAction(cancel)
    self.present(alert, animated: true)
  }
}

