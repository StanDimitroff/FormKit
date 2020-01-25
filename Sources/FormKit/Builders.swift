//
//  Builders.swift
//  FormKit
//
//  Created by Stanislav Dimitrov on 22.01.20.
//  Copyright © 2020 Stanislav Dimitrov. All rights reserved.
//

import Foundation

@_functionBuilder struct FormBuilder {
//  public static func buildBlock<Header, Content, Footer>(_ sections: Section<Header, Content, Footer>...)
//		-> [Section<Header, Content, Footer>]  {
//    return sections
//  }
  public static func buildBlock(_ sections: Section...) -> [Section] {
		sections
  }
}

@_functionBuilder struct SectionBuilder {

  public static func buildBlock(_ rows: Row...) -> [Row]  {
		rows
  }

//  public static func buildBlock<Content>(_ content: Content) -> Content where Content : Reusable {
//    return content
//  }


}
