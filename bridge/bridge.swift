import Foundation

protocol Renderer {
    func renderCircle(_ radius: Float)
}

class VectorRenderer : Renderer {
    func renderCircle(_ radius: Float) {
        print("Drawing a circle with lines radius \(radius)")
    }
}

class RasterRenderer : Renderer {
    func renderCircle(_ radius: Float) {
        print("Drawing a circle with pixels radius \(radius)")
    }
}

protocol Shape {
    func draw()
    func resize(_ factor: Float)
}

class Circle : Shape {
    var radius: Float
    var renderer: Renderer

    init(_ renderer: Renderer, _ radius: Float) {
        self.renderer = renderer
        self.radius = radius
    }

    func draw() {
        renderer.renderCircle(radius)
    }

    func resize(_ factor: Float) {
        radius *= factor
    }
}

func main() {
    //let ren = RasterRenderer()
    let ren = VectorRenderer()
    let circle = Circle(ren, 5)

    circle.draw()
    circle.resize(2)
    circle.draw()
}

main()
