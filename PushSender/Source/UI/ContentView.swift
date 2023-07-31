//
//  ContentView.swift
//  PushSender
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var bundleID: String = ""
    @State private var title: String = ""
    @State private var message: String = ""
    @State private var customPayload: String = ""
    @State private var isShowEmptyText: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Bundle ID")
                    .frame(width: 100)
                
                TextField(text: $bundleID) {
                    Text("example) com.company.myapp")
                }
            }
            
            HStack {
                Text("Title")
                    .frame(width: 100)
                
                TextField(text: $title) {
                    Text("Push Notification Title")
                }
            }

            HStack {
                Text("Message")
                    .frame(width: 100)
                
                TextField(text: $message) {
                    Text("Push Notification Body")
                }
            }
            
            HStack {
                Text("Payload\n(Optional)")
                    .multilineTextAlignment(.center)
                    .frame(width: 100)
                
                TextEditor(text: $customPayload)
            }
            
            
            Menu(viewModel.selectedSimulator?.modelName ?? "Simulator") {
                ForEach(viewModel.simulators) { simulator in
                    Button {
                        viewModel.selectSimulator(simulator)
                    } label: {
                        Text(simulator.modelName)
                    }
                }
            }
            .onTapGesture {
                viewModel.fetchBootedSimulators()
            }
            
            if isShowEmptyText {
                Text("Cannot find booted simulators.")
                    .font(.title3)
                    .foregroundColor(.red)
            }
            
            HStack {
                Button {
                    viewModel.sendPush(
                        title: title,
                        message: message,
                        bundleId: bundleID,
                        payload: customPayload
                    )
                } label: {
                    Text("Send to \(viewModel.selectedSimulator?.modelName ?? "")")
                }
                .disabled(viewModel.selectedSimulator == nil)
                .frame(maxWidth: .infinity)
                
                Button {
                    viewModel.sendAll(
                        title: title,
                        message: message,
                        bundleId: bundleID,
                        payload: customPayload
                    )
                } label: {
                    Text("Send to all booted Simulator")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .onReceive(viewModel.$simulators) { simulators in
            isShowEmptyText = simulators.isEmpty
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
