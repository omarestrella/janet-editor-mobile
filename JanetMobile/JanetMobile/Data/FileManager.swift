//
//  FileManager.swift
//  JanetMobile
//
//  Created by Omar Estrella on 6/12/22.
//

import Disk
import Foundation

struct File {
  var url: URL
  var contents: String
  
  var name: String {
    return url.lastPathComponent
  }
}

struct FileManager {
  let systemManager = Foundation.FileManager()

  func createFile(_ contents: String, filename: String) throws {
    try Disk.save(contents, to: .documents, as: filename)
  }

  func getFiles() -> [File] {
    guard let url = try? Disk.url(for: nil, in: .documents) else {
      return []
    }
    guard let fileEnumerator = systemManager.enumerator(at: url, includingPropertiesForKeys: []) else {
      return []
    }
    
    let files = fileEnumerator.compactMap { (fileURL: Any?) -> File? in
      guard let fileURL = fileURL as? URL else { return nil }
      guard let contents = try? Disk.retrieve(fileURL.lastPathComponent, from: .documents, as: String.self) else { return nil }
      return File(url: fileURL, contents: contents)
    }
    return files
  }
}

extension Store {
  func createFile(_ contents: String, filename: String) {
    do {
      try fileManager.createFile(contents, filename: filename)
    } catch {
      print(error)
    }
  }

  func getFiles() -> [File] {
    fileManager.getFiles()
  }
}
