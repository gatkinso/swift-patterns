import Foundation

class Point : CustomStringConvertible{
    private var x, y : Double

    private init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    private init(rho: Double, theta:Double) {
        self.x = rho * cos(theta)
        self.y = rho * sin(theta)
    }

    var description: String {
        return "X = \(x) Y = \(y)"
    }

    static let factory = Pointfactory.instance

    class Pointfactory {
        static let instance = Pointfactory()

        private init() {}

        func createCartesian(x: Double, y: Double) -> Point {
            return Point(x: x, y: y)
        }

        func createPolar(rho: Double, theta: Double) -> Point {
            return Point(rho: rho, theta: theta)
        }
    }
}

func main()
{
    //let pf = Point.Pointfactory()
    let p = Point.factory.createCartesian(x: 1, y: 2)
    print(p)
}

main()