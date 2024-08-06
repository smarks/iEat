//
//  ContentView.swift
//  iEat
//
//  Created by Spencer Marks on 6/27/24.
//

import SwiftData
import SwiftUI

private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .short
       formatter.timeStyle = .short
       return formatter
   }()

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State var showingAddEntry: Bool = false
    @State var showingSettings: Bool = false
    @Query private var activities: [ActivityModel]

    var body: some View {
        NavigationStack {
            List {
                ForEach(activities) { item in
                    ActivitySummaryView(activity: item)
                }.onDelete(perform: delete)
                
            }.navigationTitle("iEat")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddEntry = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }.sheet(isPresented: $showingAddEntry) {
                    ActivityEditor(activity: ActivityModel())
                }.sheet(isPresented: $showingSettings) {
                    SettingView(settings: Settings())
                }
        }
    }

    func delete(at offsets: IndexSet) {
        print(offsets)
        modelContext.delete(activities[offsets.count - 1])
    }
}

struct ActivitySummaryView : View {
    @State var activity:ActivityModel
    var body: some View {
        VStack{
            Text(dateFormatter.string(from: activity.time)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text(activity.activity_description)
            Text(activity.amount)
        }
    }
}
