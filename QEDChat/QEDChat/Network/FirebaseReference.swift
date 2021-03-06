//
//  FirebaseReference.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

struct FirebaseReference {
  static let user = "User"
  static let chat = "Chat"
  static let message = "Message"
}

enum FirebaseError: Error {
  case firebase(Error)
  case notice(String)
}
