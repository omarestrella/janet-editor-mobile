//
//  EditorView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/9/22.
//

import JanetBridge
import Runestone
import SwiftUI

struct EditorView: UIViewRepresentable {
  let theme = TomorrowNightTheme()
  let state: TextViewState

  @Binding var text: String

  init(text: Binding<String>) {
    _text = text

    let highlightsQuery = TreeSitterLanguage.Query(contentsOf: JanetQuery.highlightsFileURL)
    let language = TreeSitterLanguage(tree_sitter_janet(), highlightsQuery: highlightsQuery)
    state = TextViewState(text: text.wrappedValue, theme: theme, language: language)
  }

  func makeCoordinator() -> TextViewCoordinator {
    TextViewCoordinator(self)
  }

  func makeUIView(context: Context) -> Runestone.TextView {
    let textView = TextView()
    textView.showLineNumbers = true
    textView.showSpaces = true
    textView.alwaysBounceVertical = true

    textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    textView.autocorrectionType = .no
    textView.autocapitalizationType = .none
    textView.smartDashesType = .no
    textView.smartQuotesType = .no
    textView.smartInsertDeleteType = .no

    textView.indentStrategy = .space(length: 2)

    textView.editorDelegate = context.coordinator
    textView.setState(state)

    textView.backgroundColor = theme.backgroundColor
    textView.insertionPointColor = theme.textColor
    textView.selectionBarColor = theme.textColor
    textView.selectionHighlightColor = theme.textColor.withAlphaComponent(0.2)

    return textView
  }

  func updateUIView(_: TextView, context _: Context) {
    print("got update")
  }

  final class TextViewCoordinator: NSObject, TextViewDelegate {
    let parent: EditorView

    init(_ parent: EditorView) {
      self.parent = parent
    }

    func textViewDidChange(_ textView: TextView) {
      parent.text = textView.text
    }
  }
}

#if DEBUG
struct DebugEditorView: View {
  @State var input = """
  (defn sum [a b]
    (+ a b))

  (sum 3 4)
  """
  @State var result = ""

  var body: some View {
    VStack {
      HStack {
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
              print("no support yet", result.type)
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
      }
    }
  }
}

struct DebugEditorView_Previews: PreviewProvider {
  static var previews: some View {
    DebugEditorView()
  }
}
#endif
