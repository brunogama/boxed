import Foundation

extension Character {
    var terminalWidth: Int {
        // A character can be composed of multiple Unicode scalars
        var totalWidth = 0
        for scalar in unicodeScalars {
            // Check for standard ASCII control characters (width 0)
            if scalar.properties.generalCategory == .control || scalar.isNewline {
                // Control characters generally have zero width in terminals
                // Newlines also effectively take zero horizontal space
                continue // Skip width calculation for this scalar
            }

            // Check for Variation Selector-16 (U+FE0F), which forces emoji presentation
            // VS16 itself has zero width but modifies the preceding character.
            // A full implementation would check the preceding char + VS16, but
            // for simplicity, we check common wide ranges and use isEmoji.
            if scalar.value == 0xFE0F { continue }

            // Explicitly check for ASCII digits first
            if scalar.isASCII && scalar.properties.numericType != nil {
                totalWidth += 1
                continue // ASCII digits are width 1
            }

            // Use scalar properties for emoji check - Prioritize isEmoji
            if scalar.properties.isEmoji {
                 // Emojis are typically double-width
                 totalWidth += 2
                 continue // Assume emoji takes 2, ignore other checks for this scalar
            }

            // Check common wide Unicode ranges (CJK, Hangul, Hiragana, Katakana, Fullwidth)
            switch scalar.value {
            case 0x4E00...0x9FFF, 0xF900...0xFAFF, 0x3000...0x303F, // CJK
                 0xAC00...0xD7AF, 0x3130...0x318F, // Hangul
                 0x3040...0x309F, 0x30A0...0x30FF, // Hiragana, Katakana
                 0xFF01...0xFF60, 0xFFE0...0xFFE6: // Fullwidth Forms
                totalWidth += 2
            default:
                // Assume single width for other characters
                totalWidth += 1
            }
        }
        // Return calculated width, ensuring at least 0 (e.g., for control chars)
        return max(0, totalWidth)
    }
}

// Helper extension for isNewline check on Unicode.Scalar
extension Unicode.Scalar {
    var isNewline: Bool {
        // Common newline characters
        // Check against specific scalar values for CR and LF
        return self.value == 0x0A || self.value == 0x0D || self.properties.generalCategory == .lineSeparator || self.properties.generalCategory == .paragraphSeparator
    }
}
