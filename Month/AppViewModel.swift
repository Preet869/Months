import Foundation
import Supabase
import Combine

@MainActor
class AppViewModel: ObservableObject {
    @Published var session: Session?

    init() {
        // Get initial session
        Task {
            session = try? await supabase.auth.session
        }
        
        // Listen for auth changes
        Task {
            for await (event, session) in supabase.auth.authStateChanges {
                await MainActor.run {
                    self.session = session
                }
            }
        }
    }
} 