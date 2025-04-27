<p align="center">
  <img src="https://github.com/brunogama/boxed/blob/main/assets/img/banner.png?raw=true" alt="Banner">
</p>

![Build and Test](https://github.com/brunogama/BoxedContent/actions/workflows/build.yml/badge.svg?branch=main)

A lightweight Swift package for creating beautiful ASCII and emoji boxes around text content. Perfect for CLI applications, logging, or anywhere you want to make text output more visually appealing.

## Features

- Create ASCII-style boxes around text
- Create emoji-style boxes for a more playful look
- Support for multi-line content
- Optional centered first line
- Customizable box width
- Smart width calculation based on content
- Proper handling of visual string lengths
- Customizable box styles

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Boxed.git", from: "1.0.0")
]
```

## Usage

### Basic ASCII Box

```swift
import Boxed

Boxed.ascii("Hello, World!")
```

Output:
```
┌──────────────────────┐
│                      │
│     Hello, World!    │
│                      │
└──────────────────────┘
```

### Emoji Box

```swift
import Boxed

Boxed.emoji("Welcome!\nTo my app")
```

Output:
```
🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦
⬜️                    ⬜️
⬜️     Welcome!      ⬜️
⬜️     To my app     ⬜️
⬜️                    ⬜️
🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦
```

### Customization Options

```swift
Boxed.ascii(
    "Custom Width Example",
    width: 40,
    centerFirstLine: true
)

Boxed.emoji(
    "Multiple\nLines\nOf\nText",
    width: 30,
    centerFirstLine: false
)
```

## API Reference

### ASCII Box

```swift
public static func ascii(
    _ message: String,
    width: Int = 120,
    centerFirstLine: Bool = true,
    boxStyle: BoxCharactersProvider = BoxStyle.ascii
)
```

### Emoji Box

```swift
public static func emoji(
    _ message: String,
    width: Int = 120,
    centerFirstLine: Bool = true,
    boxStyle: BoxCharactersProvider = BoxStyle.ascii
)
```

### Parameters

- `message`: The text content to be boxed (supports multiple lines using \n)
- `width`: The minimum width of the box (default: 120)
- `centerFirstLine`: Whether to center the first line of text (default: true)
- `boxStyle`: The style provider for box characters (default: BoxStyle.ascii)

## Custom Box Styles

You can create custom box styles by implementing the `BoxCharactersProvider` protocol:

```swift
public protocol BoxCharactersProvider {
    var topLeft: Character { get }
    var topRight: Character { get }
    var bottomLeft: Character { get }
    var bottomRight: Character { get }
    var horizontal: Character { get }
    var vertical: Character { get }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
