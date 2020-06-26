import UIKit

public protocol FormCell: AnyObject {
  func configure(row: Row)
  var valueChange: ((String) -> Void)? { get set }
}
