//
//  SimulatorRepository.swift
//  PushSender
//
//  Created by 박종상님/iOS클라이언트개발팀 on 2023/07/28.
//

import Foundation

struct SimulatorRepository {    
    func requestAllSimulator() -> [String] {
        let result = CommandLineExecuter.command("xcrun simctl list devices")
        
        return result.split(separator: "\n").map { String($0) }
    }
}
