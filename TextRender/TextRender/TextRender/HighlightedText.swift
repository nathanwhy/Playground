//
//  HighlightedText.swift
//  TextRender
//
//  Created by nelson.wu on 2024/6/29.
//

import SwiftUI

struct HighlightedText: View {
 
    // MARK: - Private Properties
    private let text: String
    private let highlightedText: String?
    private let shapeStyle: (any ShapeStyle)?
 
    // MARK: - Initializer
    init(text: String, highlightedText: String? = nil, shapeStyle: (any ShapeStyle)? = nil) {
        self.text = text
        self.highlightedText = highlightedText
        self.shapeStyle = shapeStyle
    }
 
    // MARK: - Body
    var body: some View {
        if let highlightedText, !highlightedText.isEmpty {
            let text = highlightedTextComponent(from: highlightedText).reduce(Text("")) { partialResult, component in
                return partialResult + component.text
            }
            text.textRenderer(HighlightTextRenderer(style: shapeStyle ?? .yellow))
        } else {
            Text(text)
        }
    }
 
    /// Extract the highlighted text components
    ///
    /// - Parameters
    ///     - highlight: The part to highlight
    /// - Returns: Array of highlighted text components
    private func highlightedTextComponent(from highlight: String) -> [HighlightedTextComponent] {
        let highlightRanges: [HighlightedTextComponent] = text
            .ranges(of: highlight, options: .caseInsensitive)
            .map { HighlightedTextComponent(text: Text(text[$0]).customAttribute(HighlightAttribute()), range: $0)  }
 
        let remainingRanges = text
            .remainingRanges(from: highlightRanges.map(\.range))
            .map { HighlightedTextComponent(text: Text(text[$0]), range: $0)  }
 
        return (highlightRanges + remainingRanges).sorted(by: { $0.range.lowerBound < $1.range.lowerBound  } )
    }
}
 
fileprivate struct HighlightedTextComponent {
    let text: Text
    let range: Range<String.Index>
}

extension String {
    /// Find all ranges of the given substring
    ///
    /// - Parameters:
    ///   - substring: The substring to find ranges for
    ///   - options: Compare options
    ///   - locale: Locale used for finding
    /// - Returns: Array of all ranges of the substring
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
 
 
    /// Find all remaining ranges given `ranges`
    ///
    /// - Parameters:
    ///   - ranges: A set of ranges
    /// - Returns: All the ranges that are not part of `ranges`
    func remainingRanges(from ranges: [Range<Index>]) -> [Range<Index>] {
        var result = [Range<Index>]()
 
        // Sort the input ranges to process them in order
        let sortedRanges = ranges.sorted { $0.lowerBound < $1.lowerBound }
 
        // Start from the beginning of the string
        var currentIndex = self.startIndex
 
        for range in sortedRanges {
            if currentIndex < range.lowerBound {
                // Add the range from currentIndex to the start of the current range
                result.append(currentIndex..<range.lowerBound)
            }
 
            // Move currentIndex to the end of the current range
            currentIndex = range.upperBound
        }
 
        // If there's remaining text after the last range, add it as well
        if currentIndex < self.endIndex {
            result.append(currentIndex..<self.endIndex)
        }
 
        return result
    }
}
