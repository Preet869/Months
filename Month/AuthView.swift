import SwiftUI
import Supabase

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSigningIn = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if isSigningIn {
                ProgressView()
            } else {
                Button("Sign In") {
                    signIn()
                }
                Button("Sign Up") {
                    signUp()
                }
            }
        }
        .padding()
    }

    private func signIn() {
        isSigningIn = true
        Task {
            do {
                try await supabase.auth.signIn(email: email, password: password)
            } catch {
                print("Error signing in: \(error.localizedDescription)")
            }
            isSigningIn = false
        }
    }

    private func signUp() {
        isSigningIn = true
        Task {
            do {
                try await supabase.auth.signUp(email: email, password: password)
            } catch {
                print("Error signing up: \(error.localizedDescription)")
            }
            isSigningIn = false
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
} 