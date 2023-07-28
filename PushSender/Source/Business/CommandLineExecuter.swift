//
//  CommandLineExecuter.swift
//  PushSender
//
//  Created by 박종상님/iOS클라이언트개발팀 on 2023/07/28.
//

import Foundation

final class CommandLineExecuter {
    static func command(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.standardInput = nil
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
}
