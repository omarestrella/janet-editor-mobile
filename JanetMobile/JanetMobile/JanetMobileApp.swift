//
//  JanetMobileApp.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/9/22.
//

import SwiftUI

@main
struct JanetMobileApp: App {
  @StateObject var appModel = Store()

  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(appModel)
    }
  }
}
