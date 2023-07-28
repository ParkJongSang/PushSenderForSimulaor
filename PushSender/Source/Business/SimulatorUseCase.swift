//
//  SimulatorUseCase.swift
//  PushSender
//
//  Created by 박종상님/iOS클라이언트개발팀 on 2023/07/28.
//

import Foundation

final class SimulatorUseCase {
    let repository = SimulatorRepository()
    
    func fetchBooted() -> [SimulatorModel] {
        let simulators = repository.requestAllSimulator().filter { $0.contains("Booted") }
        
        return simulators.compactMap { simulator in
            guard let (modelName, id) = parseModelAndID(from: simulator) else { return nil }
            return SimulatorModel(modelName: modelName, id: id)
        }
    }
    
    func sendPush(simulatorId: String, bundleId: String, title: String, body: String, customPayload: String?) {
        APNSFileGenerator.make(bundleId: bundleId, title: title, body: body, customPayload: customPayload)
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let result = CommandLineExecuter.command("xcrun simctl push \(simulatorId) \(bundleId) \(directoryURL.path())test.apns")
        
        if result.isEmpty == false {
            print("[👨‍🔧] command: xcrun simctl push \(simulatorId) \(bundleId) \(directoryURL.path())/test.apns")
            print("[👨‍🔧] \(result)")
        }
    }
    
    private func parseModelAndID(from inputString: String) -> (String, String)? {
        let strings = inputString.split(separator: " ").map { String($0) }
        guard let statusIndex = strings.firstIndex(where: { $0 == "(Booted)" }) else {
            return nil
        }
        
        var modelName = ""
        let id = strings[statusIndex - 1].dropFirst().dropLast().description
        
        for index in 0..<statusIndex - 1 {
            modelName += strings[index]
        }
        
        return (modelName, id)
    }
}
