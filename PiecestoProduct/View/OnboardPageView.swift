//
//  OnboardPageView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct OnboardPageView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("hasSeenOnboard") private var hasSeenOnboard = false
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var showSettings = false
    
    private var isDark: Bool {
        colorScheme == .dark
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
            ZStack(alignment: .topLeading){
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
                .frame(height: 85)
            AnimatedHelloIllustration()
                .scaleEffect(1.2)
                .frame(width: 260, height: 230)
                .padding(.vertical, 12)
            
            VStack(spacing: 10) {
                Text("Your wellbeing starts here")
                    .font(.system(size: 22 * textScale, weight: .bold))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 1.00, green: 0.84, blue: 0.86)
                        : Color(red: 0.36, green: 0.27, blue: 0.16)
                    )
                    .multilineTextAlignment(.center)
                
                Text("Let's start with a gentle check-in, so we can recommend a routine that honors your energy and wellbeing today.")
                    .font(.system(size: 16 * textScale))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 0.86, green: 0.72, blue: 0.74)
                        : Color(red: 0.46, green: 0.36, blue: 0.35)
                    )
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            VStack(spacing: 18) {
                Button {
                    hasSeenOnboard = true
                } label: {
                    Text("Get Started")
                        .font(.system(size: 17 * textScale, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 120)
                        .padding()
                        .background(
                            isDark
                            ? Color(red: 0.82, green: 0.43, blue: 0.52)
                            : Color(red: 250/255, green: 154/255, blue: 138/255)
                        )
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 52)
            .padding(.top, 28)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AppThemeManager {
        OnboardPageView()
    }
}
