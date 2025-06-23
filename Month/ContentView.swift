//
//  ContentView.swift
//  Month
//
//  Created by Preet Dhillon on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appViewModel: AppViewModel
    @State private var isCameraPresented = false
    @State private var capturedImage: UIImage?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<12) { index in
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                            
                            Text(month(for: index))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    isCameraPresented = true
                }) {
                    Text("Take Photo")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Your Year")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Out") {
                        Task {
                            try? await supabase.auth.signOut()
                        }
                    }
                }
            }
            .sheet(isPresented: $isCameraPresented) {
                CameraView(isPresented: $isCameraPresented, capturedImage: $capturedImage)
            }
            .onChange(of: capturedImage) { _, newImage in
                if let image = newImage {
                    uploadPhoto(image)
                }
            }
        }
    }
    
    private func uploadPhoto(_ image: UIImage) {
        guard let userId = appViewModel.session?.user.id,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("User not logged in or image data is invalid.")
            return
        }

        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentYear = calendar.component(.year, from: Date())
        let fileName = "\(currentYear)-\(currentMonth).jpeg"
        let filePath = "\(userId)/\(fileName)"

        Task {
            do {
                print("Uploading photo...")
                try await supabase.storage
                    .from("photos")
                    .upload(path: filePath, file: imageData, options: .init(contentType: "image/jpeg"))
                print("Photo uploaded successfully!")
            } catch {
                print("Error uploading photo: \(error.localizedDescription)")
            }
        }
    }
    
    private func month(for index: Int) -> String {
        let formatter = DateFormatter()
        return formatter.shortMonthSymbols[index]
    }
}

#Preview {
    ContentView()
}
