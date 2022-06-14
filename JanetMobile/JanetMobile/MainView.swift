//
//  ContentView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/9/22.
//

import JanetBridge
import SwiftUI

struct MainView: View {
  @EnvironmentObject var store: Store

  var body: some View {
    NavigationSplitView {
      FileListView()
        .navigationTitle("Files")
    } detail: {
      ZStack {
        if let file = store.activeFile {
          EditorView(file: file)
        } else {
          Text("Select a file...")
        }
      }
    }.navigationSplitViewColumnWidth(min: 150, ideal: 150, max: 150)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
  }
}
