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
