//
//  SignInViewController.swift
//  ViperExample
//
//  Created by Rowan Townshend on 04/02/2019.
//  Copyright © 2019 Rowan Townshend. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
  
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

  var presenter: SignInPresentation!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension SignInViewController: SignInView {
 
  func updateLoading(loading: Bool) {
    signInButton.isUserInteractionEnabled = !loading
    loading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
  }
}
