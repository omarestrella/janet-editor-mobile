//
//  Color.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/12/22.
//

import Foundation
import SwiftUI

struct BackgroundColorStyle: ViewModifier {
  func body(content: Content) -> some View {
    content.background(Color(uiColor: UIColor(named: "TomorrowNightBackground")!))
  }
}

struct ForegroundColorStyle: ViewModifier {
  func body(content: Content) -> some View {
    content.background(Color(uiColor: UIColor(named: "TomorrowNightForeground")!))
  }
}
