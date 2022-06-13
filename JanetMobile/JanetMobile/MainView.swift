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
    NavigationSplitView(columnVisibility: $store.activeColumn, sidebar: {
      VStack {
        Spacer()

        Text("Projects..")

        Spacer()
      }
    }, content: {
      FileListView()
        .navigationTitle("Files")
        .toolbar(content: {
          ToolbarItem(placement: .primaryAction, content: {
            Button(action: {
              store.createFile("asdf", filename: "test.txt")
            }, label: {
              Label("Add file", systemImage: "plus")
            })
          })
        })
    }, detail: {
      VStack {
        Spacer()
        Text("Editor...")
        Spacer()
      }
    }).navigationSplitViewColumnWidth(min: 150, ideal: 150, max: 150)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView().previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
  }
}
