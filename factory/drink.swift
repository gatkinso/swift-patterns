import Foundation

protocol HotDrink {
    func consume()
}

class Tea : HotDrink {
    func consume() {
        print("I'd rather have coffee")
    }
}

class Coffee : HotDrink {
    func consume() {
        print("This is great coffee")
    }
}

protocol HotDrinkFactory {
    init()
    func prepare(amount: Int) -> HotDrink
}

class TeaFactory : HotDrinkFactory {
    required init() {}
    func prepare(amount: Int) -> HotDrink {
        print("Add tea bag to \(amount)ml of hot water")
        return Tea()
    }
}

class CoffeeFactory : HotDrinkFactory {
    required init() {}
    func prepare(amount: Int) -> HotDrink {
        print("Add \(amount) scoops of coffee to hot water")
        return Coffee()
    }
}

class HotDrinkMachine {
    enum AvailableDrink : String {  //breaks OCP
        case coffee = "Coffee"
        case tea = "Tea"

        static let all = [coffee,tea]
    }

    internal var factories = [AvailableDrink: HotDrinkFactory]() // i

    internal var namedFactories = [(String, HotDrinkFactory)]() // ii

    init() {
        for drink in AvailableDrink.all {
            let type = NSClassFromString("drink.\(drink.rawValue)Factory")
            let factory = (type as! HotDrinkFactory.Type).init()

            factories[drink] = factory // i
            namedFactories.append((drink.rawValue, factory)) // ii
        }
    }

    func makeDrink() -> HotDrink {
        print("Available Drinkks...")
        for i in 0..<namedFactories.count {
            let tuple = namedFactories[i]
            print("\(i):  \(tuple.0)")
        }
        let input = Int(readLine()!)!
        return namedFactories[input].1.prepare(amount: 10)
    }
}

func main()
{
    let machine = HotDrinkMachine()
    print(machine.namedFactories.count)
    let drink = machine.makeDrink()
    drink.consume()
}

main()