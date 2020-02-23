import UIKit
import DifferenceKit

final public class Form: NSObject {

  // MARK: - Properties
  private var tableView: UITableView
  private var rowAnimation: UITableView.RowAnimation?

  var sections: [Section] = []
  var headerHeight: CGFloat?
  var footerHeight: CGFloat?
  var rowHeight: CGFloat?

  // MARK: - Initializers
  public init(tableView: UITableView, headerHeight: CGFloat? = nil, footerHeight: CGFloat? = nil, rowHeight: CGFloat? = nil, @FormBuilder formData: () -> Section) {
    self.tableView = tableView
    self.headerHeight = headerHeight
    self.footerHeight = footerHeight
    self.rowHeight = rowHeight
    self.sections = [formData()]

    super.init()

    setup()
    registerViews()
  }

  public init(tableView: UITableView, headerHeight: CGFloat? = nil, footerHeight: CGFloat? = nil, rowHeight: CGFloat? = nil, @FormBuilder formData: () -> [Section]) {
    self.tableView = tableView
    self.headerHeight = headerHeight
    self.footerHeight = footerHeight
    self.rowHeight = rowHeight
    self.sections = formData()

    super.init()

    setup()
    registerViews()
  }

  private func setup() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
  }

  private func registerViews() {
    sections.forEach { section in
    if let header = section.header { registerHeaderFooter(header) }
    if let footer = section.footer { registerHeaderFooter(footer) }
      section.rows.forEach { row in
       registerCell(row)
      }
    }
  }

  private func appendSections(_ sections: [Section]) {
    let source = self.sections
    let target = self.sections + sections
    //self.sections.append(contentsOf: sections)

    let changeset = StagedChangeset(source: source, target: target)
    tableView.reload(using: changeset, with: .fade) { (data) in
      self.sections = data
      self.registerViews()
    }


    //tableView.insertSections(IndexSet(integer: sections.count - 1), with: .automatic)
    //tableView.reloadData()
  }

  private func appendRows(_ rows: [Row], sectionIndex: Int) {
    let section = self.section(at: sectionIndex)
    sections[sectionIndex].rows.append(contentsOf: rows)
    registerViews()
    tableView.reloadSections(IndexSet(integer: sectionIndex), with: section.rowAnimation ?? rowAnimation ?? .automatic)
  }

  private func insertRows(_ rows: [Row], sectionIndex: Int, rowIndex: Int) {
    let section = self.section(at: sectionIndex)
    sections[sectionIndex].rows.insert(contentsOf: rows, at: rowIndex)
    registerViews()
    var indexPaths: [IndexPath] = []
    for row in 0..<rows.count {
      indexPaths.append(IndexPath(row: rowIndex + row, section: sectionIndex))
    }
    tableView.insertRows(at: indexPaths, with: section.rowAnimation ?? rowAnimation ?? .automatic)
    //tableView.reloadSections(IndexSet(integer: sectionIndex), with: section.rowAnimation ?? rowAnimation ?? .automatic)
  }

  private func removeRows() {

  }

  func registerHeaderFooter(_ headerFooter: HeaderFooter) {
    if let nibName = headerFooter.nibName {
      tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: headerFooter.identifier)
    }

    if let cellClass = headerFooter.viewClass {
      tableView.register(cellClass, forHeaderFooterViewReuseIdentifier: headerFooter.identifier)
    }
  }

  func registerCell(_ row: Row) {
    if let nibName = row.nibName {
      tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: row.identifier)
    }

    if let cellClass = row.viewClass {
      tableView.register(cellClass, forCellReuseIdentifier: row.identifier)
    }
  }

  func createHeaderFooter(forSection section: Section) -> UIView? {
    if let header = section.header {
      let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.identifier)
      return headerView
    }

    if let footer = section.footer {
      let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.identifier)
      return footerView
        }

    return nil
  }

  func section(at index: Int) -> Section {
    return sections[index]
  }

  func row(at indexPath: IndexPath) -> Row {
    return sections[indexPath.section].rows[indexPath.row]
  }

  public func removeSection(at index: Int) {
    sections.remove(at: index)
    tableView.deleteSections(IndexSet(integer: index), with: rowAnimation ?? .automatic)
  }

  func insertRow(at index: Int) {

  }

  func deleteRow(at indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    sections[indexPath.section].rows.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: row.rowAnimation ?? rowAnimation ?? .automatic)
  }
}


