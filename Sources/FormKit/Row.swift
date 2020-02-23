import UIKit
import DifferenceKit

public struct Row: Reusable, Differentiable {

  public var differenceIdentifier: UUID {
    return identifier
  }
  
  public func isContentEqual(to source: Row) -> Bool {
     return self.identifier == source.identifier
  }

  public typealias Selection = () -> Void
  public typealias Deletion = () -> Void
  public typealias ValueChange = (String) -> Void

  typealias Scroll = () -> Void

  var onSelect: Selection?
  var onDelete: Deletion?
  var onValueChange: ValueChange?
  var onScroll: Scroll?

  let identifier: UUID = UUID()
  var editingStyle: UITableViewCell.EditingStyle?
  var rowAnimation: UITableView.RowAnimation?
  var deleteTitle: String?

  var nibName: String?
  var viewClass: AnyClass?
  var height: CGFloat?
  var estimatedHeight: CGFloat?

  public var title: String?
  public var value: String?


  //private var observations = [(T) -> Bool]()
  //private var lastValue: T?

  var obj: Any?

  public init(_ nibName: String, title: String? = nil, height: CGFloat? = nil) {
    self.nibName = nibName
    self.title = title
    self.height = height
    //lastValue = value
  }

  public init(_ viewClass: AnyClass, title: String? = nil, height: CGFloat? = nil) {
    self.viewClass = viewClass
    self.title = title
    self.height = height
    //lastValue = value
  }

  // MARK: - Modifiers
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
  public func bind<Root, Input>(_ object: Root, keyPath: WritableKeyPath<Root, Input>) -> Row {
    var row = self
    //row.model = model
    //print(type.Model.self)
//    print(object)
//    print(object[keyPath: keyPath])
//    print(keyPath)

    //print(obj![keyPath: keyPath])
    //print(Root.Type.self)

    row.value = "\(object[keyPath: keyPath])"

//    if var user = object as? T.Model {
//      print("USER")
//
//
//    }



    //    if let model = object as? FormModel, let kp = keyPath as? WritableKeyPath<FormModel, String> {
//      row.bind = (model, kp)
//    }
    return row
  }

  @discardableResult
  public func rowAnimation(_ animation: UITableView.RowAnimation) -> Row {
    var row = self
    row.rowAnimation = animation
    return row
  }

  @discardableResult
  public func deleteTitle(_ title: String) -> Row {
    var row = self
    row.deleteTitle = title
    return row
  }

  @discardableResult
  public func scrollHere(if condition: Bool) -> Row {
    if condition { onScroll?() }
    return self
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

  @discardableResult
  public func valueChanged(_ closure: @escaping ValueChange) -> Row {
    var row = self
    row.onValueChange = closure
    return row
  }
}
