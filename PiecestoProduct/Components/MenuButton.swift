//
//  MenuButton.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct MenuButton: View {
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .font(.system(size: 22, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 48, height: 48)
            .background(Color(red: 0.980, green: 0.604, blue: 0.541))
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.white.opacity(0.35), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.12), radius: 6, y: 3)
    }
}

struct SettingsPopoverView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("hasSetThemeManually") private var hasSetThemeManually = false
    @AppStorage("textScale") private var textScale = 1.0
    
    var body: some View {
        VStack(spacing: 18) {
            Text("Larger Text")
                .font(.headline)
                .foregroundStyle(.primary)
            
            VStack(spacing: 8) {
                HStack {
                    Text("A")
                        .font(.caption.bold())
                    
                    Slider(value: $textScale, in: 1.0...1.3, step: 0.05)
                    
                    Text("A")
                        .font(.title2.bold())
                }
                
                Text("Text Size \(Int(textScale * 100))%")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(
                        colorScheme == .dark
                        ? Color.white.opacity(0.85)
                        : Color(red: 0.36, green: 0.24, blue: 0.25)
                    )
            }
            
            Divider()
            
            Toggle(isOn: Binding(
                get: {
                    isDarkMode
                },
                set: { newValue in
                    isDarkMode = newValue
                    hasSetThemeManually = true
                }
            )) {
                Label("Dark Mode", systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.12), radius: 18, y: 8)
        .onAppear {
            if !hasSetThemeManually {
                isDarkMode = colorScheme == .dark
            }
        }
    }
}

#Preview("Settings Menu Button") {
    AppThemeManager {
        MenuButton()
    }
}
