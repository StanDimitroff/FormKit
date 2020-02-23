import UIKit

protocol FormSection {
  var identifier: UUID { get }
  var header: Header? { get set }
  var footer: Footer? { get set }
  var rows: [Row] { get set }
}

protocol Reusable {
  var identifier: UUID { get }
  var nibName: String? { get set }
  var viewClass: AnyClass? { get set }
}

protocol HeaderFooter: Reusable {
  var view: UIView? { get set }
}

public protocol Bindable {

  associatedtype Model//: FormModel
  //var value: PartialKeyPath<Self>? { get set }
}

public protocol FormModel {
}


extension Reusable {
  var identifier: String {
    if let nibName = nibName {
      return nibName
    } else if let viewClass = viewClass {
      return String(describing: viewClass)
    } else {
      fatalError("No view reuse identifier provided")
    }
  }
}

public protocol Configurable: class { }

public extension Configurable where Self: UITableViewCell {
  func config(_ block: (Self) throws -> Void) rethrows -> Self {
    try block(self)
    return self
  }
}




class Bindable1<Value> {
    private var observations = [(Value) -> Bool]()
    private var lastValue: Value?

    init(_ value: Value? = nil) {
        lastValue = value
    }
}

private extension Bindable1 {
    func addObservation<O: AnyObject>(
        for object: O,
        handler: @escaping (O, Value) -> Void
    ) {
        // If we already have a value available, we'll give the
        // handler access to it directly.
        lastValue.map { handler(object, $0) }

        // Each observation closure returns a Bool that indicates
        // whether the observation should still be kept alive,
        // based on whether the observing object is still retained.
        observations.append { [weak object] value in
            guard let object = object else {
                return false
            }

            handler(object, value)
            return true
        }
    }
}

extension Bindable1 {
    func bind<O: AnyObject, T>(
        _ sourceKeyPath: KeyPath<Value, T>,
        to object: O,
        _ objectKeyPath: ReferenceWritableKeyPath<O, T>
    ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            object[keyPath: objectKeyPath] = value
        }
    }
}
