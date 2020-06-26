import Foundation

public struct Tab {

  public let label: String
  public var sections: [Section]

  public init(label: String, @TabBuilder content: () -> Section) {
    self.label = label
    self.sections = [content()]
  }

  public init(label: String, @TabBuilder content: () -> [Section]) {
    self.label = label
    self.sections = content()
  }
}
