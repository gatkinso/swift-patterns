import Foundation

protocol NetworkProviding {
    var elapsedTimeMs: Int { get set }

    func requestData() -> Int

    func someExpensiveLookup() -> Bool
}

class NetworkProvider: NetworkProviding {
    var elapsedTimeMs: Int

    init() {
        self.elapsedTimeMs = 90000
    }

    func requestData() -> Int {
        return self.elapsedTimeMs
    }

    func someExpensiveLookup() -> Bool {
        return true
    }
}
 
class MockedNetworkProvider: NetworkProviding {
    var elapsedTimeMs: Int

    var lookupRet: Bool

    init() {
        self.elapsedTimeMs = 1
        self.lookupRet = true
    }

    func requestData() -> Int {
        self.elapsedTimeMs = 1
        return self.elapsedTimeMs
    }

    func someExpensiveLookup() -> Bool {
        return lookupRet
    }
}