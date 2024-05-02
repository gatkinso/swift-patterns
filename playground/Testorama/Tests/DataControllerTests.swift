import Foundation
import XCTest

@testable import Testorama

class DataControllerTests: XCTestCase
{
  func test_ProductionCode()
  {
    let provider = NetworkProvider()
    let controller = DataController(provider)

    let elapsed = controller.performDataRequest()

    XCTAssertFalse(elapsed < 10, "Test is meant to take too long")
  }

  func test_MockCode() 
  {
    let provider = MockedNetworkProvider()
    let controller = DataController(provider)

    let elapsed = controller.performDataRequest()

    XCTAssertTrue(elapsed < 10, "Test Took too long")
  }

  func test_LookupFails() 
  {
    let provider = MockedNetworkProvider()
    let controller = DataController(provider)

    provider.lookupRet = false

    let result = controller.doLookup()
    XCTAssertFalse(result, "Test should have failed")
  }

  func test_LookupSuccess() 
  {
    let provider = MockedNetworkProvider()
    let controller = DataController(provider)

    let result = controller.doLookup()
    XCTAssertTrue(result, "Test Failed")
  }
}
