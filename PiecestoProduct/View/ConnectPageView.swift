//
//  ConnectPageView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct ConnectPageView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                SettingsMenuButton()
            }
            .padding(.horizontal, 28)
            .padding(.top, 20)
            
            Spacer()
            
            AnimatedHelloIllustration()
                .scaleEffect(1.2)
                .frame(width: 260, height: 260)
            
            VStack(spacing: 10) {
                Text("Your wellbeing starts here")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                
                Text("Let’s start with a gentle check-in so we can recommend workouts that match your energy and wellbeing today.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .padding(.top, 20)
            
            VStack(spacing: 18) {
                Button {
                    hasCompletedInitialSetup = true
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.84, green: 0.47, blue: 0.49))
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 52)
            .padding(.top, 28)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            colorScheme == .dark
            ? Color(red: 0.10, green: 0.07, blue: 0.09)
            : Color(.systemBackground)
        )
    }
}

#Preview {
    AppThemeManager {
        ConnectPageView()
    }
}
