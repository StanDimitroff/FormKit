import UIKit

public struct Row: Reusable {
  public typealias Selection = () -> Void
  public typealias Deletion = () -> Void

  var onSelect: Selection?
  var onDelete: Deletion?
  var editingStyle: UITableViewCell.EditingStyle?

  public var nibName: String?
  public var viewClass: AnyClass?
  var height: CGFloat?
  var estimatedHeight: CGFloat?

  public init(nibName: String, height: CGFloat? = nil) {
    self.nibName = nibName
    self.height = height
  }

  public init(viewClass: AnyClass, height: CGFloat? = nil) {
    self.viewClass = viewClass
    self.height = height
  }

  @discardableResult
  public func height(_ height: CGFloat) -> Row {
    var row = self
    row.height = height
    return row
  }

  @discardableResult
  public func estimatedHeight(_ height: CGFloat) -> Row {
    var row = self
    row.estimatedHeight = height
    return row
  }

  @discardableResult
  public func editingStyle(_ style: UITableViewCell.EditingStyle) -> Row {
    var row = self
    row.editingStyle = style
    return row
  }

  @discardableResult
  public func onSelect(_ closure: @escaping Selection) -> Row {
    var row = self
    row.onSelect = closure
    return row
  }

  @discardableResult
  public func onDelete(_ closure: @escaping Deletion) -> Row {
    var row = self
    row.onDelete = closure
    return row
  }
}
