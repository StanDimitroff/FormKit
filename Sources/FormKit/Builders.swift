import Foundation

@_functionBuilder public struct FormBuilder {
  public static func buildBlock(_ sections: Section...) -> [Section] {
    sections
  }

//  public static func buildIf(_ sections: Section?...) -> [Section] {
//    sections
//  }
}

@_functionBuilder public struct TabBuilder {
  public static func buildBlock(_ sections: Section...) -> [Section] {
    sections
  }
}

@_functionBuilder public struct SectionBuilder {
  public static func buildBlock(_ rows: Row...) -> [Row]  {
    rows
  }

//  public static func buildIf(_ content: Content?) -> Content? {
//      return content
//  }
}
