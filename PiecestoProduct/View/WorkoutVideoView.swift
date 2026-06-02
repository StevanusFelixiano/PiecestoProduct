//
//  WorkoutPlanView.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 29/05/26.
//

import SwiftUI

struct WorkoutVideoView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var showSettings = false
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var peach: Color {
        Color(red: 250/255, green: 154/255, blue: 138/255)
    }
    
    private var darkPeach: Color {
        Color(red: 0.82, green: 0.43, blue: 0.52)
    }
    
    private var textBrown: Color {
        Color(red: 0.46, green: 0.36, blue: 0.35)
    }
    
    private let steps = [
        "Sit comfortably on your mat",
        "Start with gentle neck and shoulder stretches",
        "Slowly roll your shoulders and loosen your back",
        "Follow light core and leg movements",
        "Focus on breathing and moving at your own pace",
        "Finish with a full body stretch and short rest"
    ]
    
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
                    .padding(.top, 58)
                    .transition(
                        .scale(scale: 0.92, anchor: .topTrailing)
                        .combined(with: .opacity)
                    )
                    .zIndex(30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var mainContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerArea
                
                VStack(alignment: .leading, spacing: 24) {
                    videoSection
                    
                    stepsSection
                    
                    Button {
                        // TODO: navigate to BreathingExerciseView
                    } label: {
                        Text("Breathing Exercise")
                            .font(.system(size: 17 * textScale, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 160, height: 15)
                            .padding(16)
                            .background(isDark ? darkPeach : peach)
                            .clipShape(Capsule())
                            .shadow(
                                color: (isDark ? darkPeach : peach).opacity(0.30),
                                radius: 10,
                                y: 5
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background {
            backgroundView
        }
    }
    
    private var headerArea: some View {
        ZStack(alignment: .topTrailing) {
            Header(
                content: HeaderContent(
                    title: "WORKOUT",
                    subtitle: "Mat Pilates with Julius",
                    description: "Gentle movements to help you feel stronger and lighter"
                ),
                flowerOffset: CGSize(width: 230, height: 110)
            )
            
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
            .padding(.trailing, 28)
            .padding(.top, 58)
        }
    }
    
    private var backgroundView: some View {
        ZStack {
            Image("BreathingBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            if isDark {
                LinearGradient(
                    colors: [
                        Color(red: 0.24, green: 0.13, blue: 0.17),
                        Color(red: 0.18, green: 0.10, blue: 0.13),
                        Color(red: 0.12, green: 0.08, blue: 0.10)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
        }
    }
    
    private var videoSection: some View {
            ZStack {
                Color.gray.opacity(0.2)
                    .frame(height: 220)
                    .cornerRadius(20)
                
                Button {
                } label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.white)
                        .background(Circle().fill(.black.opacity(0.2)))
                }
            }
        }
        
        private var stepsSection: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("STEPS")
                    .font(.system(size: 18 * textScale, weight: .bold))
                    .foregroundStyle(isDark ? darkPeach : textBrown)
                    .tracking(1.0)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(steps.indices, id: \.self) { index in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1).")
                                .fontWeight(.bold)
                            
                            Text(steps[index])
                                .lineSpacing(4)
                        }
                        .font(.system(size: 16 * textScale))
                        .foregroundStyle(isDark ? .white : textBrown.opacity(0.9))
                    }
                }
            }
        }
}

#Preview {
    AppThemeManager {
        WorkoutVideoView()
    }
}
