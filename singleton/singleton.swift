import Foundation

class SingletonDataBase {
    var capitals = [String: Int]()
    static var instanceCount = 0

    //singleton
    static let instance = SingletonDataBase()

    private init() {
        type(of: self).instanceCount += 1
        print("Initializing database")

        let path = "./capitals.txt"
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

func main()
{
    let db = SingletonDataBase.instance
    var city = "Tokyo"
    print("\(city) has population \(db.getPopulation(name: city))")

    let db2 = SingletonDataBase.instance
    city = "Jakarta"
    print("\(city) has population \(db2.getPopulation(name: city))")

    print("Instances of database: \(SingletonDataBase.instanceCount)")
}

main()