import UIKit
import DifferenceKit

final public class Form<T>: NSObject, UITableViewDataSource, UITableViewDelegate {

  // MARK: - Properties
  public private(set) var object: T
  private var pendingAppliers: [Int: () -> Void] = [:]
  var tableView: UITableView
  var rowAnimation: UITableView.RowAnimation?

  var tabs: [Tab] = []
  var sections: [Section] = []
  var headerHeight: CGFloat?
  var footerHeight: CGFloat?
  var rowHeight: CGFloat?

  // MARK: - Initializers
  public init(tableView: UITableView, object: T, @FormBuilder formData: () -> Section) {
    self.tableView = tableView
    self.object = object
    self.sections = [formData()]

    super.init()

    setup()
    registerViews()
  }

  public init(tableView: UITableView, object: T, @FormBuilder formData: () -> [Section]) {
    self.tableView = tableView
    self.object = object
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

  func registerViews() {
    sections.forEach { section in
    if let header = section.header { registerHeaderFooter(header) }
    if let footer = section.footer { registerHeaderFooter(footer) }
      section.rows.forEach { row in
       registerCell(row)
      }
    }
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

  func headerFooterView(from headerFooter: HeaderFooter?) -> UIView? {
    if let headerFooter = headerFooter {
      let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerFooter.identifier)
      return view
    }

    return nil
  }

  func section(at index: Int) -> Section {
    return sections[index]
  }

  func row(at indexPath: IndexPath) -> Row {
    return sections[indexPath.section].rows[indexPath.row]
  }





  public func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.section(at: section).rows.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var row = self.row(at: indexPath)
    row.onScroll = {
      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
    if let cell = cell as? FormCell  {
      cell.configure(row: row)
      cell.valueChange = { [weak self] value in
        // for structs
        if let keyPath = row.keyPath as? WritableKeyPath<T, String> {
          self?.object[keyPath: keyPath] = value
          self?.updateRow(value: value, indexPath: indexPath)
        }

        // for classes
        if let keyPath = row.keyPath as? ReferenceWritableKeyPath<T, String> {
          self?.object[keyPath: keyPath] = value
          self?.updateRow(value: value, indexPath: indexPath)
        }
      }
    }
    return cell
  }

  private func updateRow(value: String, indexPath: IndexPath) {
    var row = self.row(at: indexPath)
    row.value = value
    sections[indexPath.section].rows[indexPath.row] = row
  }

  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.section(at: section).headerTitle
  }

  public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return self.section(at: section).footerTitle
  }

  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    let row = self.row(at: indexPath)
    let section = self.section(at: indexPath.section)
    return (row.editingStyle != nil || section.editingStyle != nil) ? true : false
  }

  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    switch editingStyle {
      case .delete:
        row.onDelete?()
        removeRows(indexes: .exact(indexPath.row), sectionIndex: indexPath.section)
      default:
      break
    }
  }





  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let section = self.section(at: section)
    let view = section.header?.view ?? headerFooterView(from: section.header)

    guard let headerView = view else { return nil }
    section.header?.config?(headerView)
    return headerView
  }

  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let section = self.section(at: section)
    let view = section.footer?.view ?? headerFooterView(from: section.footer)

    guard let footerView = view else { return nil }
    section.footer?.config?(footerView)
    return footerView
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let row = self.row(at: indexPath)
    return row.estimatedHeight ?? UITableView.automaticDimension
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.row(at: indexPath).height ??
      self.section(at: indexPath.section).rowHeight ??
      rowHeight ??
      UITableView.automaticDimension
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    let section = self.section(at: section)
    return section.estimatedHeaderHeight ?? section.headerHeight ?? headerHeight ?? .zero
  }

  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return self.section(at: section).headerHeight ??
           headerHeight ??
           .zero
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
    let section = self.section(at: section)
    return section.estimatedFooterHeight ?? section.footerHeight ?? footerHeight ?? .zero
  }

  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return self.section(at: section).footerHeight ??
           footerHeight ??
           .zero
  }

  public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    let row = self.row(at: indexPath)
    let section = self.section(at: indexPath.section)
    return row.editingStyle ?? section.editingStyle ?? .none
  }

  public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    let row = self.row(at: indexPath)
    let section = self.section(at: indexPath.section)
    return row.deleteTitle ?? section.deletionTitle ?? "Delete"
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    row.onSelect?()
  }
}
