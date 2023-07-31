//
//  ContentViewModel.swift
//  PushSender
//

import Foundation

enum SimulatorFetchError: Error {
    case empty
}

final class ContentViewModel: ObservableObject {
    @Published var simulators: [SimulatorModel] = []
    @Published var selectedSimulator: SimulatorModel?
    
    private let simulatorUseCase = SimulatorUseCase()
    
    func fetchBootedSimulators() {
        self.simulators = simulatorUseCase.fetchBooted()
    }
    
    func selectSimulator(_ model: SimulatorModel) {
        selectedSimulator = model
    }
    
    func sendPush(title: String, message: String, bundleId: String, payload: String?) {
        guard let selectedId = selectedSimulator?.id else { return }
        simulatorUseCase.sendPush(
            simulatorId: selectedId,
            bundleId: bundleId,
            title: title,
            body: message,
            customPayload: payload
        )
    }
    
    func sendAll(title: String, message: String, bundleId: String, payload: String?) {
        if simulators.isEmpty {
            simulators = simulatorUseCase.fetchBooted()
        }
        
        simulators.forEach {
            simulatorUseCase.sendPush(
                simulatorId: $0.id,
                bundleId: bundleId,
                title: title,
                body: message,
                customPayload: payload
            )
        }
    }
}
