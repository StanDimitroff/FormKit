import UIKit
import DifferenceKit

public struct Footer: HeaderFooter, Differentiable {

  let identifier: UUID = UUID()

  public var differenceIdentifier: UUID {
    return identifier
  }

  public func isContentEqual(to source: Footer) -> Bool {
    return self.identifier == source.identifier
  }

  public typealias Selection = () -> Void

  public var nibName: String?
  public var viewClass: AnyClass?
  public var view: UIView?

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
  public func onSelect(_ closure: @escaping Selection) -> Footer {
    var footer = self
    footer.onSelect = closure
    return footer
  }
}
