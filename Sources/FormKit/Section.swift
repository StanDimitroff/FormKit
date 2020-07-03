import UIKit
import DifferenceKit

public struct Section: FormSection, DifferentiableSection {
  public var elements: Array<Row> {
    return rows
  }

  public init<C>(source: Section, elements: C) where C : Collection, C.Element == Row { }

  init(rows: [Row]) {
    self.rows = rows
  }

  public var differenceIdentifier: UUID {
    return identifier
  }

  public func isContentEqual(to source: Section) -> Bool {
    return self == source
  }

  // MARK: - Properties
  let identifier: UUID = UUID()
  var headerTitle: String?
  var footerTitle: String?
  var header: Header?
  internal(set) public var rows: [Row] = []
  var footer: Footer?
  var headerHeight: CGFloat?
  var footerHeight: CGFloat?
  var estimatedHeaderHeight: CGFloat?
  var estimatedFooterHeight: CGFloat?
  var rowHeight: CGFloat?
  var editingStyle: UITableViewCell.EditingStyle?
  var rowAnimation: UITableView.RowAnimation?
  var deletionTitle: String?
}

extension Section {
  public init(@SectionBuilder content: () -> Row) {
    self.rows = [content()]
  }

  public init(@SectionBuilder content: () -> [Row]) {
    self.rows = content()
  }
}

// MARK: - Modifiers
extension Section {

  /// Sets header title for this section
  /// - Parameter title: the specified header title
  @discardableResult
  public func headerTitle(_ title: String) -> Section {
    var section = self
    section.headerTitle = title
    return section
  }

  /// Sets footer title for this section
  /// - Parameter title: the specified footer title
  @discardableResult
  public func footerTitle(_ title: String) -> Section {
    var section = self
    section.footerTitle = title
    return section
  }

  /// Applies header height for this section
  /// - Parameter height: the specified header height
  @discardableResult
  public func headerHeight(_ height: CGFloat) -> Section {
    var section = self
    section.headerHeight = height
    return section
  }

  /// Applies footer height for this section
  /// - Parameter height: the specified footer height
  @discardableResult
  public func footerHeight(_ height: CGFloat) -> Section {
    var section = self
    section.footerHeight = height
    return section
  }

  @discardableResult
  public func estimatedHeaderHeight(_ height: CGFloat) -> Section {
    var section = self
    section.estimatedHeaderHeight = height
    return section
  }

  @discardableResult
  public func estimatedFooterHeight(_ height: CGFloat) -> Section {
    var section = self
    section.estimatedFooterHeight = height
    return section
  }

  /// Applies row height to the entire section
  /// - Parameter height: the specified height
  @discardableResult
  public func rowHeight(_ height: CGFloat) -> Section {
    var section = self
    section.rowHeight = height
    return section
  }

  /// Applies header view for this section
  /// - Parameter header: the specified header
  @discardableResult
  public func header(_ header: Header) -> Section {
    var section = self
    section.header = header
    return section
  }

  /// Applies footer view for this section
  /// - Parameter footer: the specified footer
  @discardableResult
  public func footer(_ footer: Footer) -> Section {
    var section = self
    section.footer = footer
    return section
  }

  /// Applies `UITableViewCell.EditingStyle` to the entire section
  /// - Parameter style: the specified `UITableViewCell.EditingStyle`
  @discardableResult
  public func editingStyle(_ style: UITableViewCell.EditingStyle) -> Section {
    var section = self
    section.editingStyle = style
    return section
  }

  /// Applies `UITableViewCell.RowAnimation` to the entire section
  /// - Parameter style: the specified `UITableViewCell.RowAnimation`
  @discardableResult
  public func rowAnimation(_ animation: UITableView.RowAnimation) -> Section {
    var section = self
    section.rowAnimation = animation
    return section
  }

  /// Sets `(_:titleForDeleteConfirmationButtonForRowAt:)`for all rows in this section
  /// - Parameter title: the specified title
  @discardableResult
  public func deletionTitle(_ title: String) -> Section {
    var section = self
    section.deletionTitle = title
    return section
  }

  /// Adds rows to the end of this section
  /// - Parameter rows: the rows which will be added
  @discardableResult
  public func addRows(_ rows: Row...) -> Section {
    var section = self
    section.rows.append(contentsOf: rows)
    return section
  }

  /// Adds rows to the end of this section
  /// - Parameter rows: the rows which will be added
  @discardableResult
  public func addRows(_ rows: [Row]) -> Section {
    var section = self
    section.rows.append(contentsOf: rows)
    return section
  }

  /// Inserts rows in this section at specified index
  /// - Parameters:
  ///   - rows: the rows which will be inserted
  ///   - index: the index where row will be inserted
  @discardableResult
  public func insertRows(_ rows: [Row], at index: Int) -> Section {
    var section = self
    section.rows.insert(contentsOf: rows, at: index)
    return section
  }

  /// Inserts rows in this section at specified index
  /// - Parameters:
  ///   - rows: the rows which will be inserted
  ///   - index: the index where row will be inserted
  @discardableResult
  public func insertRows(_ rows: Row..., at index: Int) -> Section {
    var section = self
    section.rows.insert(contentsOf: rows, at: index)
    return section
  }
}

extension Section: Equatable {
  public static func == (lhs: Section, rhs: Section) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
