//
//  ContentView.swift
//  iEat
//
//  Created by Spencer Marks on 6/27/24.
//

import SwiftData
import SwiftUI

var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd"
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
            
                List(activities) { item in
                    Text(item.amount)
                
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
                    Button("Add Activity") {
                        let activity:ActivityModel = ActivityModel()
                        modelContext.insert(activity)
                    }
                }.sheet(isPresented: $showingSettings) {
                     
                }
        }
    }
}
