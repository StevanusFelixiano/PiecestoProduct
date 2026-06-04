//
//  HomePageView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct HomePageView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage(
        "hasCompletedInitialSetup"
    ) private var hasCompletedInitialSetup = false
    @AppStorage("textScale") private var textScale = 1.0
    @AppStorage("userName") private var userName = ""
    
    @State private var showSettings = false
    
    @State private var energyProgress: CGFloat = 0.5
    var topPadding: CGFloat = 0
    var onWorkoutTap: (EnergyState) -> Void = {_ in}
    var onBackTap: () -> Void = {}
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var energyState: EnergyState {
        if energyProgress < 0.2 { return .needingRest }
        else if energyProgress < 0.4 { return .takingItEasy }
        else if energyProgress < 0.6 { return .findingRhythm }
        else if energyProgress < 0.8 { return .feelingGood }
        else { return .energized }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            contentArea
            
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
            ZStack {
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                if isDark {
                    Color(red: 0.10, green: 0.07, blue: 0.09)
                        .ignoresSafeArea()
                }
            }
        }
    }
    
    private var contentArea: some View {
        ZStack{
            VStack(alignment: .center, spacing: -3) {
                HStack{
                    Text("YOUR ENERGY TODAY")
                        .font(.system(size: 20 * textScale, weight: .bold))
                        .foregroundStyle(
                            isDark
                            ? Color(red: 1.00, green: 0.84, blue: 0.86)
                            : Color(hex: "5B4428")
                        )
                    
                    Spacer()
                    Button {
                        withAnimation(
                            .spring(response: 0.3, dampingFraction: 0.85)
                        ) {
                            showSettings = true
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(Color(red: 0.63, green: 0.58, blue: 0.73))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.12), radius: 6, y: 3)
                    }
                    .buttonStyle(.plain)
                    .opacity(showSettings ? 0 : 1)
                    .allowsHitTesting(!showSettings)
                }
                .padding(20)
                
                Text("Hi, \(userName.isEmpty ? "Mama" : userName)!")
                    .font(
                        Font
                            .system(
                                size: 34 * textScale,
                                weight: .bold,
                                design: .rounded
                            )
                    )
                    .foregroundStyle(
                        isDark
                        ? Color(red: 0.86, green: 0.72, blue: 0.74)
                        : Color(hex: "5B4428")
                    )
                    .padding(.bottom, 10)
                
                Text("Let's do a quick check-in.\n How is your energy right now?")
                    .font(.system(size: 17 * textScale))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 0.86, green: 0.72, blue: 0.74)
                        : Color(hex: "5B4428")
                    )
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)
                
                
                Spacer()
                
                Image(energyState.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .animation(.spring, value: energyProgress)
                    .offset(x: energyState.imageOffset)
                
                Spacer()
                    .padding(.bottom, 20)
                
                ZStack(alignment: .top) {
                    
                    
                    CurvedTopRectangle()
                        .fill(
                            isDark
                            ? LinearGradient(
                                colors: [
                                    Color(red: 0.34, green: 0.18, blue: 0.24),
                                    Color(red: 0.24, green: 0.13, blue: 0.18)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            : LinearGradient(
                                colors: [
                                    Color(hex: "FA9A8A"),
                                    Color(hex: "FA9A8A")
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .ignoresSafeArea(edges: .bottom)
                    
                    VStack(spacing: 30) {
                        CurvedSlider(progress: $energyProgress, isDark: isDark)
                            .frame(height: 100)
                            .padding(.top, -20)
                        
                        VStack(spacing: 12) {
                            Text(energyState.title)
                                .font(
                                    .system(size: 18 * textScale, weight: .bold)
                                )
                                .tracking(1.5)
                                .foregroundStyle(.white)
                            
                            Text(energyState.description)
                                .font(.system(size: 14 * textScale))
                                .frame(maxWidth: 320)
                                .lineSpacing(3)
                                .multilineTextAlignment(.center)
                                .tracking(0)
                                .foregroundStyle(.white.opacity(0.9))
                                .padding(.horizontal, 30)
                        }
                        .animation(.easeInOut, value: energyState)
                        
                        Button{
                            print(
                                "HomePageView is passing local state: \(energyState.title)"
                            )
                            onWorkoutTap(energyState)
                        } label:{
                            HStack {
                                Text("WORKOUT")
                                    .font(
                                        .system(
                                            size: 14 * textScale,
                                            weight: .bold
                                        )
                                    )
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(
                                Color(red: 0.29, green: 0.24, blue: 0.20)
                            )
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(
                                isDark
                                ? Color.white.opacity(0.9)
                                : Color.white.opacity(0.4)
                            )
                            .clipShape(Capsule())
                        }

                        .padding(.bottom, 10)
                    }
                }
                .frame(height: 300)
            }
        }
        .background {
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: TopInsetPreferenceKey.self,
                        value: geometry.safeAreaInsets.top
                    )
            }
        }
        .padding(.top, topPadding)
    }
    
    // MARK: - Safe Area Preference Tracker Hook
    struct TopInsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

struct CurvedSlider: View {
    @Binding var progress: CGFloat
    let isDark: Bool
    
    private var baseTrackColor: Color {
        isDark
        ? Color(red: 0.34, green: 0.18, blue: 0.24)
        : Color(hex: "FA9A8A")
    }
    
    private var bottomLineColor: Color {
        isDark
        ? Color.white.opacity(0.28)
        : Color(hex: "F8F0E4")
    }
    
    private var topLineColor: Color {
        isDark
        ? Color(red: 0.48, green: 0.27, blue: 0.34)
        : Color(hex: "FA9A8A")
    }
    
    private var sliderGradient: LinearGradient {
        LinearGradient(
            colors: isDark
            ? [
                Color(red: 0.62, green: 0.27, blue: 0.35),
                Color(red: 0.74, green: 0.48, blue: 0.30),
                Color(red: 0.42, green: 0.62, blue: 0.48)
            ]
            : [
                Color(hex: "C45E5E"),
                Color(hex: "F2EA76"),
                Color(hex: "80DF91")
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let sliderWidth = width - 20
            
            ZStack(alignment: .leading) {
                CurvedTrackPath()
                    .stroke(baseTrackColor)
                
                CurvedTrackPath()
                    .stroke(
                        sliderGradient,
                        style: StrokeStyle(lineWidth: 90, lineCap: .square)
                    )
                    .frame(width: sliderWidth, height: 60)
                    .padding(.horizontal, 10)
                
                CurvedTrackPath()
                    .stroke(
                        Color.white.opacity(isDark ? 0.28 : 0.6),
                        style: StrokeStyle(lineWidth: 2, lineCap: .round)
                    )
                    .frame(width: sliderWidth, height: 60)
                    .padding(.horizontal, 10)
                
                CurvedTrackPath()
                    .stroke(
                        topLineColor,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: width, height: 60)
                    .offset(y: -45)
                
                CurvedTrackPath()
                    .stroke(
                        bottomLineColor,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: width, height: 70)
                    .offset(y: 45)
                
                Image("WhiteFlower")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
                    .shadow(radius: 3)
                    .offset(x: (progress * sliderWidth) - 23)
                    .offset(y: 5 + calculateYOffset(progress: progress))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newProgress = (
                                    value.location.x - 10
                                ) / sliderWidth
                                progress = min(max(newProgress, 0.05), 0.95)
                            }
                    )
            }
        }
    }
    
    func calculateYOffset(progress: CGFloat) -> CGFloat {
        let t = progress
        let trueY = 160 * (t * t) - 160 * t + 60
        return trueY - 35
    }
}

struct CurvedTrackPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.maxY),
            control: CGPoint(x: rect.midX, y: rect.minY - 20)
        )
        return path
    }
}

struct CurvedTopRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 50))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: 50),
            control: CGPoint(x: rect.midX, y: -20)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted
        )
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (
            255,
            (int >> 8) * 17,
            (int >> 4 & 0xF) * 17,
            (int & 0xF) * 17
        )
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (
            int >> 24,
            int >> 16 & 0xFF,
            int >> 8 & 0xFF,
            int & 0xFF
        )
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



#Preview {
    AppThemeManager {
        HomePageView()
    }
}
