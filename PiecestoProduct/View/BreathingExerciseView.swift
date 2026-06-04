//
//  BreathingExerciseView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 29/05/26.
//

import SwiftUI
import AVFoundation

struct BreathingExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isBreathing = false
    @State private var isRunning = false
    @State private var showSettings = false
    @State private var remainingSeconds = 180
    @State private var timer: Timer?
    @State private var breathingTimer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isShowingPostExercise = false
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var formattedTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
                    .padding(.top, 36)
                    .transition(
                        .scale(scale: 0.92, anchor: .topTrailing)
                        .combined(with: .opacity)
                    )
                    .zIndex(30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDisappear {
            timer?.invalidate()
            timer = nil
            breathingTimer?.invalidate()
            breathingTimer = nil
        }
        .fullScreenCover(isPresented: $isShowingPostExercise) {
            PostExerciseView()
        }
    }
    
    private func playBreathSound(isIn: Bool) {
        let soundName = isIn ? "breath-in" : "breath-out"
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        audioPlayer?.stop()
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
    
    private var breathingLabel: String {
        guard isRunning else { return "One breath at a time..." }
        return isBreathing ? "Breathe In..." : "Breathe Out..."
    }
    
    private var mainContent: some View {
        ZStack {
            backgroundLayer
            
            VStack {
                topBar
                
                Text("A MOMENT TO BREATHE")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(
                        isDark
                        ? Color.white.opacity(0.92)
                        : Color(red: 0.32, green: 0.25, blue: 0.20)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 28)
                    .padding(.top, 16)
                
                Spacer()
                
                breathingCircle
                
                Button {
                    toggleTimer()
                } label: {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(
                            isDark
                            ? Color(red: 0.92, green: 0.42, blue: 0.56)
                            : Color(red: 0.36, green: 0.28, blue: 0.20)
                        )
                        .frame(width: 108, height: 108)
                        .background(
                            isDark
                            ? Color.white.opacity(0.90)
                            : Color.white.opacity(0.78)
                        )
                        .clipShape(Circle())
                        .shadow(
                            color: isDark
                            ? Color(red: 0.92, green: 0.42, blue: 0.56).opacity(0.28)
                            : .black.opacity(0.08),
                            radius: 12,
                            y: 6
                        )
                }
                .padding(.top, 36)
                
                Text(breathingLabel)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundStyle(
                        isDark
                        ? Color.white.opacity(0.78)
                        : Color(red: 0.32, green: 0.25, blue: 0.20)
                    )
                    .animation(.easeInOut(duration: 0.4), value: breathingLabel)
                    .padding(.top, 22)
                
                Button {
                    timer?.invalidate()
                    timer = nil
                    breathingTimer?.invalidate()
                    breathingTimer = nil
                    isRunning = false
                    isBreathing = false
                    
                    isShowingPostExercise = true
                } label: {
                    Text("FINISH")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 52)
                        .background(
                            isDark
                            ? Color(red: 0.82, green: 0.43, blue: 0.52)
                            : Color(red: 250/255, green: 154/255, blue: 138/255)
                        )
                        .clipShape(Capsule())
                        .shadow(
                            color: isDark
                            ? Color(red: 0.82, green: 0.43, blue: 0.52).opacity(0.30)
                            : Color(red: 250/255, green: 154/255, blue: 138/255).opacity(0.30),
                            radius: 10,
                            y: 5
                        )
                }
                .padding(.top, 52)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var backgroundLayer: some View {
        GeometryReader { geometry in
            ZStack {
                if isDark {
                    LinearGradient(
                        colors: [
                            Color(red: 0.12, green: 0.08, blue: 0.11),
                            Color(red: 0.20, green: 0.13, blue: 0.17),
                            Color(red: 0.10, green: 0.08, blue: 0.12)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    Circle()
                        .fill(Color(red: 0.85, green: 0.35, blue: 0.52).opacity(0.16))
                        .frame(width: 320, height: 320)
                        .blur(radius: 60)
                        .position(
                            x: geometry.size.width * 0.18,
                            y: geometry.size.height * 0.12
                        )
                    
                    Circle()
                        .fill(Color(red: 0.45, green: 0.72, blue: 0.88).opacity(0.12))
                        .frame(width: 280, height: 280)
                        .blur(radius: 55)
                        .position(
                            x: geometry.size.width * 0.82,
                            y: geometry.size.height * 0.70
                        )
                } else {
                    Image("BreathingBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
    
    private var topBar: some View {
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
            .padding(.horizontal, 28)
            
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
            .padding(.horizontal, 16)
        }
        .padding(.top, 10)
    }
    
    struct Droplet: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            let width = rect.width
            let height = rect.height
            let midX = rect.midX
            
            path.move(to: CGPoint(x: midX, y: 0))
            
            path.addCurve(
                to: CGPoint(x: midX, y: height),
                control1: CGPoint(x: -width * 0.2, y: height * 0.3),
                control2: CGPoint(x: midX - width * 0.5, y: height)
            )
            
            path.addCurve(
                to: CGPoint(x: midX, y: 0),
                control1: CGPoint(x: midX + width * 0.5, y: height),
                control2: CGPoint(x: width * 1.2, y: height * 0.3)
            )
            
            path.closeSubpath()
            return path
        }
    }
    
    private var breathingCircle: some View {
        ZStack {
            Circle()
                .fill(
                    isDark
                    ? Color.white.opacity(0.16)
                    : Color.white.opacity(0.36)
                )
                .frame(width: 210, height: 210)
                .blur(radius: 10)
                .scaleEffect(isBreathing ? 0.5 : 1.5)
                .opacity(isRunning ? 0.3 : 0.5)
                .animation(
                    isRunning
                    ? .easeInOut(duration: 2.8).repeatForever(autoreverses: true)
                    : .easeInOut(duration: 0.3),
                    value: isBreathing
                )
            
            ForEach(0..<24, id: \.self) { index in
                Droplet()
                    .fill(
                        LinearGradient(
                            colors: isDark
                            ? [
                                Color(red: 0.92, green: 0.42, blue: 0.56).opacity(0.85),
                                Color(red: 0.55, green: 0.80, blue: 0.88).opacity(0.70)
                            ]
                            : [
                                Color(red: 0.42, green: 0.82, blue: 0.90).opacity(0.75),
                                Color(red: 0.88, green: 0.92, blue: 0.68).opacity(0.55)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 25, height: 50)
                    .offset(y: -120)
                    .rotationEffect(.degrees(Double(index) * 360 / 24))
            }
            .scaleEffect(isBreathing ? 0.3 : 0.8)
            .opacity(isRunning ? 0.8 : 1)
            .animation(
                isRunning
                ? .easeInOut(duration: 2.8).repeatForever(autoreverses: true)
                : .easeInOut(duration: 0.3),
                value: isBreathing
            )
            
            Circle()
                .fill(
                    isDark
                    ? Color.white.opacity(0.16)
                    : Color.white.opacity(0.36)
                )
                .frame(width: 100, height: 210)
                .blur(radius: 10)
                .scaleEffect(isBreathing ? 0.5 : 1.5)
                .opacity(isRunning ? 0.3 : 1)
                .animation(
                    isRunning
                    ? .easeInOut(duration: 2.8).repeatForever(autoreverses: true)
                    : .easeInOut(duration: 0.3),
                    value: isBreathing
                )
            
            Text(formattedTime)
                .font(.system(size: 46, weight: .semibold, design: .rounded))
                .foregroundStyle(
                    isDark
                    ? Color.white.opacity(0.92)
                    : Color(red: 0.32, green: 0.25, blue: 0.20)
                )
        }
        .frame(width: 270, height: 270)
    }
    
    private func toggleTimer() {
        if isRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        isBreathing = true
        playBreathSound(isIn: true)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { currentTimer in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                currentTimer.invalidate()
                timer = nil
                isRunning = false
                isBreathing = false
            }
        }
        
        breathingTimer?.invalidate()
        breathingTimer = Timer.scheduledTimer(withTimeInterval: 2.8, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 2.8)) {
                isBreathing.toggle()
            }
            playBreathSound(isIn: isBreathing)
        }
    }
    
    private func pauseTimer() {
        isRunning = false
        isBreathing = false
        timer?.invalidate()
        timer = nil
        breathingTimer?.invalidate()
        breathingTimer = nil
    }
}

struct CircleIconButton: View {
    let systemName: String
    let size: CGFloat
    
    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 52, height: 52)
            .background(.gray.opacity(0.8))
            .clipShape(Circle())
            .shadow(radius: 8)
    }
}

#Preview {
    AppThemeManager {
        BreathingExerciseView()
    }
}
