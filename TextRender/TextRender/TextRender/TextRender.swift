//
//  TextRender.swift
//  TextRender
//
//  Created by nelson.wu on 2024/6/29.
//

import SwiftUI

// https://alexanderweiss.dev/blog/2024-06-24-using-textrenderer-to-create-highlighted-text

struct HighlightAttribute: TextAttribute {}

struct HighlightTextRenderer: TextRenderer {
 
    // MARK: - Private Properties
    private let style: any ShapeStyle
 
    // MARK: - Initializer
    init(style: any ShapeStyle = .yellow) {
        self.style = style
    }
 
    // MARK : - TextRenderer
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for run in layout.flattenedRuns {
            if run[HighlightAttribute.self] != nil {
     
                // The rect of the current run
                let rect = run.typographicBounds.rect
     
                // Make a copy of the context so that individual slices
                // don't affect each other.
                let copy = context
     
                // Shape of the highlight, can be customised
                let shape = RoundedRectangle(cornerRadius: 4, style: .continuous).path(in: rect)
     
                // Style the shape
                copy.fill(shape, with: .style(style))
     
                // Draw
                copy.draw(run)
            } else {
                let copy = context
                copy.draw(run)
            }
        }
    }
}

extension Text.Layout {
    /// A helper function for easier access to all runs in a layout.
    var flattenedRuns: some RandomAccessCollection<Text.Layout.Run> {
        self.flatMap { line in
            line
        }
    }
}

struct TextRendererTest: View {
    var body: some View {
        let highlight = Text("World")
            .customAttribute(HighlightAttribute())
 
        Text("Hello \(highlight)").textRenderer(HighlightTextRenderer())
    }
}
