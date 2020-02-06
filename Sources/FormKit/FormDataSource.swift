import UIKit

final public class FormDataSource: NSObject {

  private var tableView: UITableView!
  private var form: Form!
  private var sections: [Section]!

  public init(tableView: UITableView, form: Form) {
    super.init()
    self.tableView = tableView
    self.form = form
    self.sections = form.sections

    setup()
    registerViews()
  }

  func toggleEditing(_ editing: Bool, animated: Bool) {
    tableView.setEditing(editing, animated: animated)
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

  private func registerHeaderFooter(_ headerFooter: HeaderFooter) {
    if let nibName = headerFooter.nibName {
      tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: headerFooter.identifier)
    }

    if let cellClass = headerFooter.viewClass {
      tableView.register(cellClass, forHeaderFooterViewReuseIdentifier: headerFooter.identifier)
    }
  }

  private func registerCell(_ row: Row) {
    if let nibName = row.nibName {
      tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: row.identifier)
    }

    if let cellClass = row.viewClass {
      tableView.register(cellClass, forCellReuseIdentifier: row.identifier)
    }
  }

  private func createHeaderFooter(forSection section: Int) -> UIView? {
    let section = sections[section]
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

  private func section(at index: Int) -> Section {
    return sections[index]
  }

  private func row(at indexPath: IndexPath) -> Row {
    return sections[indexPath.section].rows[indexPath.row]
  }
}

// MARK: - UITableViewDataSource
extension FormDataSource: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.section(at: section).rows.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = self.row(at: indexPath)
    let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
    cell.textLabel?.text = "TEST"
//    if let cell = cell as? Configurable {
//      cell.config()
//    }
    return cell
  }

  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.section(at: section).headerTitle
  }

  public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return self.section(at: section).footerTitle
  }

  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    let row = self.row(at: indexPath)
    return row.editingStyle != nil ? true : false
  }

  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    switch editingStyle {
      case .delete:
        row.onDelete?()
      default:
      break
    }
  }
}

// MARK: - UITableViewDelegate
extension FormDataSource: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return createHeaderFooter(forSection: section)
  }

  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return createHeaderFooter(forSection: section)
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let row = self.row(at: indexPath)
    return row.estimatedHeight ?? UITableView.automaticDimension
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.row(at: indexPath).height ??
      self.section(at: indexPath.section).rowHeight ??
      form.rowHeight ??
      .zero
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    let section = self.section(at: section)
    return section.estimatedHeaderHeight ?? 0
  }

  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return self.section(at: section).headerHeight ??
           form.headerHeight ??
           .zero
  }

  public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
    let section = self.section(at: section)
    return section.estimatedFooterHeight ?? 0
  }

  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return self.section(at: section).footerHeight ??
           form.footerHeight ??
           .zero
  }

  public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    let row = self.row(at: indexPath)
    return row.editingStyle ?? .none
  }

  public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return nil
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    row.onSelect?()
  }
}
