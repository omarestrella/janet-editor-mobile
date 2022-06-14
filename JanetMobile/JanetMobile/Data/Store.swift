//
//  AppModel.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/12/22.
//

import Foundation
import SwiftUI

class Store: ObservableObject {
  @Published var activeColumn: NavigationSplitViewVisibility = .doubleColumn
  
  internal let fileManager = FileManager()
  
  var isEditorFullscreen: Bool {
    activeColumn == .detailOnly
  }
  
  func toggleEditorFullscreen() {
    activeColumn = .doubleColumn
  }
  
  // MARK: File management
  
  @Published var activeFile: File?
  
  func createFile(_ contents: String, filename: String) {
    do {
      try fileManager.createFile(contents, filename: filename)
    } catch {
      print(error)
    }
  }

  func getFiles() -> [File] {
    fileManager.getFiles()
  }
}
