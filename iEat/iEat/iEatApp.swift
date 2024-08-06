import SwiftUI
import SwiftData

@main
struct IEatApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ActivityModel.self)
        } catch {
            // try cleaning build folder and erasing content on simulator 
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
