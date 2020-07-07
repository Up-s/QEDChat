//
//  ChatProvider.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase

class ChatProvider {
  
  private var listener: ListenerRegistration?
  
  private let firestore = Firestore.firestore()
  private var _messages = [MessageModel]()
  
  var messages: [MessageModel] { _messages }
  
  
  
  func addListener(completion: @escaping (Result<String, FirebaseError>) -> Void) {
    listener = firestore
      .collection(FirebaseReference.chat)
      .addSnapshotListener { (snapshot, error) in
        if let error = error {
          completion(.failure(.firebase(error)))
          
        } else {
          guard let documents = snapshot?.documents else {
            completion(.failure(.notice("Snapshot Error")))
            return
          }
          
          var tempMessages = [MessageModel]()
          
          for document in documents {
            let data = document.data()
            guard
              let nickName = data[MessageReference.nickName] as? String,
              let content = data[MessageReference.content] as? String,
              let timestamp = data[MessageReference.date] as? Timestamp
              else {
                completion(.failure(.notice("Parsing Error")))
                return
            }
            
            let message = MessageModel(
              nickName: nickName,
              content: content,
              date: timestamp.dateValue()
            )
            
            tempMessages.append(message)
          }
          
          tempMessages.sort { $0.date < $1.date }
          self._messages = tempMessages
          
          completion(.success("Success"))
        }
    }
  }
  
  
  
  func addMessage(content: String?) {
    guard
      let nickName = UserDefaults.standard.string(forKey: UserReference.nickName),
      let content = content
      else { return }
    
    firestore
      .collection(FirebaseReference.chat)
      .addDocument(data: [
        MessageReference.nickName: nickName,
        MessageReference.content: content,
        MessageReference.date: Timestamp()
      ])
  }
  
  
  
  func out() {
    listener?.remove()
  }
}

