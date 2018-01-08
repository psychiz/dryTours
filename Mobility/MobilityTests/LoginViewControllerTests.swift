
//

import XCTest
@testable import Mobility

class LoginViewControllerTests: XCTestCase {
    
    //Url for testing with login authentication
   
    let viewController = LoginViewController()
   
   
    
    var sessionUnderTest: URLSession!
    override func setUp() {
        super.setUp()
          sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func testUsername()
    {
        var username = viewController.userNameTextField.text
        XCTAssertNil(username)
        
    }
    
    
    func testPassword()
    {
        var password = viewController.passwordTextField.text
        XCTAssertNil(password)
        
    }
    
    func testLoginSegue()
    {
        var login = viewController.shouldPerformSegue(withIdentifier:  "LoginSuccessSegue", sender: self)
        
        
    }
    
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
  
    
    
    //Test asynchronous login request
    
    func testValidCallToMobilityServerGetsHTTPStatusCode() {
        // given
        let url = URL(string: "http://localhost:8080/mocked/login")
        // 1
        let promise = expectation(description: "Status code: ")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 404 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
