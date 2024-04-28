import Foundation
import XCTest

protocol Database
{
  func getPopulation(name: String) -> Int
}

class SingletonDatabase {
    var capitals = [String : Int]()  //dictionary
    static var instanceCount = 0

    //singleton
    static let instance = SingletonDatabase()

    private init() {
        type(of: self).instanceCount += 1
        print("Initializing database")

        let path = "../capitals.txt"  // OUR "LIVE" DATABSE - WARNING THIS IS FRAGILE
        if let text = try? String(contentsOfFile: path,
                                    encoding: String.Encoding.utf8) {
            let strings = text.components(separatedBy: .newlines)
                                .filter { !$0.isEmpty }
                                .map { $0.trimmingCharacters(in: .whitespaces) }

            for i in  0..<(strings.count/2) {
                capitals[strings[i*2]] = Int(strings[i*2+1])!
            }
        }
    }

    func getPopulation(name: String) -> Int {
        return capitals[name]!
    }
}

class SingletonRecordFinder {
  func totalPopulation(names: [String]) -> Int
  {
    var result = 0
    for name in names {
      // singleton database hardcoded here
      result += SingletonDatabase.instance.getPopulation(name: name);
    }
    return result
  }
}

class ConfigurableRecordFinder {
  let database: Database
  init(database: Database)
  {
    self.database = database
  }

  func totalPopulation(names: [String]) -> Int
  {
    var result = 0
    for name in names {
      result += database.getPopulation(name: name);
    }
    return result
  }
}

class DummyDatabase : Database
{
    func getPopulation(name: String) -> Int {
      return ["alpha": 1, "beta": 2, "gamma": 3][name]!
    }
}

class SingletonTests: XCTestCase
{
  static var allTests = [
    ("test_isSingletonTest", test_isSingletonTest),
    ("test_singletonTotalPopulationTest", test_singletonTotalPopulationTest),
    ("test_dependantTotalPopulationTest", test_dependantTotalPopulationTest)
  ]

  func test_isSingletonTest()
  {
    var db = SingletonDatabase.instance
    var db2 = SingletonDatabase.instance
    XCTAssertEqual(1, SingletonDatabase.instanceCount, "instance count must = 1")
  }

  func test_singletonTotalPopulationTest()  // BAD TEST
  {
    let rf = SingletonRecordFinder()
    let names = ["Tokyo", "New York"]
    let tp = rf.totalPopulation(names: names)
    XCTAssertEqual(1111111+2222222, tp, "population size must match")
  }

  func test_dependantTotalPopulationTest() {  //GOOD TEST USING DEPENDENCY INJECTION
    let db = DummyDatabase()
    let rf = ConfigurableRecordFinder(database: db)
    XCTAssertEqual(4, rf.totalPopulation(names: ["alpha", "gamma"]))  //sum of alpha and gamma
  }
}

//XCTMain([testCase(SingletonTests.allTests)])