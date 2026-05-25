//
//  MenuButton.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct SettingsMenuButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("hasSetThemeManually") private var hasSetThemeManually = false
    @AppStorage("isAppleHealthConnected") private var isAppleHealthConnected = false
    
    var body: some View {
        Menu {
            Section {
                Toggle(isOn: Binding(
                    get: {
                        isDarkMode
                    },
                    set: { newValue in
                        isDarkMode = newValue
                        hasSetThemeManually = true
                    }
                )) {
                    Label(
                        isDarkMode ? "Dark Mode On" : "Dark Mode Off",
                        systemImage: isDarkMode ? "moon.fill" : "sun.max.fill"
                    )
                }
            }
            
            Section {
                Button {
                    isAppleHealthConnected.toggle()
                } label: {
                    Label(
                        isAppleHealthConnected ? "Disconnect Apple Health" : "Connect Apple Health",
                        systemImage: isAppleHealthConnected ? "heart.slash.fill" : "heart.fill"
                    )
                }
            }
        } label: {
            MenuButton()
        }
        .onAppear {
            if !hasSetThemeManually {
                isDarkMode = colorScheme == .dark
            }
        }
    }
}

struct MenuButton: View {
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .font(.system(size: 26, weight: .bold))
            .foregroundStyle(.white)
            .padding(16)
            .background(.gray.opacity(0.8))
            .clipShape(Circle())
            .shadow(radius: 8)
    }
}

#Preview("Settings Menu Button") {
    AppThemeManager {
        SettingsMenuButton()
    }
}
