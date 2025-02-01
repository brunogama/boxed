//
//  BoxStyle.swift
//  BoxedContent
//
//  Created by Bruno da Gama Porciuncula on 01/02/25.
//

public enum BoxStyle: BoxCharactersProvider {
    case ascii
    case emoji
    
    public var vertical: Character {
        switch self {
        case .ascii: return "│"
        case .emoji: return "⬜️"
        }
    }
    
    public var horizontal: Character {
        switch self {
        case .ascii: return "─"
        case .emoji: return "🟦"
        }
    }
    
    public var topLeft: Character {
        switch self {
        case .ascii: return "┌"
        case .emoji: return "🟥"
        }
    }
    
    public var topRight: Character {
        switch self {
        case .ascii: return "┐"
        case .emoji: return "🟧"
        }
    }
    
    public var bottomLeft: Character {
        switch self {
        case .ascii: return "└"
        case .emoji: return "🟩"
        }
    }
    
    public var bottomRight: Character {
        switch self {
        case .ascii: return "┘"
        case .emoji: return "🟪"
        }
    }
}
