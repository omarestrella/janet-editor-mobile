//
//  AppModel.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/12/22.
//

import Foundation
import SwiftUI

class Store: ObservableObject {
  @State var activeColumn: NavigationSplitViewVisibility = .doubleColumn
  
  internal let fileManager = FileManager()
  
  var isEditorFullscreen: Bool {
    activeColumn == .detailOnly
  }
  
  func toggleEditorFullscreen() {
    activeColumn = .doubleColumn
  }
}
