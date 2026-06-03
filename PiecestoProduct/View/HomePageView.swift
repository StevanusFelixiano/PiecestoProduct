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
    
    @State private var showSettings = false
    
    @State private var energyProgress: CGFloat = 0.5
    
    @State private var showWorkoutPlan = false
    
    var onWorkoutTap: () -> Void = {}
    var onBackTap: () -> Void = {}
    
    //    @Binding var
    
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
        .fullScreenCover(isPresented: $showWorkoutPlan) {
            WorkoutPlanView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            ZStack {
                Image("OnboardBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                if isDark {
                    Color(red: 0.10, green: 0.07, blue: 0.09)
                        .ignoresSafeArea()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var contentArea: some View {
        ZStack{
            VStack(alignment: .center, spacing: -3) {
                HStack{
                    Text("YOUR ENERGY LEVEL")
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
                            .foregroundStyle(.black)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .opacity(showSettings ? 0 : 1)
                    .allowsHitTesting(!showSettings)
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 20)
                    
                Text("Hi, Sora!")
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
                    
                Text(
                    "Let us do the gentle check,\n how is your energy level?"
                )
                .font(.system(size: 17 * textScale))
                .foregroundStyle(
                    isDark
                    ? Color(red: 0.86, green: 0.72, blue: 0.74)
                    : Color(hex: "5B4428")
                )
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding (.bottom, 10)
                .fixedSize(horizontal: false, vertical: true)
                    
                Spacer()
                    
                Image(energyState.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .animation(.smooth, value: energyProgress)
                    .offset(x: energyState.imageOffset)
                    
                Spacer()
                    .padding(.bottom, 30)
                    
                ZStack(alignment: .top) {
                    CurvedTopRectangle()
                        .fill(
                            isDark ? Color(hex: "FF8A7A") : Color(
                                hex: "FA9A8A"
                            )
                        )
                        .ignoresSafeArea(edges: .bottom)
                        .ignoresSafeArea(edges: .bottom)
                        
                    VStack(spacing: 30) {
                        CurvedSlider(progress: $energyProgress)
                            .frame(height: 100)
                            .padding(.top, -20)
                            
                        VStack(spacing: 12) {
                            Text(energyState.title)
                                .font(
                                    .system(
                                        size: 18 * textScale,
                                        weight: .bold
                                    )
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
                            
                        Button {
                            onWorkoutTap()
                        } label: {
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
                            .background(Color.white)
                            .clipShape(Capsule())
                        }
                        .padding(.bottom, 20)
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
        .padding(.top, 60)
    }
    
    // MARK: - Safe Area Preference Tracker Hook
    struct TopInsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

// MARK: - Supporting Types & Components

enum EnergyState {
    case needingRest, takingItEasy, findingRhythm, feelingGood, energized
    
    var title: String {
        switch self {
        case .needingRest: return "\"NEEDING REST\""
        case .takingItEasy: return "\"TAKING IT EASY\""
        case .findingRhythm: return "\"FINDING YOUR RHYTHM\""
        case .feelingGood: return "\"FEELING GOOD\""
        case .energized: return "\"ENERGIZED\""
        }
    }
    
    var description: String {
        switch self {
        case .needingRest: return "Your body has been carrying a lot lately. \nToday may be a day for slowing down and giving yourself extra care."
        case .takingItEasy: return "You have some energy, but your body may still be asking for gentle movement and moments of rest."
        case .findingRhythm: return "You're moving through the day steadily. \nListen to your body and take things at a pace that feels right."
        case .feelingGood: return "Your energy is showing up today. \nEnjoy what feels manageable while still making space for yourself."
        case .energized: return "Your body feels ready to move and engage today. \nCelebrate this moment and continue treating yourself with kindness."
        }
    }
    
    var imageName: String {
        switch self {
        case .needingRest: return "FlowerEmpty"
        case .takingItEasy: return "Flower2Petals"
        case .findingRhythm: return "Flower4Petals"
        case .feelingGood: return "Flower6Petals"
        case .energized: return "FullFlower"
        }
    }
    
    var imageOffset: CGFloat {
        switch self {
        case .needingRest: return -4 // Moves it 5 pixels to the left
        case .takingItEasy: return 0
        case .findingRhythm: return 0
        case .feelingGood: return 0
        case .energized: return 0
        }
    }
}

struct CurvedSlider: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let sliderWidth = width - 20
            
            ZStack(alignment: .leading) {
                CurvedTrackPath()
                    .stroke(Color(hex: "FA9A8A")
                    )
                
                CurvedTrackPath()
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(hex: "C45E5E"),
                                Color(hex: "F2EA76"),
                                Color(hex: "80DF91")
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),

                        style: StrokeStyle(lineWidth: 90, lineCap: .square)
                    )
                    .frame(width: sliderWidth, height: 60)
                    .padding(.horizontal, 10)
                
                CurvedTrackPath()
                    .stroke(
                        Color.white.opacity(0.6),
                        style: StrokeStyle(lineWidth: 2, lineCap: .round)
                    )
                    .frame(width: sliderWidth, height: 60)
                    .padding(.horizontal, 10)
                
                CurvedTrackPath()
                    .stroke(
                        Color(hex: "FA9A8A"),
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: width, height: 60)
                    .offset(y: -45)
                    
                CurvedTrackPath()
                    .stroke(
                        Color(hex: "F8F0E4"),
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

enum AppRoute: Hashable {
    case home
    case plan
    case video
    case breathing
    case finish
}



#Preview {
    AppThemeManager {
        HomePageView()
    }
}
