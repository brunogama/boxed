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
        let paddingLine =
            String(box.vertical)
            + String(repeating: " ", count: contentWidth - 2)
            + String(box.vertical)
        print(paddingLine)
    }

    private static func printContent(
        lines: [String],
        box: BoxCharactersProvider,
        contentWidth: Int,
        centerFirstLine: Bool
    ) {
        for (index, line) in lines.enumerated() {
            let padding = contentWidth - 2 - line.visualLength
            let leftPadding: Int
            let rightPadding: Int

            if centerFirstLine && index == 0 {
                leftPadding = padding / 2
                rightPadding = padding - leftPadding
            } else {
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
