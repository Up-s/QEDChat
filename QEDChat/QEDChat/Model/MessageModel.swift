//
//  MessageModel.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct MessageModel {
  let nickName: String
  let content: String
  let date: Date
}

struct MessageReference {
  static let nickName = "NickName"
  static let content = "Content"
  static let date = "Date"
}
