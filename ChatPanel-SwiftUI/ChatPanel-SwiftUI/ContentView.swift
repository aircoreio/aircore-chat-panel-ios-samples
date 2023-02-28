//
//  ContentView.swift
//  ChatPanel-SwiftUI
//
//  Created by Deepak on 10/5/22.
//

import SwiftUI
import AircoreChatPanel

struct ContentView: View {
    let panel: ChatPanel

    var body: some View {
        ZStack {
            VStack {
                Text("AircoreChatPanel version \(Client.frameworkVersion)")
                    .font(.footnote)
            }
            .padding()

            // Embed the MediaPanel in your current View.
            panel
                .collapsedView()
                .ignoresSafeArea()
        }
    }
}
