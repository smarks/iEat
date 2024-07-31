//
//  ActivityEditorView.swift
//  iEat
//
//  Created by Spencer Marks on 7/30/24.
//

import Foundation
import SwiftUI

struct ActivityEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var time: Date = Date()
    @State private var activityDescription: String = ""
    @State private var activityType: ActivityType = .eat
    @State private var amount: String = ""
    @State private var location: Locations = .home
    @State private var mood: Mood = .netural
    @State private var emotionalInfluence: EmotionalInflunce = .none
    @State private var thoughts: String = ""
    @State private var hungerScale: HungerScale = .netural
    @State private var fullness: HungerScale = .netural

    var body: some View {

        NavigationStack {
        
            Form {
                Section(header: Text("Activity Details")) {
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    TextField("Description", text: $activityDescription)
                    Picker("Activity Type", selection: $activityType) {
                        ForEach(ActivityType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    TextField("Amount", text: $amount)
                    Picker("Location", selection: $location) {
                        ForEach(Locations.allCases) { loc in
                            Text(loc.rawValue.capitalized).tag(loc)
                        }
                    }
                }

                Section(header: Text("Emotional State")) {
                    Picker("Mood", selection: $mood) {
                        ForEach(Mood.allCases) { mood in
                            Text(mood.rawValue.capitalized).tag(mood)
                        }
                    }
                    Picker("Emotional Influence", selection: $emotionalInfluence) {
                        ForEach(EmotionalInflunce.allCases) { influence in
                            Text(influence.rawValue.capitalized).tag(influence)
                        }
                    }
                    TextField("Thoughts", text: $thoughts)
                }

                Section(header: Text("Hunger Levels")) {
                    Picker("Hunger Scale", selection: $hungerScale) {
                        ForEach(HungerScale.allCases) { scale in
                            Text(scale.rawValue.capitalized).tag(scale)
                        }
                    }
                    Picker("Fullness", selection: $fullness) {
                        ForEach(HungerScale.allCases) { scale in
                            Text(scale.rawValue.capitalized).tag(scale)
                        }
                    }
                }
            }
            .navigationTitle("Activity Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveActivity()
                        dismiss()
                    }
                }
            }
        }
        .modelContainer(for: [ActivityModel.self])

    }

    private func saveActivity() {
        print("Activity saved")
        let activity: ActivityModel = ActivityModel()
        activity.activityType = activityType
        activity.amount = amount
        activity.emotionalInflunce = emotionalInfluence
        activity.fullness = fullness
        activity.hungerScale = hungerScale
        activity.location = location
        activity.mood = mood
        activity.thoughts = thoughts
        activity.time = time
        activity.activity_description = activityDescription

        modelContext.insert(activity)
        print(activity)
    }
}

struct ActivityEditor_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEditor()
    }
}
