//
//  ContentView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/9/22.
//

import JanetBridge
import SwiftUI

// ((fn [x y] (+ x y)) 10 20)

struct ContentView: View {
  @State var input = """
(defn sum [a b]
  (+ a b))

(sum 3 4)
"""
  @State var result = ""

  var body: some View {
    VStack {
      HStack() {
        Spacer()
        Button("Run", action: {
          let janet = JanetVM(source: input)
          let result = janet.run()
          if let result {
            switch result.type {
            case JANET_NUMBER:
              print("got num", result.as.number)
              self.result = "\(result.as.number)"
            default:
              print("no support yet")
            }
          }
        })
      }.padding(.trailing, 5)
      
      HStack {
        EditorView(text: $input)
      }
      
      HStack(spacing: 5) {
        Text("Result:")
        Text(self.result)
      }.foregroundColor(Color(uiColor: UIColor(named: "OneDarkForeground")!))
    }
    .background(Color(uiColor: UIColor(named: "OneDarkBackground")!))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
