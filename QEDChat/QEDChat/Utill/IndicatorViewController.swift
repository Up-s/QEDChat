//
//  IndicatorViewController.swift
//  QEDChat
//
//  Created by Lee on 2020/07/07.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

final class IndicatorViewController: UIViewController {
  
  private let indicatorView = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
    setConstraint()
  }
}


// MARK: - UI

extension IndicatorViewController {
  private func setUI() {
    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    
    indicatorView.startAnimating()
    indicatorView.style = UIActivityIndicatorView.Style.large
    indicatorView.color = .white
    view.addSubview(indicatorView)
  }
  
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    indicatorView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    indicatorView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
  }
}


