import Foundation

class Neuron : Sequence {
    var inputs = [Neuron]()
    var outputs = [Neuron]()

    func makeIterator() -> IndexingIterator<Array<Neuron>> {
        return IndexingIterator(_elements: [self])
    }
}

class NeuronLayer : Sequence {
    private var neurons: [Neuron]

    init(_ count: Int) {
        neurons = [Neuron](repeating: Neuron(), count: count)
    }

    func makeIterator() -> IndexingIterator<Array<Neuron>> {
        return IndexingIterator(_elements: neurons)
    }
}

extension Sequence {
    func connect<Seq: Sequence>(to other:Seq)
    //func connect(to other:Sequence)               //WHY DOESN'T THIS WORK?
        where Seq.Iterator.Element == Neuron,
            Self.Iterator.Element == Neuron {
                for from in self {
                    for too in other {              //because 'to' was taken so we just use "too"
                        from.outputs.append(too)
                        too.inputs.append(from)
                    }
                }
            }
}

func main() {
    let neuron1 = Neuron()
    let neuron2 = Neuron()
    let layer1 = NeuronLayer(10)
    let layer2 = NeuronLayer(20)

    neuron1.connect(to: neuron2)
    neuron1.connect(to: layer1)
    layer1.connect(to: neuron1)
    layer1.connect(to: layer2)
}

main()