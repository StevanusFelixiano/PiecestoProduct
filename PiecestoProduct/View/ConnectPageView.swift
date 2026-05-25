//
//  ConnectPageView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct ConnectPageView: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("isAppleHealthConnected") private var isAppleHealthConnected = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                SettingsMenuButton()
            }
            .padding(.horizontal, 28)
            .padding(.top, 20)
            
            Spacer()
            
            ZStack {
                AnimatedHelloIllustration()
                    .scaleEffect(1.2)
                    .frame(width: 260, height: 260)
            }
            
            VStack(spacing: 10) {
                Text("We couldn’t find your sleep record yet.")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                
                Text("Connect Apple Health or add your sleep manually so we can recommend a gentle workout for today.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .padding(.top, 20)
            
            VStack(spacing: 18) {
                Button {
                    isAppleHealthConnected = true
                } label: {
                    Text(isAppleHealthConnected ? "Apple Health Connected" : "Connect to Apple Health")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.84, green: 0.47, blue: 0.49))
                        .clipShape(Capsule())
                }
                
                Button {
                } label: {
                    Text("Add Manually")
                        .font(.headline)
                        .foregroundStyle(
                            colorScheme == .dark
                            ? Color(red: 1.0, green: 0.62, blue: 0.68)
                            : Color(red: 0.84, green: 0.47, blue: 0.49)
                        )
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            colorScheme == .dark
                            ? Color(red: 0.28, green: 0.17, blue: 0.19)
                            : Color(red: 0.84, green: 0.47, blue: 0.49).opacity(0.15)
                        )
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 52)
            .padding(.top, 28)
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }
}

#Preview() {
    AppThemeManager {
        ConnectPageView()
    }
}
