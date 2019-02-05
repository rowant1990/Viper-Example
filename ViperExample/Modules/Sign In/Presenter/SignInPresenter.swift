//
//  SignInPresenter.swift
//  ViperExample
//
//  Created by Rowan Townshend on 04/02/2019.
//  Copyright © 2019 Rowan Townshend. All rights reserved.
//

import UIKit

class SignInPresenter: SignInPresentation {
 
  weak var view: SignInView?
  var router: SignInRoutable!
  var interactor: SignInInteraction!
  
  func signIn(username: String) {
    view?.updateLoading(loading: true)
    interactor.signIn(username: username)
  }
}

extension SignInPresenter: SignInInteractorOutput {
  
  func success() {
    view?.updateLoading(loading: false)
  }
  
  func failed(error: Error) {
    view?.updateLoading(loading: false)
    router.showAlert(for: error)
  }
}
