//
//  _1_6_HomeWorkTests.swift
//  11.6_HomeWorkTests
//
//  Created by Вадим Зинатуллин on 20.05.2021.
//

import XCTest
@testable import _1_6_HomeWork

class _1_6_HomeWorkTests: XCTestCase {
    
    var sut: ViewController!
    var sut2: ViewControllerCongratulations!

    override func setUpWithError() throws {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()
        
        sut2 = storyboard.instantiateViewController(withIdentifier: String(describing: ViewControllerCongratulations.self)) as? ViewControllerCongratulations
        sut2.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerIsViewController(){
        XCTAssertTrue(sut is ViewController)
    }
    
    func testSignupForm_WhenLoaded_TextFieldAreConnected() throws {
     _ = try XCTUnwrap(sut.loginTextField, "Email address UITextField is not connected")
     _ = try XCTUnwrap(sut.passwordTextField, "The Password UITextField is not connected")
    }
    
    func testEmailTextField_WhenCreated_HasEmailKeyboardTypeSet() throws {
     let emailTextField = try XCTUnwrap(sut.loginTextField, "Email address UITextField is not connected")
        
        XCTAssertEqual(emailTextField.keyboardType, UIKeyboardType.emailAddress, "Email Address UITextField does not have Email Keyboard type set")
    }
    
    func testPasswordTextField_WhenCreated_IsSecureTextEntryField() throws {
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The Password UITextField is not connected")
        
        XCTAssertTrue(passwordTextField.isSecureTextEntry, "Password UITextField is not a Secure Text Entry Fieldg")
    }
    
    func testHasLoginTextField(){
        XCTAssertNotNil(sut.loginTextField)
        XCTAssertTrue(sut.loginTextField.isDescendant(of: sut.view))
    }
    
    func testHasPasswordTextField(){
        XCTAssertNotNil(sut.passwordTextField)
        XCTAssertTrue(sut.passwordTextField.isDescendant(of: sut.view))
    }
    
    
    func testIsValidPassword(){
        sut.passwordTextField.text = "Password1"
        
        XCTAssertTrue(sut.passwordTextField.text!.isValidPassword())
    }
    
    func testIsValidEmail(){
        sut.loginTextField.text = "vadim@mail.ru"
        
        XCTAssertTrue(sut.loginTextField.text!.isValidEmail())
    }
    
    func testLoginButtonHasLoginMetod(){
        let loginButton = sut.buttonSignin
        
        guard let actions = loginButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }

        XCTAssertTrue(actions.contains("signInButton"))
    }
    
    func testLogin(){
        sut.loginTextField.text = "vadim@mail.ru"
        sut.passwordTextField.text = "Password1"
        
        sut.signInButton()

        XCTAssertEqual(sut.errorLabel.text, "Ok")


    }

}
