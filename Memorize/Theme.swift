//
//  Theme.swift
//  Memorize
//
//  Created by Roman on 1/11/23.
//

import Foundation
import SwiftUI

struct Theme{
    var emojis: Array<String>
    private(set) var name: String
    private(set) var numberOfPairs: Int
    private(set) var color: String
    
    init(name: String, numberOfPairs: Int, color: String, emojis: Array<String>){
        self.name = name
        self.numberOfPairs = numberOfPairs
        self.color = color
        self.emojis = emojis
    }
}


