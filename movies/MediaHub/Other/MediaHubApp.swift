import FirebaseCore
import SwiftUI

@main
struct MediaHubApp: App {
    init () {
        FirebaseApp.configure();
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
