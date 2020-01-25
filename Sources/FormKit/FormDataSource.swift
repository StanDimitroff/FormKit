//
//  FormDataSource.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 22.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import UIKit

final class FormDataSource: NSObject {

  private var tableView: UITableView = UITableView()
  private var sections: [Section] = []

  init(tableView: UITableView, sections: [Section]) {
    super.init()
    self.tableView = tableView
    self.sections = sections

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
}

// MARK: - UITableViewDataSource
extension FormDataSource: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = sections[indexPath.section].rows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)

//    if let cell = cell as? Configurable {
//      cell.config()
//    }
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ""//sections[section].headerTitle
  }

  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return ""//sections[section].footerTitle
  }





}

// MARK: - UITableViewDelegate
extension FormDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return createHeaderFooter(forSection: section)
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return createHeaderFooter(forSection: section)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return .zero
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return .zero
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return .zero
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
