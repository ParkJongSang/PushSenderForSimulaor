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
    
    var body: some View {
        VStack {
            HStack {
                Text("Bundle ID")
                
                TextField(text: $bundleID) {
                    Text("example) com.company.myapp")
                }
            }
            
            HStack {
                Text("Title")
                
                TextField(text: $title) {
                    Text("Push Notification Title")
                }
            }
            .frame(width: 100)

            HStack {
                Text("Message")
                
                TextField(text: $message) {
                    Text("Push Notification Body")
                }
            }
            .frame(width: 100)
            
            TextEditor(text: $customPayload)
            
            Menu(viewModel.selectedSimulator?.modelName ?? "Simulator") {
                ForEach(viewModel.simulators) { simulator in
                    Button {
                        viewModel.selectSimulator(simulator)
                    } label: {
                        Text(simulator.modelName)
                    }
                }
            }
            
            Button {
                viewModel.sendPush(
                    title: title,
                    message: message,
                    bundleId: bundleID,
                    payload: customPayload
                )
            } label: {
                Text("Send")
            }
            .disabled(viewModel.selectedSimulator == nil)
        }
        .padding()
        .onAppear {
            viewModel.fetchBootedSimulators()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
