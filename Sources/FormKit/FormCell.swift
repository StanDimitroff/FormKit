import UIKit

public protocol FormCell: AnyObject {
  func configure(row: Row)
  var value: String { get set }
  var valueChange: ((String) -> Void)? { get set }
}

extension FormCell {

}
