import Foundation

class HtmlElement: CustomStringConvertible
{
    var name = ""
    var text = ""
    var elements = [HtmlElement]()
    private let indentSize = 2

    init(){}
    init(_ name:String, _ text:String)
    {
        self.name = name
        self.text = text
    }

    private func description(_ indent: Int) -> String
    {
        var result = ""
        let i = String(repeating: " ", count: indentSize*indent)
        result += "\(i)<\(name)>\n"

        if !text.isEmpty
        {
            result += String(repeating: " ", count: indentSize*(indent+1))
            result += text
            result += "\n"
        }

        for e in elements
        {
            result += e.description(indent+1)
        }

        result += "\(i)</\(name)>\n"

        return result
    }

    public var description: String
    {
        return description(0)
    }
}

class HtmlBuilder: CustomStringConvertible
{
    private let rootName: String
    var root = HtmlElement()

    init(_ rootName: String)
    {
        self.rootName = rootName
        root.name = rootName
    }

    func addChild(_ name: String, _ text: String)
    {
        let e = HtmlElement(name, text)
        root.elements.append(e)
    }

    func addChildFluent(_ name: String, _ text: String) -> HtmlBuilder
    {
        let e = HtmlElement(name, text)
        root.elements.append(e)
        return self
    }

    var description: String
    {
        return root.description
    }

    func clear()
    {
        root = HtmlElement(rootName, "")
    }
}

func main()
{
    let builder = HtmlBuilder("ul")
    builder.addChildFluent("li", "hello")
           .addChildFluent("li", "world")

    print(builder)
}

main()