//
//  FileListView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/12/22.
//

import SwiftUI

struct FileListView: View {
  @EnvironmentObject var store: Store
  
  @State var files: [File] = []

  var body: some View {
    VStack {
      List(files, selection: $store.activeFile) { file in
        NavigationLink(value: file, label: {
          Text(file.name)
        })
      }.listStyle(SidebarListStyle())
    }
    .toolbar(content: {
      ToolbarItem(placement: .primaryAction, content: {
        Button(action: {
          store.createFile("(+ 1 2)", filename: "test.janet")
          files = store.getFiles()
        }, label: {
          Label("Add file", systemImage: "plus")
        })
      })
    })
    .onAppear {
      files = store.getFiles()
    }
  }
}
