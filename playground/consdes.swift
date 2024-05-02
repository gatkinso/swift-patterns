import Foundation

class BaseClass {
    var name: String

    init(_ name: String) {
        self.name = name
        print( "BaseClass init \(name)")  
    }

    deinit {
        print( "BaseClass deinit \(name)")  
    }
}

class AClass : BaseClass {
    override init(_ name: String) {
        super.init(name)
        print( "AClass init \(name)")  
    }

    deinit {
        print( "AClass deinit \(name)")  
    }
}

func main() {
    let bc = BaseClass("BaseClass")
    let ac = AClass("AClass")
}

main()