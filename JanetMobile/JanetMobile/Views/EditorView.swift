//
//  EditorView.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/9/22.
//

import Runestone
import SwiftUI

struct EditorView: UIViewRepresentable {
  let theme = OneDarkTheme()
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
