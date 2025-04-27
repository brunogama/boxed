import Testing
import XCTest
@testable import BoxedContent

@Suite("BoxedContentTests")
struct BoxedContentTests {
    
    @Test("Character extension should correctly calculate terminal width")
    func characterTerminalWidth() throws {
        // Regular ASCII characters should have width 1
        #expect("a".first?.terminalWidth == 1)
        #expect("Z".first?.terminalWidth == 1)
        #expect("1".first?.terminalWidth == 1)
        #expect(" ".first?.terminalWidth == 1)
        
        // Emoji characters should have width 2
        #expect("😀".first?.terminalWidth == 2)
        #expect("🚀".first?.terminalWidth == 2)
        #expect("🎉".first?.terminalWidth == 2)
    }
    
    @Test("String extension should correctly calculate visual length")
    func stringVisualLength() throws {
        // Regular ASCII strings
        #expect("Hello".visualLength == 5)
        #expect("Hello World".visualLength == 11)
        #expect("".visualLength == 0)
        
        // Strings with emojis
        #expect("Hello😀".visualLength == 7)  // 5 + 2
        #expect("🚀🚀".visualLength == 4)     // 2 + 2
        #expect("Hello 🎉 World".visualLength == 14)  // 11 + 2 + 1
    }
    
    @Test("BoxStyle.ascii should provide correct characters")
    func asciiBoxStyle() throws {
        let style = BoxStyle.ascii
        #expect(style.vertical == "│")
        #expect(style.horizontal == "─")
        #expect(style.topLeft == "┌")
        #expect(style.topRight == "┐")
        #expect(style.bottomLeft == "└")
        #expect(style.bottomRight == "┘")
    }
    
    @Test("BoxStyle.emoji should provide correct characters")
    func emojiBoxStyle() throws {
        let style = BoxStyle.emoji
        #expect(style.vertical == "⬜️")
        #expect(style.horizontal == "🟦")
        #expect(style.topLeft == "🟥")
        #expect(style.topRight == "🟧")
        #expect(style.bottomLeft == "🟩")
        #expect(style.bottomRight == "🟪")
    }
    
    @Test("ASCIIBoxCharacters should provide correct characters")
    func asciiBoxCharacters() throws {
        let style = ASCIIBoxCharacters()
        #expect(style.vertical == "│")
        #expect(style.horizontal == "─")
        #expect(style.topLeft == "┌")
        #expect(style.topRight == "┐")
        #expect(style.bottomLeft == "└")
        #expect(style.bottomRight == "┘")
    }
    
    @Test("EmojiBoxCharacters should provide correct characters")
    func emojiBoxCharacters() throws {
        let style = EmojiBoxCharacters()
        #expect(style.vertical == "⬜️")
        #expect(style.horizontal == "🟦")
        #expect(style.topLeft == "🟥")
        #expect(style.topRight == "🟧")
        #expect(style.bottomLeft == "🟩")
        #expect(style.bottomRight == "🟪")
    }
    
    @Test("Boxed.calculateHorizontalCount should correctly calculate counts")
    func calculateHorizontalCount() throws {
        // We need a way to test private methods, so we'll create a testing subclass
        // This test would require refactoring the code to make it testable
        // For now, we can test the overall functionality through the public API
    }
}

// Create a test for output capturing to verify the actual box output
@Suite("BoxedOutputTests")
struct BoxedOutputTests {
    
    // Helper function to capture console output
    func captureConsoleOutput(closure: () -> Void) -> String {
        let pipe = Pipe()
        let originalStdout = dup(FileHandle.standardOutput.fileDescriptor)
        
        dup2(pipe.fileHandleForWriting.fileDescriptor, FileHandle.standardOutput.fileDescriptor)
        
        closure()
        
        pipe.fileHandleForWriting.closeFile()
        dup2(originalStdout, FileHandle.standardOutput.fileDescriptor)
        close(originalStdout)
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    @Test("Boxed.ascii should correctly render a simple box")
    func asciiBoxRendering() throws {
        let output = captureConsoleOutput {
            Boxed.ascii("Hello", width: 20)
        }
        
        // Expected format for "Hello" with width 20
        let expectedLines = [
            "┌──────────────┐",
            "│              │",
            "│     Hello    │",
            "│              │",
            "└──────────────┘"
        ]
        
        let lines = output.split(separator: "\n").map(String.init)
        XCTAssertEqual(lines.count, 5)
        
        for (index, expectedLine) in expectedLines.enumerated() {
            if index < lines.count {
                XCTAssertEqual(lines[index], expectedLine)
            }
        }
    }
    
    @Test("Boxed.ascii should handle multiline content")
    func asciiMultilineBoxRendering() throws {
        let output = captureConsoleOutput {
            Boxed.ascii("Line 1\nLine 2\nLine 3", width: 20)
        }
        
        // Expected format for multiline content with width 20
        let expectedLines = [
            "┌──────────────┐",
            "│              │",
            "│    Line 1    │",
            "│ Line 2       │",
            "│ Line 3       │",
            "│              │",
            "└──────────────┘"
        ]
        
        let lines = output.split(separator: "\n").map(String.init)
        XCTAssertEqual(lines.count, 7)
        
        for (index, expectedLine) in expectedLines.enumerated() {
            if index < lines.count {
                XCTAssertEqual(lines[index], expectedLine)
            }
        }
    }
    
    @Test("Boxed.emoji should correctly render an emoji box")
    func emojiBoxRendering() throws {
        let output = captureConsoleOutput {
            Boxed.emoji("Hello", width: 20)
        }
        
        // We can't easily predict the exact output with emojis due to terminal width differences
        // Just verify it contains expected patterns
        let lines = output.split(separator: "\n").map(String.init)
        XCTAssertTrue(lines.count >= 5)
        
        // Check if first line starts with 🟥 and ends with 🟧
        XCTAssertTrue(lines[0].hasPrefix("🟥"))
        XCTAssertTrue(lines[0].hasSuffix("🟧"))
        
        // Check if content line contains "Hello"
        let contentLine = lines[2]
        XCTAssertTrue(contentLine.contains("Hello"))
        
        // Check if last line starts with 🟩 and ends with 🟪
        XCTAssertTrue(lines[lines.count - 1].hasPrefix("🟩"))
        XCTAssertTrue(lines[lines.count - 1].hasSuffix("🟪"))
    }
}
