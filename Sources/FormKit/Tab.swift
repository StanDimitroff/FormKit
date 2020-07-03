import Foundation

public struct Tab {

  public let label: String
  public var sections: [Section]

  public init(_ label: String, @TabBuilder content: () -> Section) {
    self.label = label
    self.sections = [content()]
  }

  public init(_ label: String, @TabBuilder content: () -> [Section]) {
    self.label = label
    self.sections = content()
  }
}
