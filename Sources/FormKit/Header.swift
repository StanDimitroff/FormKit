import UIKit
import DifferenceKit

public struct Header: HeaderFooter, Differentiable {
  public typealias Selection = () -> Void

  let identifier: UUID = UUID()
  public var nibName: String?
  public var viewClass: AnyClass?
  public var view: UIView?

  public var differenceIdentifier: UUID {
    return identifier
  }

  public func isContentEqual(to source: Header) -> Bool {
    return self.identifier == source.identifier
  }

  var onSelect: Selection?

  public init(nibName: String) {
    self.nibName = nibName
  }

  public init(viewClass: AnyClass) {
    self.viewClass = viewClass
  }

  public init(view: UIView) {
    self.view = view
  }

  @discardableResult
  public func onSelect(_ closure: @escaping Selection) -> Header {
    var header = self
    header.onSelect = closure
    return header
  }
}
