import Foundation

public struct Tab {

  let label: String
  var sections: [Section]

  public init(label: String, @TabBuilder content: () -> Section) {
    self.label = label
    self.sections = [content()]
  }

  public init(label: String, @TabBuilder content: () -> [Section]) {
    self.label = label
    self.sections = content()
  }
}
