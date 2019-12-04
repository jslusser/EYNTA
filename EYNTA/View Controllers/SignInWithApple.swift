//
//  SignInWithApple.swift
//  EYNTA
//
//  Created by James Slusser on 11/18/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import SwiftUI
import AuthenticationServices

// 1
final class SignInWithApple: UIViewRepresentable {
  // 2
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    // 3
    return ASAuthorizationAppleIDButton()
  }
  
  // 4
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}


