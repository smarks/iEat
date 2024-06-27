//
//  Item.swift
//  iEat
//
//  Created by Spencer Marks on 6/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
