//
//  AddNameView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 02/06/26.
//

import SwiftUI

struct AddNameView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("userName") private var userName = ""
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var nameInput = ""
    @State private var showSettings = false
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var mainTextColor: Color {
        isDark
        ? Color(red: 1.00, green: 0.84, blue: 0.86)
        : Color(red: 0.36, green: 0.27, blue: 0.24)
    }
    
    private var secondaryTextColor: Color {
        isDark
        ? Color(red: 0.86, green: 0.72, blue: 0.74)
        : Color(red: 0.46, green: 0.36, blue: 0.35)
    }
    
    private var accentColor: Color {
        isDark
        ? Color(red: 0.82, green: 0.43, blue: 0.52)
        : Color(red: 250/255, green: 154/255, blue: 138/255)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            mainContent
            
            if showSettings {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                            showSettings = false
                        }
                    }
                    .zIndex(20)
                
                SettingsPopoverView()
                    .frame(width: 280)
                    .padding(.trailing, 28)
                    .padding(.top, 20)
                    .transition(
                        .scale(scale: 0.92, anchor: .topTrailing)
                        .combined(with: .opacity)
                    )
                    .zIndex(30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundView
        }
    }
    
    private var mainContent: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                        showSettings = true
                    }
                } label: {
                    MenuButton()
                }
                .buttonStyle(.plain)
                .opacity(showSettings ? 0 : 1)
                .allowsHitTesting(!showSettings)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(spacing: 18) {
                Text("Welcome,")
                    .font(.system(size: 45 * textScale, weight: .bold))
                    .foregroundStyle(mainTextColor)
                
                Text("What should we call you?")
                    .font(.system(size: 18 * textScale, weight: .regular))
                    .foregroundStyle(secondaryTextColor)
            }
            .multilineTextAlignment(.center)
            
            VStack(spacing: 8) {
                TextField("Your Name", text: $nameInput)
                    .font(.system(size: 17 * textScale, weight: .semibold))
                    .foregroundStyle(mainTextColor)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 32)
                
                Rectangle()
                    .fill(accentColor.opacity(isDark ? 0.65 : 0.75))
                    .frame(height: 1)
                    .padding(.horizontal, 82)
            }
            .padding(.top, 44)
            
            Button {
                let trimmedName = nameInput.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if !trimmedName.isEmpty {
                    userName = trimmedName
                    hasCompletedInitialSetup = true
                }
            } label: {
                Text("Continue")
                    .font(.system(size: 17 * textScale, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(accentColor)
                    .clipShape(Capsule())
            }
            .disabled(nameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(nameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.55 : 1)
            .padding(.horizontal, 80)
            .padding(.top, 36)
            
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var backgroundView: some View {
        ZStack(alignment: .topLeading) {
            Image("OnboardBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("TopFlower")
                .resizable()
                .scaledToFit()
                .frame(width: 280)
                .offset(x: -36, y: -40)
                .opacity(1.1)
                .ignoresSafeArea()
            
            Image("BotFlower")
                .resizable()
                .scaledToFit()
                .frame(width: 280)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .offset(x: 37, y: 30)
                .opacity(1.1)
                .ignoresSafeArea()
            
            if isDark {
                Color(red: 0.10, green: 0.07, blue: 0.09)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    AppThemeManager {
        AddNameView()
    }
}
