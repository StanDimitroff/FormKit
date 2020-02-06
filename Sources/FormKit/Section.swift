import UIKit

public struct Section {
  var headerTitle: String?
  var footerTitle: String?
  var header: Header?
  var rows: [Row]
  var footer: Footer?
  var height: CGFloat?
  var headerHeight: CGFloat?
  var footerHeight: CGFloat?
  var estimatedHeaderHeight: CGFloat?
  var estimatedFooterHeight: CGFloat?
  var rowHeight: CGFloat?
}

extension Section {
  public init(headerTitle: String, footerTitle: String, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.headerTitle = headerTitle
    self.footerTitle = footerTitle
    self.height = height
    self.rowHeight = rowHeight
    self.rows = [content()]
  }

  public init(headerTitle: String, footerTitle: String, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.headerTitle = headerTitle
    self.footerTitle = footerTitle
    self.rowHeight = rowHeight
    self.height = height
    self.rows = content()
  }
}

extension Section {
  public init(headerTitle: String, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.headerTitle = headerTitle
    self.height = height
    self.rowHeight = rowHeight
    self.rows = [content()]
  }

  public init(headerTitle: String, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.headerTitle = headerTitle
    self.height = height
    self.rowHeight = rowHeight
    self.rows = content()
  }
}

extension Section {
  public init(footerTitle: String, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.footerTitle = footerTitle
    self.height = height
    self.rowHeight = rowHeight
    self.rows = [content()]
  }

  public init(footerTitle: String, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.footerTitle = footerTitle
    self.height = height
    self.rowHeight = rowHeight
    self.rows = content()
  }
}

extension Section  {
  public init(header: Header, footer: Footer, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = header
    self.rows = [content()]
    self.footer = footer
    self.height = height
    self.rowHeight = rowHeight
  }

  public init(header: Header, footer: Footer, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = header
    self.rows = content()
    self.footer = footer
    self.height = height
    self.rowHeight = rowHeight
  }
}

extension Section {
  public init(header: Header, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = header
    self.rows = [content()]
    self.footer = nil
    self.height = height
    self.rowHeight = rowHeight
  }

  public init(header: Header, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = header
    self.rows = content()
    self.footer = nil
    self.height = height
    self.rowHeight = rowHeight
  }
}

extension Section {
  public init(footer: Footer, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = nil
    self.rows = [content()]
    self.footer = footer
    self.height = height
    self.rowHeight = rowHeight
  }

  public init(footer: Footer, height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = nil
    self.rows = content()
    self.footer = footer
    self.height = height
    self.rowHeight = rowHeight
  }
}

extension Section {
  public init(height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> Row) {
    self.header = nil
    self.rows = [content()]
    self.footer = nil
    self.height = height
    self.rowHeight = rowHeight
  }

  public init(height: CGFloat? = nil, rowHeight: CGFloat? = nil, @SectionBuilder content: () -> [Row]) {
    self.header = nil
    self.rows = content()
    self.footer = nil
    self.height = height
    self.rowHeight = rowHeight
  }
}

extension Section {
  @discardableResult
  public func height(_ height: CGFloat) -> Section {
    var section = self
    section.height = height
    return section
  }

  @discardableResult
  public func headerHeight(_ height: CGFloat) -> Section {
    var section = self
    section.headerHeight = height
    return section
  }

  @discardableResult
  public func footerHeight(_ height: CGFloat) -> Section {
    var section = self
    section.footerHeight = height
    return section
  }

  @discardableResult
  public func estimatedHeaderHeight(_ height: CGFloat) -> Section {
    var section = self
    section.estimatedHeaderHeight = height
    return section
  }

  @discardableResult
  public func estimatedFooterHeight(_ height: CGFloat) -> Section {
    var section = self
    section.estimatedFooterHeight = height
    return section
  }

  @discardableResult
  public func rowHeight(_ height: CGFloat) -> Section {
    var section = self
    section.rowHeight = height
    return section
  }

  @discardableResult
  public func header(_ header: Header) -> Section {
    var section = self
    section.header = header
    return section
  }

  @discardableResult
  public func footer(_ header: Footer) -> Section {
    var section = self
    section.footer = footer
    return section
  }
}
