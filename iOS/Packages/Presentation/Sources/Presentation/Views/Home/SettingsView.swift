import Shared
import SwiftUI
import UseCases

/// Settings view
struct SettingsView: View {
    @Environment(\.dependencies) private var dependencies
    @State private var showSignOutConfirmation = false

    var body: some View {
        List {
            Section {
                NavigationLink {
                    ProfileView()
                } label: {
                    Label("Profile", systemImage: "person.circle")
                }
            }

            Section {
                Link(destination: URL(string: "https://example.com/privacy")!) {
                    Label("Privacy Policy", systemImage: "hand.raised")
                }

                Link(destination: URL(string: "https://example.com/terms")!) {
                    Label("Terms of Service", systemImage: "doc.text")
                }
            }

            Section {
                Button(role: .destructive) {
                    showSignOutConfirmation = true
                } label: {
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }

            Section {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog("Sign Out", isPresented: $showSignOutConfirmation) {
            Button("Sign Out", role: .destructive) {
                Task { await signOut() }
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }

    private func signOut() async {
        do {
            try await dependencies.useCases.auth.signOut()
        } catch {
            print("Failed to sign out: \(error)")
        }
    }
}

struct ProfileView: View {
    @Environment(\.dependencies) private var dependencies
    @State private var profile: UserProfile?
    @State private var isLoading = true

    var body: some View {
        Form {
            if let profile {
                Section {
                    LabeledContent("Display Name", value: profile.displayName)
                    if let email = profile.email {
                        LabeledContent("Email", value: email)
                    }
                }

                Section {
                    LabeledContent("Member Since", value: profile.createdAt.formatted(style: .medium))
                }
            }
        }
        .navigationTitle("Profile")
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
        .task {
            await loadProfile()
        }
    }

    private func loadProfile() async {
        do {
            profile = try await dependencies.useCases.profile.getProfile()
        } catch {
            print("Failed to load profile: \(error)")
        }
        isLoading = false
    }
}
