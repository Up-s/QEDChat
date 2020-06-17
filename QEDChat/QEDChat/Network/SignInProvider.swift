//
//  SignProvider.swift
//  QEDChat
//
//  Created by Lee on 2020/06/17.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Firebase

class SignProvider {
  
  let firestore = Firestore.firestore()
  let auth = Auth.auth()
  
  func signIn(email: String, password: String, completion: @escaping (Result<String, FirebaseError>) -> Void) {
    auth.signIn(withEmail: email, password: password) { [weak self] (result, error) in
      if let error = error {
        completion(.failure(.firebase(error)))
        
      } else {
        guard
          let self = self,
          let user = result?.user
          else {
            completion(.failure(.notice("Parsing Error")))
            return
        }
        
        self.firestore
          .collection(FirebaseReference.user)
          .document(user.uid)
          .getDocument { (snapshot, error) in
            
            if let error = error {
              completion(.failure(.firebase(error)))
              
            } else {
              guard
                let data = snapshot?.data(),
                let nickName = data[UserReference.nickName] as? String
                else {
                  completion(.failure(.notice("Parsing Error")))
                  return
              }
              
              UserDefaults.standard.set(email, forKey: UserReference.email)
              UserDefaults.standard.set(nickName, forKey: UserReference.nickName)
              completion(.success("Success"))
            }
        }
      }
    }
  }
  
  
  func signUp(email: String, password: String, nickName: String, completion: @escaping (Result<String, FirebaseError>) -> Void) {
    auth.createUser(withEmail: email, password: password) { [weak self] (result, error) in
      if let error = error {
        completion(.failure(.firebase(error)))
        
      } else {
        guard
          let self = self,
          let user = result?.user
          else {
            completion(.failure(.notice("Parsing Error")))
            return
        }
        
        self.firestore
          .collection(FirebaseReference.user)
          .document(user.uid)
          .setData([
            UserReference.email: email,
            UserReference.nickName: nickName
          ]) { (error) in
            if let error = error {
              completion(.failure(.firebase(error)))

            } else {
              completion(.success("Success"))
            }
        }
      }
    }
  }
}

