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
                if newImage != nil {
                    // Handle the captured image - we'll add upload functionality later
                    print("Photo captured!")
                }
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
