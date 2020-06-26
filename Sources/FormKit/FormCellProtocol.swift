import UIKit

public protocol FormCellProtocol: AnyObject {
  func configure(row: Row)
  var valueChange: ((String) -> Void)? { get set }
}
