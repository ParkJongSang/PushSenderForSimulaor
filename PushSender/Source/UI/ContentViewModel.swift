//
//  ContentViewModel.swift
//  PushSender
//
//  Created by 박종상님/iOS클라이언트개발팀 on 2023/07/28.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var simulators: [SimulatorModel] = []
    @Published var selectedSimulator: SimulatorModel?
    
    private let simulatorUseCase = SimulatorUseCase()
    
    func fetchBootedSimulators() {
        simulators = simulatorUseCase.fetchBooted()
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
}
