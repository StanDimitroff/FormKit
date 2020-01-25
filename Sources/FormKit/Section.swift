//
//  Section.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 25.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import Foundation

public struct Section: FormSection {
  var header: Header?
  var rows: [Row]
  var footer: Footer?
}

extension Section  {
  public init(header: Header, footer: Footer, @SectionBuilder content: () -> Row) {
    self.header = header
    self.rows = [content()]
    self.footer = footer
  }

  public init(header: Header, footer: Footer, @SectionBuilder content: () -> [Row]) {
    self.header = header
    self.rows = content()
    self.footer = footer
  }
}

extension Section {
  public init(header: Header, @SectionBuilder content: () -> Row) {
    self.header = header
    self.rows = [content()]
    self.footer = nil
  }

  public init(header: Header, @SectionBuilder content: () -> [Row]) {
    self.header = header
    self.rows = content()
    self.footer = nil
  }
}

extension Section {
  public init(footer: Footer, @SectionBuilder content: () -> Row) {
    self.header = nil
    self.rows = [content()]
    self.footer = footer
  }

	public init(footer: Footer, @SectionBuilder content: () -> [Row]) {
	    self.header = nil
	    self.rows = content()
	    self.footer = footer
	  }
}

extension Section {
  public init(@SectionBuilder content: () -> Row) {
    self.header = nil
    self.rows = [content()]
    self.footer = nil
  }

	public init(@SectionBuilder content: () -> [Row]) {
	    self.header = nil
	    self.rows = content()
	    self.footer = nil
	  }
}
