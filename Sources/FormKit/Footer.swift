import UIKit
import DifferenceKit

public struct Footer: HeaderFooter, Differentiable {
  public typealias Configuration = (UIView) -> Void
  public typealias Selection = () -> Void

  let identifier: UUID = UUID()

  public var differenceIdentifier: UUID {
    return identifier
  }

  public func isContentEqual(to source: Footer) -> Bool {
    return self.identifier == source.identifier
  }

  public var nibName: String?
  public var viewClass: AnyClass?
  public var view: UIView?

  var config: Configuration?
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
  public func config(_ closure: @escaping Configuration) -> Footer {
    var footer = self
    footer.config = closure
    return footer
  }

  @discardableResult
  public func onSelect(_ closure: @escaping Selection) -> Footer {
    var footer = self
    footer.onSelect = closure
    return footer
  }
}
