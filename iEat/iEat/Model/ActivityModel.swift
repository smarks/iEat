//
//  ActivityModel.swift
//  iEat
//
//  Created by Spencer Marks on 7/2/24.
//

import Foundation
import SwiftData
import SwiftUI

enum ActivityType: Codable {
    case eat
    case exercise
}

enum Mood: Codable {
    case sader
    case sad
    case netural
    case happy
    case happier
}

enum EmotionalInflunce: Codable {
    /* You ate for emotional reasons at a time when you would not have otherwise been eating
       You ate a particular food for emotional reasons that you would not have otherwise eaten
       You ate more food than you would have otherwise eaten, for an emotional reason.
     */
    case ate_at_specific_time
    case ate_specific_food
    case ate_more
    case none
}

enum Locations: Codable {
    case home_office
    case home
    case work
    case desk
    case resturant
    case dinning_room
}

enum HungerScale: Codable {
    case starving
    case eat_anything_in_sight
    case intense
    case strong
    case mild
    case netural
    case satifisied
    case full
    case uncomfortably_full
    case stuffed
}

@Model
class ActivityModel {
    var time: Date
    var activityType: ActivityType
    var amount: String
    var location: Locations
    var mood: Mood
    var emotionalInflunce: EmotionalInflunce
    var thoughts: String
    var hungerScale: HungerScale
    var fullness: HungerScale

    init(time: Date = Date(),
         activityType: ActivityType = ActivityType.eat,
         amount: String = "amount",
         location: Locations = Locations.home,
         mood: Mood = Mood.netural,
         emotionalInflunce: EmotionalInflunce = EmotionalInflunce.none,
         thoughts: String = "",
         hungerScale: HungerScale = HungerScale.netural,
         fullness: HungerScale = HungerScale.netural) {
        self.time = time
        self.activityType = activityType
        self.amount = amount
        self.location = location
        self.mood = mood
        self.emotionalInflunce = emotionalInflunce
        self.thoughts = thoughts
        self.hungerScale = hungerScale
        self.fullness = fullness
    }
}

@Model
class ActivitiesModel {
 
    var activities:[ActivityModel]
    
    init(items:[ActivityModel] = []) {
        self.activities = items
    }
}

