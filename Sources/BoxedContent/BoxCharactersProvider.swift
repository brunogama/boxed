//
//  BoxCharactersProvider.swift
//  BoxedContent
//
//  Created by Bruno da Gama Porciuncula on 01/02/25.
//

import Foundation

public protocol BoxCharactersProvider {
    var vertical: Character { get }
    var horizontal: Character { get }
    var topLeft: Character { get }
    var topRight: Character { get }
    var bottomLeft: Character { get }
    var bottomRight: Character { get }
}
