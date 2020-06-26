import UIKit
import DifferenceKit

// MARK: - Modifiers
extension Form {
  public enum Index {
    case first, last, exact(Int)
  }

  public typealias SectionIndex = Index
  public typealias RowIndex = Index

  private func appendSections(_ sections: [Section]) {
    let source = self.sections
    let target = self.sections + sections

    let changeset = StagedChangeset(source: source, target: target)
    tableView.reload(using: changeset, with: rowAnimation ?? .fade) { (data) in
      self.sections = data
      self.registerViews()
    }
  }

  private func insertSections(_ sections: [Section], sectionIndex: Int) {
    let source = self.sections
    var target = self.sections
    target.insert(contentsOf: sections, at: sectionIndex)
    let changeset = StagedChangeset(source: source, target: target)
    tableView.reload(using: changeset, with: rowAnimation ?? .fade) { (data) in
      self.sections = data
      self.registerViews()
    }
  }

  private func deleteSections(_ indexes: [SectionIndex]) {
    let source = self.sections
    var target = self.sections
    indexes.forEach {
      index in

      switch index {
        case .first:
          target.removeFirst()
        case .last:
          target.removeLast()
        case .exact(let index):
          target.remove(at: index)
      }
    }

    let changeset = StagedChangeset(source: source, target: target)
    tableView.reload(using: changeset, with: rowAnimation ?? .fade) { (data) in
      self.sections = data
    }
  }

  private func appendRows(_ rows: [Row], sectionIndex: Int) {
    let section = self.section(at: sectionIndex)
    let source = section.rows
    let target = section.rows + rows

    let changeset = StagedChangeset(source: source, target: target)
    tableView.reload(using: changeset, with: section.rowAnimation ?? rowAnimation ?? .fade) { (data) in
      self.sections[sectionIndex].rows = data
      self.registerViews()
    }
  }

  private func insertRows(_ rows: [Row], sectionIndex: Int, rowIndex: Int) {
    let section = self.section(at: sectionIndex)
    let source = section.rows
    var target = section.rows
    target.insert(contentsOf: rows, at: rowIndex)
    let changeset = StagedChangeset(source: source, target: target, section: sectionIndex)
     tableView.reload(using: changeset, with: section.rowAnimation ?? rowAnimation ?? .fade) { (data) in
      self.sections[sectionIndex].rows = data
      self.registerViews()
    }
  }

  private func removeRows(_ indexes: [RowIndex], sectionIndex: Int) {
    let section = self.section(at: sectionIndex)
    let source = section.rows
    var target = section.rows

    indexes.forEach { index in
      switch index {
        case .first:
          target.removeFirst()
        case .last:
          target.removeLast()
        case .exact(let index):
          target.remove(at: index)
      }
    }

    let changeset = StagedChangeset(source: source, target: target, section: sectionIndex)
     tableView.reload(using: changeset, with: section.rowAnimation ?? rowAnimation ?? .fade) { (data) in
      self.sections[sectionIndex].rows = data
      self.registerViews()
    }
  }

  private func removeRow(for keyPath: AnyKeyPath) {
    let section = sections.firstIndex { section in
      return section.rows.contains(where: { (row) -> Bool in
        row.keyPath == keyPath
      })
    }
  }

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

  @discardableResult
  public func insertSections(_ sections: [Section], at sectionIndex: Int) -> Self {
    insertSections(sections, sectionIndex: sectionIndex)
    return self
  }

  @discardableResult
  public func insertSections(_ sections: Section..., at sectionIndex: Int) -> Self {
    insertSections(sections, sectionIndex: sectionIndex)
    return self
  }

  @discardableResult
  public func removeSections(indexes: [SectionIndex]) -> Self {
    deleteSections(indexes)
    return self
  }

  @discardableResult
  public func removeSections(indexes: SectionIndex...) -> Self {
    deleteSections(indexes)
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
  public func addRows(_ rows: [Row], sectionIndex: Int) -> Self {
    appendRows(rows, sectionIndex: sectionIndex)
    return self
  }

  /// Add rows in the a specified section
  /// - Parameter rows: rows to add in the specified sectiom
  /// - Parameter section: section index to add the rows
  @discardableResult
  public func insertRows(_ rows: [Row], section: Int, rowIndex: Int) -> Self {
    insertRows(rows, sectionIndex: section, rowIndex: rowIndex)
    return self
  }

  @discardableResult
  public func removeRows(indexes: [RowIndex], sectionIndex: Int) -> Self {
    removeRows(indexes, sectionIndex: sectionIndex)
    return self
  }

  @discardableResult
  public func removeRows(indexes: RowIndex..., sectionIndex: Int) -> Self {
    removeRows(indexes, sectionIndex: sectionIndex)
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
}
