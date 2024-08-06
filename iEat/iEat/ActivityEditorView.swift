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
    @State private var activity: ActivityModel

     /*
    @State private var time: Date = activ
    @State private var activityDescription: String = ""
    @State private var activityType: ActivityType = .eat
    @State private var amount: String = ""
    @State private var location: Locations = .home
    @State private var mood: Mood = .netural
    @State private var emotionalInfluence: EmotionalInflunce = .none
    @State private var thoughts: String = ""
    @State private var hungerScale: HungerScale = .netural
    @State private var fullness: HungerScale = .netural
 */

    init(activity:ActivityModel){
        self.activity = activity
    }
    
    var body: some View {

        NavigationStack {
        
            Form {
                Section(header: Text("Activity Details")) {
                    DatePicker("Time", selection: $activity.time, displayedComponents: .hourAndMinute)
                    TextField("Description", text: $activity.activity_description)
                    Picker("Activity Type", selection: $activity.activityType) {
                        ForEach(ActivityType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    TextField("Amount", text: $activity.amount)
                    Picker("Location", selection: $activity.location) {
                        ForEach(Locations.allCases) { loc in
                            Text(loc.rawValue.capitalized).tag(loc)
                        }
                    }
                }

                Section(header: Text("Emotional State")) {
                    Picker("Mood", selection: $activity.mood) {
                        ForEach(Mood.allCases) { mood in
                            Text(mood.rawValue.capitalized).tag(mood)
                        }
                    }
                    Picker("Emotional Influence", selection: $activity.emotionalInflunce) {
                        ForEach(EmotionalInflunce.allCases) { influence in
                            Text(influence.rawValue.capitalized).tag(influence)
                        }
                    }
                    TextField("Thoughts", text: $activity.thoughts)
                }

                Section(header: Text("Hunger Levels")) {
                    Picker("Hunger Scale", selection: $activity.hungerScale) {
                        ForEach(HungerScale.allCases) { scale in
                            Text(scale.rawValue.capitalized).tag(scale)
                        }
                    }
                    Picker("Fullness", selection: $activity.fullness) {
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
        modelContext.insert(activity)
        print("Saving activity")
        print(activity)
    }
}

struct ActivityEditor_Previews: PreviewProvider {
    static var previews: some View {
        let activity:ActivityModel = ActivityModel()
        ActivityEditor(activity: activity)
    }
}
