//
//  ContentView.swift
//  TextRender
//
//  Created by nelson.wu on 2024/6/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextRendererTest()
            HighlightedText(text: "Hello World", highlightedText: "World")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
