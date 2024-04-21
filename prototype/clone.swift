import Foundation

protocol Copying {
    func clone() -> Self
}

class Address: CustomStringConvertible, Copying {
    var streetAddress: String
    var city: String

    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }

    var description: String {
        return "\(streetAddress), \(city)"
    }

   func clone() -> Self {  
       return cloneImpl()  //why does this work
       //return Address(streetAddress, city) as! Address   //but this does not?  Inferred type?
   }

   private func cloneImpl<T>() -> T {
       return Address(streetAddress, city) as! T
   }
}

struct Employee: CustomStringConvertible, Copying
{
    var name: String
    var address: Address

    init(_ name: String, _ address: Address) {
        self.name = name
        self.address = address
    }

   func clone() -> Employee {   //only works with struct
       return Employee(name, address.clone())
   }

    var description: String {
        return "My name is \(name), I live at \(address)"
    }
}

func main()
{
    let geoff = Employee("Geoff", Address("315 Glenrae Dr", "Catonsville"))
    var chris = geoff.clone()

    chris.name = "Chris"
    chris.address.streetAddress = "123 Main St"

    print(geoff)

    print(chris)
}

main()