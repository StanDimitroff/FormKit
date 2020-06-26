//import UIKit
//
//// TODO: - UITableViewDiffableDataSource for iOS 13 and above
//
//// MARK: - UITableViewDataSource
//extension Form: UITableViewDataSource {
//  public func numberOfSections(in tableView: UITableView) -> Int {
//    return sections.count
//  }
//
//  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return self.section(at: section).rows.count
//  }
//
//  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    var row = self.row(at: indexPath)
//    row.onScroll = {
//      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//    }
//
//    let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
//    if let cell = cell as? FormCell  {
//      cell.configure(row: row)
//      cell.valueChange = { value in
//
//      }
//    }
//
//    return cell
//  }
//
//  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    return self.section(at: section).headerTitle
//  }
//
//  public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//    return self.section(at: section).footerTitle
//  }
//
//  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//    let row = self.row(at: indexPath)
//    let section = self.section(at: indexPath.section)
//    return (row.editingStyle != nil || section.editingStyle != nil) ? true : false
//  }
//
//  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    let row = self.row(at: indexPath)
//    switch editingStyle {
//      case .delete:
//        row.onDelete?()
//        removeRows(indexes: .exact(indexPath.row), sectionIndex: indexPath.section)
//      default:
//      break
//    }
//  }
//}
//
//// MARK: - UITableViewDelegate
//extension Form: UITableViewDelegate {
//  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let section = self.section(at: section)
//    let view = section.header?.view ?? headerFooterView(from: section.header)
//
//    guard let headerView = view else { return nil }
//    section.header?.config?(headerView)
//    return headerView
//  }
//
//  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//    let section = self.section(at: section)
//    let view = section.footer?.view ?? headerFooterView(from: section.footer)
//
//    guard let footerView = view else { return nil }
//    section.footer?.config?(footerView)
//    return footerView
//  }
//
//  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    let row = self.row(at: indexPath)
//    return row.estimatedHeight ?? UITableView.automaticDimension
//  }
//
//  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return self.row(at: indexPath).height ??
//      self.section(at: indexPath.section).rowHeight ??
//      rowHeight ??
//      UITableView.automaticDimension
//  }
//
//  public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//    let section = self.section(at: section)
//    return section.estimatedHeaderHeight ?? section.headerHeight ?? headerHeight ?? .zero
//  }
//
//  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return self.section(at: section).headerHeight ??
//           headerHeight ??
//           .zero
//  }
//
//  public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//    let section = self.section(at: section)
//    return section.estimatedFooterHeight ?? section.footerHeight ?? footerHeight ?? .zero
//  }
//
//  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return self.section(at: section).footerHeight ??
//           footerHeight ??
//           .zero
//  }
//
//  public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//    let row = self.row(at: indexPath)
//    let section = self.section(at: indexPath.section)
//    return row.editingStyle ?? section.editingStyle ?? .none
//  }
//
//  public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//    let row = self.row(at: indexPath)
//    let section = self.section(at: indexPath.section)
//    return row.deleteTitle ?? section.deletionTitle ?? "Delete"
//  }
//
//  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let row = self.row(at: indexPath)
//    row.onSelect?()
//  }
//}
