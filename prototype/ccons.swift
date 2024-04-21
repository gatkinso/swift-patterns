import Foundation

protocol Copying {
    init(copyFrom other: Self)
}

class Address: CustomStringConvertible, Copying {
    var streetAddress: String
    var city: String

    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }

    required init(copyFrom other: Address) {
        streetAddress = other.streetAddress
        city = other.city
    }

    var description: String {
        return "\(streetAddress), \(city)"
    }
}

class Employee: CustomStringConvertible, Copying
{
    var name: String
    var address: Address

    init(_ name: String, _ address: Address) {
        self.name = name
        self.address = address
    }

    required init(copyFrom other: Employee) {
        name = other.name
        address = Address(copyFrom: other.address)
    }

    var description: String {
        return "My name is \(name), I live at \(address)"
    }
}

func main()
{
    let geoff = Employee("Geoff", Address("315 Glenrae Dr", "Catonsville"))
    let chris = Employee(copyFrom: geoff)

    chris.name = "Chris"
    chris.address.streetAddress = "123 Main St"

    print(geoff)

    print(chris)


}

main()