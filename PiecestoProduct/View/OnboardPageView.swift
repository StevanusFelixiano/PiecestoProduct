//
//  OnboardPageView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct OnboardPageView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
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
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Image("TopFlower")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280)
                    .offset(x: -34, y: -40)
                    .ignoresSafeArea()
                
                Image("BotFlower")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .offset(x: 35, y: 30)
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
            .padding(.horizontal, 28)
            .padding(.top, 20)
            
            AnimatedHelloIllustration()
                .scaleEffect(1.2)
                .frame(width: 260, height: 260)
            
            VStack(spacing: 10) {
                Text("Your wellbeing starts here")
                    .font(.system(size: 22 * textScale, weight: .bold))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 1.00, green: 0.84, blue: 0.86)
                        : Color(red: 0.36, green: 0.24, blue: 0.25)
                    )
                    .multilineTextAlignment(.center)
                
                Text("Let’s start with a gentle check-in so we can recommend workouts that match your energy and wellbeing today.")
                    .font(.system(size: 17 * textScale))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 0.86, green: 0.72, blue: 0.74)
                        : Color(red: 0.46, green: 0.36, blue: 0.35)
                    )
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .padding(.top, 20)
            
            VStack(spacing: 18) {
                Button {
                    hasCompletedInitialSetup = true
                } label: {
                    Text("Get Started")
                        .font(.system(size: 17 * textScale, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
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
