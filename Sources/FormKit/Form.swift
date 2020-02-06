import UIKit

public struct Form {

  let sections: [Section]
  var headerHeight: CGFloat?
  var footerHeight: CGFloat?
  var rowHeight: CGFloat?

  public init(headerHeight: CGFloat? = nil, footerHeight: CGFloat? = nil, rowHeight: CGFloat? = nil, @FormBuilder formData: () -> Section) {
    self.headerHeight = headerHeight
    self.footerHeight = footerHeight
    self.rowHeight = rowHeight
    self.sections = [formData()]
  }

  public init(headerHeight: CGFloat? = nil, footerHeight: CGFloat? = nil, rowHeight: CGFloat? = nil, @FormBuilder formData: () -> [Section]) {
    self.headerHeight = headerHeight
    self.footerHeight = footerHeight
    self.rowHeight = rowHeight
    self.sections = formData()
  }
}

extension Form {
  @discardableResult
  public func headerHeight(_ height: CGFloat) -> Form {
    var form = self
    form.headerHeight = height
    return form
  }

  @discardableResult
  public func footerHeight(_ height: CGFloat) -> Form {
    var form = self
    form.footerHeight = height
    return form
  }

  @discardableResult
  public func rowHeight(_ height: CGFloat) -> Form {
    var form = self
    form.rowHeight = height
    return form
  }
}
