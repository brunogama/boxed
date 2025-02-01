//
//  ASCIIBoxCharacters.swift
//  BoxedContent
//
//  Created by Bruno da Gama Porciuncula on 01/02/25.
//

public struct ASCIIBoxCharacters: BoxCharactersProvider {
    public let vertical: Character = "│"
    public let horizontal: Character = "─"
    public let topLeft: Character = "┌"
    public let topRight: Character = "┐"
    public let bottomLeft: Character = "└"
    public let bottomRight: Character = "┘"
}

public struct EmojiBoxCharacters: BoxCharactersProvider {
    public let vertical: Character = "⬜️"
    public let horizontal: Character = "🟦"
    public let topLeft: Character = "🟥"
    public let topRight: Character = "🟧"
    public let bottomLeft: Character = "🟩"
    public let bottomRight: Character = "🟪"
}
