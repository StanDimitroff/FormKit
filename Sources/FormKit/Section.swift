import UIKit
import DifferenceKit

public struct Section: FormSection, DifferentiableSection {
  public var elements: Array<Row> {
    return rows
  }

  public init<C>(source: Section, elements: C) where C : Collection, C.Element == Row { }

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
  var rows: [Row] = []
  var footer: Footer?
  var headerHeight: CGFloat?
  var footerHeight: CGFloat?
  var estimatedHeaderHeight: CGFloat?
  var estimatedFooterHeight: CGFloat?
  var rowHeight: CGFloat?
  var editingStyle: UITableViewCell.EditingStyle?
  var rowAnimation: UITableView.RowAnimation?
  var deleteTitle: String?
}

extension Section {
  public init(headerTitle: String, footerTitle: String, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.headerTitle = headerTitle
    self.footerTitle = footerTitle
    self.rowHeight = rowHeight
    self.rows = [content()]
  }

  public init(headerTitle: String, footerTitle: String, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.headerTitle = headerTitle
    self.footerTitle = footerTitle
    self.rowHeight = rowHeight
    self.rows = content()
  }
}

extension Section {
  public init(headerTitle: String, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.headerTitle = headerTitle
    self.rowHeight = rowHeight
    self.rows = [content()]
  }

  public init(headerTitle: String, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.headerTitle = headerTitle
    self.rowHeight = rowHeight
    self.rows = content()
  }
}

extension Section {
  public init(footerTitle: String, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.footerTitle = footerTitle
    self.rowHeight = rowHeight
    self.rows = [content()]
  }

  public init(footerTitle: String, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.footerTitle = footerTitle
    self.rowHeight = rowHeight
    self.rows = content()
  }
}

extension Section  {
  public init(header: Header, footer: Footer, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = header
    self.rows = [content()]
    self.footer = footer
    self.rowHeight = rowHeight
  }

  public init(header: Header, footer: Footer, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = header
    self.rows = content()
    self.footer = footer
    self.rowHeight = rowHeight
  }
}

extension Section {
  public init(header: Header, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = header
    self.rows = [content()]
    self.footer = nil
    self.rowHeight = rowHeight
  }

  public init(header: Header, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = header
    self.rows = content()
    self.footer = nil
    self.rowHeight = rowHeight
  }
}

extension Section {
  public init(footer: Footer, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = nil
    self.rows = [content()]
    self.footer = footer
    self.rowHeight = rowHeight
  }

  public init(footer: Footer, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = nil
    self.rows = content()
    self.footer = footer
    self.rowHeight = rowHeight
  }
}

extension Section {
  public init(rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = nil
    self.rows = [content()]
    self.footer = nil
    self.rowHeight = rowHeight
  }

  public init(rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = nil
    self.rows = content()
    self.footer = nil
    self.rowHeight = rowHeight
  }
}

// MARK: - Modifiers
extension Section {
  @discardableResult
  public func headerTitle(_ title: String) -> Section {
    var section = self
    section.headerTitle = title
    return section
  }

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

  @discardableResult
  public func header(_ header: Header) -> Section {
    var section = self
    section.header = header
    return section
  }

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

  @discardableResult
  public func deleteTitle(_ title: String) -> Section {
    var section = self
    section.deleteTitle = title
    return section
  }

  @discardableResult
  public func addRows(_ rows: Row...) -> Section {
    var section = self
    section.rows.append(contentsOf: rows)
    return section
  }

  @discardableResult
  public func addRows(_ rows: [Row]) -> Section {
    var section = self
    section.rows.append(contentsOf: rows)
    return section
  }
}

extension Section: Equatable {
  public static func == (lhs: Section, rhs: Section) -> Bool {
    return lhs.identifier == rhs.identifier
  }


}
