//
//  AnimatedHelloIllustration.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct AnimatedHelloIllustration: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var waveHand = false
    @State private var floatAvatar = false
    @State private var floatFlowerLeft = false
    @State private var floatFlowerRight = false
    @State private var showHiBubble = false
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    var body: some View {
        ZStack {
            // Soft glow for dark mode, soft blob for light mode
            if isDark {
                Circle()
                    .fill(Color(red: 0.95, green: 0.42, blue: 0.58).opacity(0.16))
                    .frame(width: 210, height: 210)
                    .blur(radius: 24)
                
                Circle()
                    .fill(Color(red: 0.55, green: 0.38, blue: 0.95).opacity(0.12))
                    .frame(width: 180, height: 180)
                    .blur(radius: 22)
                    .offset(x: 24, y: -10)
            } else {
                RoundedRectangle(cornerRadius: 80)
                    .fill(Color(red: 0.98, green: 0.88, blue: 0.84).opacity(0.65))
                    .frame(width: 190, height: 190)
                    .rotationEffect(.degrees(-12))
                    .offset(y: 8)
                
                RoundedRectangle(cornerRadius: 70)
                    .fill(Color(red: 0.93, green: 0.88, blue: 1.0).opacity(0.45))
                    .frame(width: 165, height: 165)
                    .rotationEffect(.degrees(18))
                    .offset(x: 10, y: -4)
            }
            
            FlowerView(
                size: 40,
                petalColor: isDark
                ? Color(red: 1.0, green: 0.36, blue: 0.52).opacity(0.95)
                : Color.pink.opacity(0.75)
            )
            .offset(x: -78, y: -58)
            .offset(y: floatFlowerLeft ? -7 : 7)
            .rotationEffect(.degrees(floatFlowerLeft ? -7 : 7))
            
            FlowerView(
                size: 32,
                petalColor: isDark
                ? Color(red: 0.82, green: 0.48, blue: 1.0).opacity(0.95)
                : Color.purple.opacity(0.6)
            )
            .offset(x: 82, y: 42)
            .offset(y: floatFlowerRight ? 7 : -7)
            .rotationEffect(.degrees(floatFlowerRight ? 8 : -8))
            
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(
                            isDark
                            ? Color(red: 0.98, green: 0.80, blue: 0.86)
                            : Color.white
                        )
                        .frame(width: 126, height: 126)
                        .shadow(
                            color: isDark
                            ? Color(red: 1.0, green: 0.40, blue: 0.58).opacity(0.28)
                            : .black.opacity(0.08),
                            radius: isDark ? 22 : 12,
                            y: 8
                        )
                    
                    Circle()
                        .fill(
                            isDark
                            ? Color(red: 1.0, green: 0.67, blue: 0.77)
                            : Color(red: 0.99, green: 0.92, blue: 0.95)
                        )
                        .frame(width: 104, height: 104)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 66))
                        .foregroundStyle(
                            isDark
                            ? Color(red: 0.45, green: 0.25, blue: 0.31)
                            : Color(red: 0.74, green: 0.47, blue: 0.52)
                        )
                    
                    Image(systemName: "hand.wave.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(
                            isDark
                            ? Color(red: 1.0, green: 0.58, blue: 0.23)
                            : Color.orange.opacity(0.95)
                        )
                        .offset(x: 40, y: -4)
                        .rotationEffect(.degrees(waveHand ? 18 : -12), anchor: .bottomLeading)
                }
                .offset(y: floatAvatar ? -7 : 7)
                
                Text("Hi, Mama")
                    .font(.headline)
                    .foregroundStyle(
                        isDark
                        ? Color(red: 1.0, green: 0.72, blue: 0.80)
                        : Color(red: 0.55, green: 0.37, blue: 0.40)
                    )
            }
            
            Text("Hi!")
                .font(.subheadline.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(
                            isDark
                            ? Color(red: 0.92, green: 0.38, blue: 0.56)
                            : Color(red: 0.86, green: 0.54, blue: 0.61)
                        )
                )
                .offset(x: 62, y: -72)
                .scaleEffect(showHiBubble ? 1 : 0.85)
                .opacity(showHiBubble ? 1 : 0.65)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.45).repeatForever(autoreverses: true)) {
                waveHand = true
            }
            
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                floatAvatar = true
            }
            
            withAnimation(.easeInOut(duration: 2.1).repeatForever(autoreverses: true)) {
                floatFlowerLeft = true
            }
            
            withAnimation(.easeInOut(duration: 1.7).repeatForever(autoreverses: true)) {
                floatFlowerRight = true
            }
            
            withAnimation(.spring(duration: 1.2).repeatForever(autoreverses: true)) {
                showHiBubble = true
            }
        }
    }
}

struct FlowerView: View {
    let size: CGFloat
    let petalColor: Color
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { index in
                Circle()
                    .fill(petalColor)
                    .frame(width: size * 0.34, height: size * 0.34)
                    .offset(y: -size * 0.28)
                    .rotationEffect(.degrees(Double(index) * 60))
            }
            
            Circle()
                .fill(Color.yellow.opacity(0.95))
                .frame(width: size * 0.24, height: size * 0.24)
        }
    }
}

#Preview {
    AppThemeManager {
        AnimatedHelloIllustration()
            .frame(width: 260, height: 260)
    }
}
