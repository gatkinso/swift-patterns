import Foundation

enum Color {
    case red
    case green
    case blue
}

enum Size {
    case small
    case medium
    case large
    case yuge
}

class Product
{
    var name: String
    var color: Color
    var size: Size

    init(_ name: String, _ color: Color, _ size: Size)
    {
        self.name = name
        self.color = color
        self.size = size
    }
}

protocol Specification
{
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter
{
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T]
        where Spec.T == T;
}

class ColorSpecification : Specification
{
    typealias T = Product
    let color: Color
    init(_ color: Color)
    {
        self.color = color
    }

    func isSatisfied(_ item: T) -> Bool
    {
        return item.color == color
    }
}

class BetterFilter : Filter{
    typealias T = Product

    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T]
        where Spec.T == T
        {
            var result = [Product]()
            for i in items
            {
                if spec.isSatisfied(i)
                {
                    result.append(i)
                }
            }
            return result
        }
}

func main()
{
    let apple = Product("Apple", .green, .small)
    let tree = Product("Tree", .green, .large)
    let house = Product("Tree", .blue, .large)

    let products = [apple, tree, house]

    let bf = BetterFilter()

    print("Greens:")

    for p in bf.filter(products, ColorSpecification(.green))
    {
        print(" - \(p.name) is green")
    }
}

main()