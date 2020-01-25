//
//  Protocols.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 23.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import UIKit

protocol FormSection {
	var header: Header? { get set }
	var footer: Footer? { get set }
	var rows: [Row] { get set }
}

public protocol Reusable {
  var nibName: String? { get set }
  var viewClass: AnyClass? { get set }
	//var height: CGFloat { get set }
}

public protocol HeaderFooter: Reusable { }

protocol Adjustable {
	var height: CGFloat { get set }
}

extension Adjustable {
	mutating func height(_ value: CGFloat) -> Self {
		self.height = value
		return self
	}
}

extension Reusable {
  var identifier: String {
    if let nibName = nibName {
      return nibName
    } else if let viewClass = viewClass {
      return String(describing: viewClass)
    } else {
      fatalError("No view reuse identifier provided")
    }
  }
}

public protocol Configurable: class { }

public extension Configurable where Self: UITableViewCell {
  func config(_ block: (Self) throws -> Void) rethrows -> Self {
    try block(self)
    return self
  }
}
