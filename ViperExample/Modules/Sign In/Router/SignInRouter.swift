//
//  SignInRouter.swift
//  ViperExample
//
//  Created by Rowan Townshend on 04/02/2019.
//  Copyright © 2019 Rowan Townshend. All rights reserved.
//

import UIKit

class SignInRouter: SignInRoutable {
  
  class func create() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc =  storyboard.instantiateViewController(withIdentifier: "SignInIdentifier") as! SignInView & UIViewController
    let presenter = SignInPresenter()
    let router = SignInRouter()
    router.viewController = vc
    
    let interactor = SignInInteractor()
    interactor.output = presenter
    
    presenter.view = vc
    presenter.router = router
    presenter.interactor = interactor
    
    vc.presenter = presenter
    
    return vc
  }
  
  var viewController: UIViewController?
  
  func showAlert(for error: Error) {
    let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    viewController?.present(alert, animated: true, completion: nil)
  }
}
