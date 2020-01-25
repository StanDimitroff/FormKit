//
//  FormBuilder.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 22.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import UIKit

public struct Form {

  private let dataSource: FormDataSource?

  public init(tableView: UITableView, @FormBuilder formData: () -> Section) {
    self.dataSource = FormDataSource(tableView: tableView, sections: [formData()])
  }

  public init(tableView: UITableView, @FormBuilder formData: () -> [Section]) {
    self.dataSource = FormDataSource(tableView: tableView, sections: formData())
  }
}
