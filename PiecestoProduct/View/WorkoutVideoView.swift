//
//  WorkoutVideoView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 29/05/26.
//

import SwiftUI

struct WorkoutVideoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var showSettings = false
    
    let video: WorkoutVideo
    @State private var isPresentingBreathing = false
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var buttonTopPadding: CGFloat {
        textScale > 1.15 ? 32 : 58
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
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            mainContent
            
            if showSettings {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(
                            .spring(response: 0.3, dampingFraction: 0.85)
                        ) {
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
        .fullScreenCover(isPresented: $isPresentingBreathing) {
            BreathingExerciseView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var mainContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerArea
                
                VStack(alignment: .center, spacing: 24) {
                    videoSection
                    
                    stepsSection
                    
                    NavigationLink(value: AppRoute.breathing){
                        Text("Breathing Exercise")
                            .font(
                                .system(size: 17 * textScale, weight: .semibold)
                            )
                            .foregroundStyle(.white)
                            .frame(width: 160, height: 15)
                            .padding(16)
                            .background(isDark ? darkPeach : peach)
                            .clipShape(Capsule())
                            .shadow(
                                color: (isDark ? darkPeach : peach)
                                    .opacity(0.30),
                                radius: 10,
                                y: 5
                            )
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                    .padding(.bottom, 120)
                }
            }
            .ignoresSafeArea(edges: .top)
            
            Button {
                isPresentingBreathing = true
            } label: {
                Text("Cool Down Breathing")
                    .font(.system(size: 17 * textScale, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 220, height: 15)
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
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundView
        }
    }
    private var headerArea: some View {
        ZStack(alignment: .topTrailing) {
            Header(
                content: HeaderContent(
                    title: "WORKOUT",
                    subtitle: video.title,
                    description: "Guided by \(video.instructor)"
                ),
                flowerOffset: CGSize(width: 80, height: 113)
            )
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(Color(red: 0.63, green: 0.58, blue: 0.73))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.12), radius: 6, y: 3)
                }
                .buttonStyle(.plain)
                
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
            .padding(.top, buttonTopPadding)
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
            WorkoutVideoPlayer(videoID: video.youtubeId)
        }
    }
    
    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("WHAT TO EXPECT")
                .font(.system(size: 18 * textScale, weight: .bold))
                .foregroundStyle(isDark ? darkPeach : textBrown)
                .tracking(1.0)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(video.steps.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1).")
                            .fontWeight(.bold)
                        
                        Text(video.steps[index])
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
        WorkoutVideoView(video: WorkoutData.videos[0])
    }
}
