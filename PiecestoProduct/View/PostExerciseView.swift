//
//  PostExerciseView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 29/05/26.
//

import SwiftUI

struct PostExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("textScale") private var textScale = 1.0
    var onBackHome: () -> Void = {}
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
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
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
                .frame(height: 60)
            
            Image("FullFlower")
                .resizable()
                .scaledToFit()
                .frame(width: 270, height: 270)
                .opacity(isDark ? 0.85 : 1.0)
            
            VStack(spacing: 8) {
                Text("You did it! Thank you for prioritizing yourself today.")
                    .font(.system(size: 17 * textScale, weight: .regular))
                    .foregroundStyle(
                        isDark
                        ? Color.white.opacity(0.88)
                        : Color(red: 0.36, green: 0.24, blue: 0.25)
                    )
                    .multilineTextAlignment(.center)
                
                Text("We hope you're feeling a bit more like yourself after taking this time for yourself")
                    .font(.system(size: 17 * textScale, weight: .regular))
                    .foregroundStyle(
                        isDark
                        ? Color.white.opacity(0.78)
                        : Color(red: 0.36, green: 0.24, blue: 0.25)
                    )
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 42)
            
            Button {
                onBackHome()
            } label: {
                Text("Back to Home")
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
                    .shadow(
                        color: isDark
                        ? Color(red: 0.82, green: 0.43, blue: 0.52).opacity(0.28)
                        : Color(red: 250/255, green: 154/255, blue: 138/255).opacity(0.28),
                        radius: 10,
                        y: 5
                    )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 52)
            .padding(.top, 40)
            
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
                    .opacity(0.92)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    AppThemeManager {
        PostExerciseView()
    }
}
