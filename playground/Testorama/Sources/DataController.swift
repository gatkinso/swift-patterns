import Foundation

struct DataController {
    var networkProvider: NetworkProviding

    init(_ provider: NetworkProviding) {
        networkProvider = provider
    }
    
    func performDataRequest() -> Int {
        return networkProvider.requestData()
    }
}