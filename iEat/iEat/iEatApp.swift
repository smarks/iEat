//
//  iEatApp.swift
//  iEat
//
//  Created by Spencer Marks on 6/27/24.
//

import SwiftUI
import SwiftData

@main
struct iEatApp: App {
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ActivitiesModel.self)
                }
        }
}

 
