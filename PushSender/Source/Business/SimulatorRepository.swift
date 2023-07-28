//
//  SimulatorRepository.swift
//  PushSender
//

import Foundation

struct SimulatorRepository {    
    func requestAllSimulator() -> [String] {
        let result = CommandLineExecuter.command("xcrun simctl list devices")
        
        return result.split(separator: "\n").map { String($0) }
    }
}
