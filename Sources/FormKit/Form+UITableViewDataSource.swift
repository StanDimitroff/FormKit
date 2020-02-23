import UIKit

// MARK: - UITableViewDataSource
extension Form: UITableViewDataSource {
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
    }

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
    let section = self.section(at: indexPath.section)
    return (row.editingStyle != nil || section.editingStyle != nil) ? true : false
  }

  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    switch editingStyle {
      case .delete:
        row.onDelete?()
        deleteRow(at: indexPath)

      default:
      break
    }
  }
}

// MARK: - UITableViewDelegate
extension Form: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let section = self.section(at: section)
    return section.header?.view ?? createHeaderFooter(forSection: section)
  }

  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let section = self.section(at: section)
    return section.footer?.view ?? createHeaderFooter(forSection: section)
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
    return row.deleteTitle ?? section.deleteTitle ?? "Delete"
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = self.row(at: indexPath)
    row.onSelect?()
  }
}
