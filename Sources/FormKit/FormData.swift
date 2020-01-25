//
//  FormData.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 22.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import UIKit

public struct Row: Reusable {
  public var nibName: String?
  public var viewClass: AnyClass?

	public init(nibName: String? = nil, viewClass: AnyClass? = nil) {
		self.nibName = nibName
		self.viewClass = viewClass
	}
}

public struct Header: HeaderFooter {
  public var nibName: String?
  public var viewClass: AnyClass?

	public init(nibName: String? = nil, viewClass: AnyClass? = nil) {
		self.nibName = nibName
		self.viewClass = viewClass
	}
}

public struct Footer: HeaderFooter {
  public var nibName: String?
  public var viewClass: AnyClass?

	public init(nibName: String? = nil, viewClass: AnyClass? = nil) {
		self.nibName = nibName
		self.viewClass = viewClass
	}
}
