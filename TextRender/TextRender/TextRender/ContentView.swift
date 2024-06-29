//
//  ContentView.swift
//  TextRender
//
//  Created by nelson.wu on 2024/6/29.
//

import SwiftUI

struct ContentView: View {
    @State private var strength = 0.0
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextRendererTest()
            HighlightedText(text: "Hello World", highlightedText: "World")
            Text("SHOCKWAVE")
                .font(.largeTitle.weight(.black).width(.compressed))
                .textRenderer(QuakeRenderer(moveAmount: strength))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        strength = 10
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
