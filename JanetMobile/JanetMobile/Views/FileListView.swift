//
//  FileListView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/12/22.
//

import SwiftUI

struct FileListView: View {
  @EnvironmentObject var store: Store

  var body: some View {
    VStack {
      Spacer()

      Text("Files...")

      Spacer()
    }.onAppear {
      store
      store.getFiles()
    }
  }
}
