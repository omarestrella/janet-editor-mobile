//
//  EditorView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/13/22.
//

import SwiftUI
import JanetBridge

struct EditorView: View {
  @State var file: File
  
  @State var editorText = ""
  @State var result = ""
  
  
  var body: some View {
    VStack {
      FileEditor(text: $editorText)
      
      if !result.isEmpty {
        Text(result)
      }
    }
    .onAppear {
      editorText = file.contents
    }
    .modifier(BackgroundColorStyle())
    .toolbar(content: {
      ToolbarItem(placement: .principal, content: {
        Text(file.name)
          .modifier(ForegroundColorStyle())
      })
      
      ToolbarItem(placement: .primaryAction, content: {
        Button(action: {
          let janet = JanetVM(source: editorText)
          let result = janet.run()
          if let result {
            switch result.type {
            case JANET_NUMBER:
              print("got num", result.as.number)
              self.result = "\(result.as.number)"
            default:
              print("no support yet", result.type)
            }
          }
        }, label: {
          Label("Run", systemImage: "play.fill")
            .modifier(ForegroundColorStyle())
        })
      })
    })
  }
}
