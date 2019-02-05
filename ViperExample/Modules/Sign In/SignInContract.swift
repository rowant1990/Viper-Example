//
//  SignInContract.swift
//  ViperExample
//
//  Created by Rowan Townshend on 04/02/2019.
//  Copyright © 2019 Rowan Townshend. All rights reserved.
//

import UIKit

protocol SignInPresentation {
  var view: SignInView? { get set }
  var router: SignInRoutable! { get set }
  var interactor: SignInInteraction! { get set }
  
  func signIn(username: String)
}

protocol SignInView: class {
  var presenter: SignInPresentation! { get set }
  
  func updateLoading(loading: Bool)
}

protocol SignInInteraction: class {
  var output: SignInInteractorOutput? { get set }
  var fetcher: NetworkDataFetcher! { get set }
  
  func signIn(username: String)
}

protocol SignInInteractorOutput: class {
  func success()
  func failed(error: Error)
}

protocol SignInRoutable: class {
  var viewController: UIViewController? { get set }
  
  func showAlert(for error: Error)
}
