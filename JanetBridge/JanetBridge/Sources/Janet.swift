//
//  JanetBridge.swift
//  JanetBridge
//
//  Created by Omar Estrella on 6/9/22.
//

import Foundation
import JanetBridge.Janet

public class JanetVM {
  var source: String?
  
  public init(source: String) {
    self.source = source
  }
  
  public func run() -> Janet? {
    guard let source = source else { return nil }
    
    janet_init()
    

    let env = janet_core_env(nil);
    let result = UnsafeMutablePointer<Janet>.allocate(capacity: 1)
    
    let cSource = source.cString(using: String.defaultCStringEncoding)
    let cMain = "main".cString(using: String.defaultCStringEncoding)
    janet_dostring(env, cSource, cMain, result)
    
    janet_deinit()
    
    return result.pointee
  }
}
