import Foundation

public enum Boxed {
    // MARK: - Public Interface

    public static func ascii(
        _ message: String,
        width: Int = 120,
        centerFirstLine: Bool = true,
        boxStyle: BoxCharactersProvider = BoxStyle.ascii
    ) {
        draw(
            message: message,
            width: width,
            box: boxStyle,
            centerFirstLine: centerFirstLine)
    }

    public static func emoji(
        _ message: String,
        width: Int = 120,
        centerFirstLine: Bool = true,
        boxStyle: BoxCharactersProvider = BoxStyle.ascii
    ) {
        draw(
            message: message,
            width: width,
            box: EmojiBoxCharacters(),
            centerFirstLine: centerFirstLine)
    }

    private static func draw(
        message: String,
        width: Int,
        box: BoxCharactersProvider,
        centerFirstLine: Bool
    ) {
        let lines = message.components(separatedBy: "\n")
        let maxWidth = lines.map { $0.visualLength }.max() ?? 0

        let contentWidth = max(width, maxWidth + 4)
        let horizontalCount = calculateHorizontalCount(
            contentWidth: contentWidth,
            box: box
        )

        printTopBorder(box: box, count: horizontalCount)
        printVerticalPadding(box: box, contentWidth: contentWidth)
        printContent(
            lines: lines, box: box, contentWidth: contentWidth,
            centerFirstLine: centerFirstLine)
        printVerticalPadding(box: box, contentWidth: contentWidth)
        printBottomBorder(box: box, count: horizontalCount)
    }

    private static func calculateHorizontalCount(
        contentWidth: Int, box: BoxCharactersProvider
    ) -> Int {
        let totalHorizontalWidth =
            contentWidth
            - box.topLeft.terminalWidth
            - box.topRight.terminalWidth

        return Int(
            (Double(totalHorizontalWidth) / Double(box.horizontal.terminalWidth))
                .rounded(.down))
    }

    private static func printTopBorder(box: BoxCharactersProvider, count: Int) {
        print(
            String(box.topLeft)
                + String(repeating: box.horizontal, count: count)
                + String(box.topRight))
    }

    private static func printBottomBorder(
        box: BoxCharactersProvider, count: Int
    ) {
        print(
            String(box.bottomLeft)
                + String(repeating: box.horizontal, count: count)
                + String(box.bottomRight))
    }

    private static func printVerticalPadding(
        box: BoxCharactersProvider, contentWidth: Int
    ) {
        let innerWidth = contentWidth - box.vertical.terminalWidth * 2
        guard innerWidth >= 0 else {
            // Handle cases where contentWidth is too small for borders
            print(String(box.vertical) + String(box.vertical))
            return
        }
        let paddingLine =
            String(box.vertical)
            + String(repeating: " ", count: innerWidth)
            + String(box.vertical)
        print(paddingLine)
    }

    private static func printContent(
        lines: [String],
        box: BoxCharactersProvider,
        contentWidth: Int,
        centerFirstLine: Bool
    ) {
        let innerWidth = contentWidth - box.vertical.terminalWidth * 2
        guard innerWidth >= 0 else { return } // Not enough space for content

        for (index, line) in lines.enumerated() {
            let lineVisualLength = line.visualLength
            guard lineVisualLength <= innerWidth else {
                // Handle lines too long for the inner width (optional: truncate or error)
                // Use prefix(while:) approach summing terminalWidth
                var currentWidth = 0
                let truncatedLineContent = line.prefix { char in
                    let charWidth = char.terminalWidth
                    if currentWidth + charWidth <= innerWidth {
                        currentWidth += charWidth
                        return true
                    } else {
                        return false
                    }
                }
                let truncatedLine = String(truncatedLineContent)
                let truncatedPadding = innerWidth - currentWidth // Use the calculated currentWidth
                let contentLine =
                    String(box.vertical)
                    + truncatedLine
                    + String(repeating: " ", count: truncatedPadding)
                    + String(box.vertical)
                print(contentLine)
                continue
            }

            let padding = innerWidth - lineVisualLength
            let leftPadding: Int
            let rightPadding: Int

            if centerFirstLine && index == 0 {
                leftPadding = padding / 2
                rightPadding = padding - leftPadding
            } else {
                // Adjust default padding if needed, e.g., ensure at least 1 space
                leftPadding = 1
                rightPadding = padding - 1
            }

            let contentLine =
                String(box.vertical)
                + String(repeating: " ", count: leftPadding)
                + line
                + String(repeating: " ", count: rightPadding)
                + String(box.vertical)

            print(contentLine)
        }
    }
}
