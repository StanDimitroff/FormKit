import UIKit

public struct Header: HeaderFooter {
  public var nibName: String?
  public var viewClass: AnyClass?

  public init(nibName: String) {
    self.nibName = nibName
  }

  public init(viewClass: AnyClass) {
    self.viewClass = viewClass
  }
}
