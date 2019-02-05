//
//  SignInInteractorTest.swift
//  ViperExampleTests
//
//  Created by Rowan Townshend on 04/02/2019.
//  Copyright © 2019 Rowan Townshend. All rights reserved.
//

import XCTest
@testable import ViperExample

class SignInInteractorTest: XCTestCase {
  
  var sut: SignInInteractor?
  var mockOutput: MockSignInInteractorOutput?
  
  override func setUp() {
    sut = SignInInteractor()
    mockOutput = MockSignInInteractorOutput()
    sut?.fetcher = MockDataFetcher()
    sut?.output = mockOutput
    super.setUp()
  }
  
  override func tearDown() {
    sut = nil
    mockOutput = nil
    super.tearDown()
  }
  
  func testFailsWithEmptyUsername() {
    sut?.signIn(username: "")
    XCTAssertFalse(mockOutput!.isSuccess)
    XCTAssertEqual(mockOutput!.error?.localizedDescription, SignInErrorCodes.empty.localizedDescription)
  }
  
  func testFailsWithOnlySpacesInUsername() {
    sut?.signIn(username: "    ")
    XCTAssertFalse(mockOutput!.isSuccess)
    XCTAssertEqual(mockOutput!.error?.localizedDescription, SignInErrorCodes.empty.localizedDescription)
  }
  
  func testFailsIfOver20CharacterLimit() {
    sut?.signIn(username: "test.verylongusernamewhichisoverthelimit")
    XCTAssertFalse(mockOutput!.isSuccess)
    XCTAssertEqual(mockOutput!.error?.localizedDescription, SignInErrorCodes.tooLong.localizedDescription)
  }
  
  func testPassesWithCorrectUsername() {
    sut?.signIn(username: "test.viper")
    XCTAssertTrue(mockOutput!.isSuccess)
    XCTAssertNil(mockOutput?.error)
  }
}

class MockSignInInteractorOutput: SignInInteractorOutput {
  
  var isSuccess = false
  var error: Error?
  
  func success() {
   isSuccess = true
  }
  
  func failed(error: Error) {
    self.error = error
  }
}

class MockDataFetcher: NetworkDataFetcher {
  
  var response: NetworkDataFetcherResponse!
  var request: URLRequest!
  
  func start() {
    response.fetcherResponseSuccess()
  }
}

