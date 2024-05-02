import Foundation
import XCTest

@testable import Testorama

class DataControllerTests: XCTestCase
{
  static var allTests = [
    ("test_NoMockTest", test_NoMockTest),
    ("test_MockTest", test_MockTest),
  ]

  func test_NoMockTest()
  {
    let provider = NetworkProvider()
    let controller = DataController(provider)

    let elapsed = controller.performDataRequest()

    XCTAssertFalse(elapsed < 10, "Test is meant to take too long")
  }

  func test_MockTest() 
  {
    let provider = MockedNetworkProvider()
    let controller = DataController(provider)

    let elapsed = controller.performDataRequest()

    XCTAssertTrue(elapsed < 10, "Test Took too long")
  }
}