// MARK: - Modifiers
extension Form {
  /// Applies header height to all sections in this form
  /// - Parameter height:the specified header height
  @discardableResult
  public func headerHeight(_ height: CGFloat) -> Self {
    self.headerHeight = height
    return self
  }

  /// Applies footer height to all sections in this form
  /// - Parameter height: the specified footer height
  @discardableResult
  public func footerHeight(_ height: CGFloat) -> Self {
    self.footerHeight = height
    return self
  }

  /// Applies row height to all rows in this form
  /// - Parameter height: the specified row height
  @discardableResult
  public func rowHeight(_ height: CGFloat) -> Self {
    self.rowHeight = height
    return self
  }

  /// Applies `UITableView.RowAnimation` to the entire form
  /// - Parameter animation: the specified `UITableView.RowAnimation`
  @discardableResult
  public func rowAnimation(_ animation: UITableView.RowAnimation) -> Self {
    self.rowAnimation = animation
    return self
  }

  /// Add sections in the form
  /// - Parameter sections: sections to add in form
  /// - Parameter scrollBottom: speciefies if scroll is needed to become sections visible after addition
  @discardableResult
  public func addSections(_ sections: [Section], scrollBottom: Bool = false) -> Self {
    appendSections(sections)
    if scrollBottom { scrollToBottom(animated: true) }
    return self
  }

  /// Add sections in the form
  /// - Parameter sections: sections to add in form
  /// - Parameter scrollBottom: speciefies if scroll is needed to become sections visible after addition
  @discardableResult
  public func addSections(_ sections: Section..., scrollBottom: Bool = false) -> Self {
    appendSections(sections)
    if scrollBottom { scrollToBottom(animated: true) }
    return self
  }

  /// Add rows in the a specified section
  /// - Parameter rows: rows to add in the specified sectiom
  /// - Parameter sectionIndex: section index to add the rows
  @discardableResult
  public func addRows(_ rows: Row..., in sectionIndex: Int) -> Self {
    appendRows(rows, sectionIndex: sectionIndex)
    return self
  }

  /// Add rows in the a specified section
  /// - Parameter rows: rows to add in the specified sectiom
  /// - Parameter sectionIndex: section index to add the rows
  @discardableResult
  public func addRows(_ rows: [Row], in sectionIndex: Int) -> Self {
    appendRows(rows, sectionIndex: sectionIndex)
    return self
  }

  /// Add rows in the a specified section
  /// - Parameter rows: rows to add in the specified sectiom
  /// - Parameter sectionIndex: section index to add the rows
  @discardableResult
  public func insertRows(_ rows: [Row], in sectionIndex: Int, at rowIndex: Int) -> Self {
    insertRows(rows, sectionIndex: sectionIndex, rowIndex: rowIndex)
    return self
  }

  /// Change tableView editing mode
  /// - Parameter editing: flag indicate the change
  /// - Parameter animated: specifies wheither the change should be animated
  @discardableResult
  public func toggleEditing(_ editing: Bool, animated: Bool) -> Self {
    tableView.setEditing(editing, animated: animated)
    return self
  }

  /// Expands rows according to their content without calling reloadData()
  @discardableResult
  public func expandIfNeeded() -> Self {
    let currentOffset = tableView.contentOffset
    UIView.setAnimationsEnabled(false)
    tableView.beginUpdates()
    tableView.endUpdates()
    UIView.setAnimationsEnabled(true)
    tableView.setContentOffset(currentOffset, animated: false)
    return self
  }

  /// Scrolls entire form to the top
  /// - Parameter animated: specifies wheither the scroll should be animated
  @discardableResult
  public func scrollToTop(animated: Bool) -> Self {
    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
    return self
  }

  /// Scrolls entire form to the bottom
  /// - Parameter animated: specifies wheither the scroll should be animated
  @discardableResult
  public func scrollToBottom(animated: Bool) -> Self {
    let sectionIndex = sections.count - 1
    let section = self.section(at: sectionIndex)
    let rowIndex = section.rows.count - 1

    tableView.scrollToRow(at: IndexPath(row: rowIndex, section: sectionIndex), at: .bottom, animated: animated)
    return self
  }

//  @discardableResult
//  public func bindObject<T>(_ object: T) -> Self where T: Any {
//    self.object = object as Any
//    print(object)
//  return self
//  }
//
//  public func bindModel(_ model: Any) -> Self {
//    self.bindModel = model
//    return self
//  }
}
