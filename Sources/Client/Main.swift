//
//  Main.swift
//  BoxedContent
//
//  Created by Bruno da Gama Porciuncula on 01/02/25.
//

import BoxedContent

func sample() {
    Boxed.ascii("Hello\nASCII Box!\nCentered First Line")
    Boxed.emoji("Hello\nEmoji Box! 🎉\nWith Multiple Lines", width: 120)
}

@main
struct Main {
    static func main() {
        sample()
    }
}

