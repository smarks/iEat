//
//  ActivityModel.swift
//  iEat
//
//  Created by Spencer Marks on 7/2/24.
//

import Foundation
import SwiftData
import SwiftUI

enum ActivityType: String, Codable, CaseIterable, Identifiable {
    case eat
    case exercise
    var id: Self { self }
}

enum Mood: String, Codable, CaseIterable, Identifiable {
    case sader
    case sad
    case netural
    case happy
    case happier
    var id: Self { self }
}

enum EmotionalInflunce: String, Codable, CaseIterable, Identifiable {
    /* You ate for emotional reasons at a time when you would not have otherwise been eating
       You ate a particular food for emotional reasons that you would not have otherwise eaten
       You ate more food than you would have otherwise eaten, for an emotional reason.
     */
    case ate_at_specific_time
    case ate_specific_food
    case ate_more
    case none
    var id: Self { self }
}

enum Locations: String, Codable, CaseIterable, Identifiable {
    case home_office
    case home
    case work
    case desk
    case resturant
    case dinning_room
    var id: Self { self }
}

enum HungerScale: String, Codable, CaseIterable, Identifiable {
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
    var id: Self { self }
}

@Model
class ActivityModel {
    let id = UUID()
    var time: Date
    var activity_description: String
    var activityType: ActivityType
    var amount: String
    var location: Locations
    var mood: Mood
    var emotionalInflunce: EmotionalInflunce
    var thoughts: String
    var hungerScale: HungerScale
    var fullness: HungerScale

    init(time: Date = Date(),
         activity_description: String? = "description",
         activityType: ActivityType = .eat,
         amount: String = "amount",
         location: Locations = .home,
         mood: Mood = .netural,
         emotionalInflunce: EmotionalInflunce = .none,
         thoughts: String = "",
         hungerScale: HungerScale = .netural,
         fullness: HungerScale = .netural) {
        

        self.time = time
        self.activity_description = activity_description ?? "value"
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
    var activities: [ActivityModel]

    init(items: [ActivityModel] = []) {
        activities = items
    }
}
