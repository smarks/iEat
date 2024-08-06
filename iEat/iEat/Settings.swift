//
//  Settings.swift
//  iEat
//
//  Created by Spencer Marks on 8/6/24.
//


import Combine
import Foundation
import SwiftUI
import SwiftData


enum SettingsTypes: String, CaseIterable, Hashable {
    case budgets = "Budgets"
    case dataManagement = "Data Management"
    case categories = "Categories"
    case mediations = "Mdiations"
    case about = "About"
}

class Settings: ObservableObject {
    @Published var appVersion: String {
        didSet {
            appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
        }
    }

    init() {
        appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    }
}

struct SettingView: View {
    @State var settings: Settings
    @Environment(\.dismiss) var dismiss
   
    @State var showDataManagementView: Bool = false
    @State var showAboutView: Bool = false

    var isDirty: Bool = false
    var disableSave: Bool {
        isDirty
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                   
                    Button {
                        showDataManagementView = true
                    } label: {
                        Text("Datat Management")
                    }.frame(alignment: .leading)
                
                    Button {
                        showAboutView = true
                    } label: {
                        Text("About")
                    }
                }
            }
            .navigationTitle("Preferences and Settings").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(false)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }

        
        }.sheet(isPresented: $showDataManagementView) {
            DataManagementView()
      
        }.sheet(isPresented: $showAboutView) {
            AboutView(version: settings.appVersion, buildNumber: Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String, appIcon: AppIconProvider.appIcon())
        }
    }
}

enum AppIconProvider {
    static func appIcon(in bundle: Bundle = .main) -> String {
        // Attempt to retrieve the macOS app icon name
        if let iconFileName = bundle.object(forInfoDictionaryKey: "CFBundleIconFile") as? String {
            return iconFileName
        }

        // Attempt to retrieve the iOS app icon name
        guard let icons = bundle.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last else {
            fatalError("Could not find icons in bundle")
        }

        return iconFileName
    }
}


struct DataManagementView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var isPresentingConfirm: Bool = false
    @State private var showAlert = false
    
    @Query private var activities: [ActivityModel]

    var exportButtonLabel: String {
        if activities.isEmpty {
            "Export (No data to export)"
        } else {
            "Export"
        }
    }

    var body: some View {
        NavigationView {
            List {
                Button("Reset", role: .destructive) {
                    isPresentingConfirm = true

                }.confirmationDialog("Are you sure?",
                                     isPresented: $isPresentingConfirm) {
                    Button("Delete all data and restore defaults?", role: .destructive) {
                        for activity in activities {
                            modelContext.delete(activity)
                        }
                    }
                }

                Button(exportButtonLabel) {
                    let csvString = generateCSV(from: activities)
                    UIPasteboard.general.string = csvString
                    print("CSV string copied to clipboard.")
                    showAlert = true

                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("\(activities.count) exported "),
                        message: Text("Your data is now in  ready to paste into a file. Save the file with a .csv extension and view in your favorite spreadsheet program"),
                        dismissButton: .default(Text("OK"))
                    )
                }.disabled(activities.isEmpty)

            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

func generateCSV(from activities: [ActivityModel]) -> String {
    var csvString = "id,name,type,amount,note,date\n"

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none

    for activity in activities {
        let dateString = dateFormatter.string(from: activity.time)
        let escapedNote = activity.activity_description.replacingOccurrences(of: "\"", with: "\"\"") // Escape double quotes
        let csvRow = """
        "\(activity.activity_description),\(activity.thoughts),\(activity.amount),"\(escapedNote)",\(dateString)\n
        """
        csvString.append(contentsOf: csvRow)
    }

    return csvString

}


struct AboutView: View {
    let version: String
    let buildNumber: String
    let appIcon: String

    var body: some View {
        VStack(spacing: 10) {
            appTitle
            appIconImage
            appDescription
            versionInformation
            developerInformation
            linksSection
        }
        .padding()
    }

    private var appTitle: some View {
        Text("iSpend")
            .bold()
            .font(.system(size: 18))
    }

    private var appIconImage: some View {
        // Correctly handle the optional UIImage and ensure a view is always returned
        Group {
            if let image = UIImage(named: appIcon) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                // Provide a fallback view in case the image is not found
                Image(systemName: "app.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
    }

    private var appDescription: some View {
        Text("Thoughtful eating made easier")
            .italic()
            .font(.system(size: 12))
    }

    private var versionInformation: some View {
        VStack {
            Text("Version \(version)")
                .font(.system(size: 14))
            Text("(build \(buildNumber))")
                .font(.system(size: 12))
        }
    }

    private var developerInformation: some View {
        VStack {
            Text("Designed & Programmed by:")
                .font(.system(size: 12))
            Text("Spencer Marks ⌭ Origami Software")
                .font(.system(size: 12))
        }
    }

    private var linksSection: some View {
        VStack {
            Link("Origami Software", destination: URL(string: "https://origamisoftware.com")!)
            Link("Privacy Policy", destination: URL(string: "https://origamisoftware.com/about/ispend-privacy")!)
            Link("Thanks Paul", destination: URL(string: "https://www.hackingwithswift.com")!)
        }
        .font(.system(size: 12))
    }
}

struct About: Identifiable, Hashable {
    let name: String
    let id: Int
}
