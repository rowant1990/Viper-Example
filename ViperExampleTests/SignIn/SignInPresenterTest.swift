//
//  SignInPresenterTest.swift
//  ViperExampleTests
//
//  Created by Rowan Townshend on 04/02/2019.
//  Copyright © 2019 Rowan Townshend. All rights reserved.
//

import XCTest
@testable import ViperExample

class SignInPresenterTest: XCTestCase {
  
  var sut: SignInPresenter?
  var mockView: MockSignInView?
  var mockInteractor: MockSignInInteractor?
  var mockRouter: MockSignInRouter?

  override func setUp() {
    sut = SignInPresenter()
    mockView = MockSignInView()
    mockInteractor = MockSignInInteractor()
    mockRouter = MockSignInRouter()
    mockInteractor?.output = sut
    sut?.view = mockView
    sut?.interactor = mockInteractor
    sut?.router = mockRouter
    super.setUp()
  }
  
  override func tearDown() {
    sut = nil
    mockView = nil
    mockInteractor = nil
    mockRouter = nil
    super.tearDown()
  }
  
  func testViewLoadingStateChangesWhenSignIn() {
    mockInteractor?.noReturn = true
    sut?.signIn(username: "")
    XCTAssertTrue(mockView?.loading ?? false)
  }
  
  func testInteractorStartsSignInProcess() {
    sut?.signIn(username: "")
    XCTAssertTrue(mockInteractor?.processing ?? false)
  }
  
  func testUpdatesViewWhenSuccessIsReturned() {
    sut?.signIn(username: "")
    XCTAssertFalse(mockView?.loading ?? true)
  }
  
  func testWhenFailureItUpdatesView() {
    mockInteractor?.fail = true
    sut?.signIn(username: "")
    XCTAssertFalse(mockView?.loading ?? true)
  }
  
  func testWhenFailureItShowsErrorWithRouter() {
    mockInteractor?.fail = true
    sut?.signIn(username: "")
    XCTAssertTrue(mockRouter?.showAlert ?? false)
  }
}

class MockSignInView: SignInView {
  
  var loading = false
  var presenter: SignInPresentation!
  
  func updateLoading(loading: Bool) {
    self.loading = loading
  }
}

class MockSignInInteractor: SignInInteraction {
  
  var processing = false
  var fail = false
  var noReturn = false
  var output: SignInInteractorOutput?
  var fetcher: NetworkDataFetcher! = MockDataFetcher()
  
  func signIn(username: String) {
    self.processing = true
    guard !noReturn else { return }
    if fail {
      output?.failed(error: SignInErrorCodes.empty)
    } else {
      output?.success()
    }
  }
}

class MockSignInRouter: SignInRoutable {
  
  var showAlert = false
  var viewController: UIViewController?
  
  func showAlert(for error: Error) {
    showAlert = true
  }
}
