//
//  FormData.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 22.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import UIKit

public struct Row: Reusable, Adjustable {
  public var nibName: String?
  public var viewClass: AnyClass?

	var height: CGFloat = .zero
}

public struct Header: HeaderFooter {
  public var nibName: String?
  public var viewClass: AnyClass?
	
}

public struct Footer: HeaderFooter {
  public var nibName: String?
  public var viewClass: AnyClass?
}