//
//  HomePageView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct HomePageView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var showSettings = false
    
    @State private var energyProgress: CGFloat = 0.5
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var energyState: EnergyState {
        if energyProgress < 0.25 { return .needingRest }
        else if energyProgress < 0.5 { return .takingItEasy }
        else if energyProgress < 0.75 { return .findingRhythm }
        else { return .feelingGood }
    }
    
    var body: some View {
        // 1. Wrap your entire view hierarchy in the NavigationStack
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                
                // 2. Your content area sits here as usual
                contentArea
                
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
                ZStack {
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    if isDark {
                        Color(red: 0.10, green: 0.07, blue: 0.09)
                            .ignoresSafeArea()
                    }
                }
            }
            // 3. Define your navigation destinations here at the root level
            .navigationDestination(for: String.self) { _ in
                    WorkoutPageView()
            }
        }
    }
    
    // 4. Now you can safely put NavigationLinks inside your contentArea
    private var contentArea: some View {
        ZStack{
            VStack(alignment: .center, spacing: 20) {
                HStack{
                    Text("YOUR ENERGY LEVEL")
                        .font(.system(size: 22 * textScale, weight: .bold))
                        .foregroundStyle(
                            isDark
                            ? Color(red: 1.00, green: 0.84, blue: 0.86)
                            : Color(red: 0.00, green: 0.00, blue: 0.00)
                        )
                    
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
                .padding(20)
                
                Text("Hi, Sora!")
                    .font(Font.system(size: 34 * textScale, weight: .bold))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 0.86, green: 0.72, blue: 0.74)
                        : Color(red: 0.00, green: 0.00, blue: 0.00)
                    )

                Text("Let us do the gentle check, how is your energy level?")
                    .font(.system(size: 17 * textScale))
                    .foregroundStyle(
                        isDark
                        ? Color(red: 0.86, green: 0.72, blue: 0.74)
                        : Color(red: 0.00, green: 0.00, blue: 0.00)
                    )
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                // Replace this with your actual flower image
                Image(systemName: "sun.max.fill") // Placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(Color.blue.opacity(0.3))
                    // Animation logic: Scales slightly based on energy level
                    .scaleEffect(1.0 + (energyProgress * 0.2))
                    .animation(.easeInOut, value: energyProgress)
                
                Spacer()
                
                ZStack(alignment: .top) {
                    CurvedTopRectangle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "FF8A7A"), Color(hex: "FFA896")],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .ignoresSafeArea(edges: .bottom)
                    
                    VStack(spacing: 30) {
                        // The Custom Slider
                        CurvedSlider(progress: $energyProgress)
                            .frame(height: 100)
                            .padding(.top, -20)
                        
                        // Dynamic Text matching state
                        VStack(spacing: 12) {
                            Text(energyState.title)
                                .font(.system(size: 18 * textScale, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text(energyState.description)
                                .font(.system(size: 13 * textScale))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white.opacity(0.9))
                                .padding(.horizontal, 30)
                        }
                        .animation(.easeInOut, value: energyState)
                        
                        // Hooked up NavigationLink instead of standard button
                        NavigationLink(value: "GoToWorkout") {
                            HStack {
                                Text("WORKOUT")
                                    .font(.system(size: 14 * textScale, weight: .bold))
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(Color(red: 0.29, green: 0.24, blue: 0.20))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.white)
                            .clipShape(Capsule())
                        }
                        .padding(.bottom, 40)
                    }
                }
                .frame(height: 340)
            }
        }
    }
}

// MARK: - Supporting Types & Components

enum EnergyState {
    case needingRest, takingItEasy, findingRhythm, feelingGood
    
    var title: String {
        switch self {
        case .needingRest: return "\"NEEDING REST\""
        case .takingItEasy: return "\"TAKING IT EASY\""
        case .findingRhythm: return "\"FINDING YOUR RHYTHM\""
        case .feelingGood: return "\"FEELING GOOD\""
        }
    }
    
    var description: String {
        switch self {
        case .needingRest: return "Your body has been carrying a lot lately. Today may be a day for slowing down and giving yourself extra care."
        case .takingItEasy: return "You have some energy, but your body may still be asking for gentle movement and moments of rest."
        case .findingRhythm: return "You're moving through the day steadily. Listen to your body and take things at a pace that feels right."
        case .feelingGood: return "Your energy is showing up today. Enjoy what feels manageable while still making space for yourself."
        }
    }
}

struct CurvedSlider: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let sliderWidth = width - 60
            
            ZStack(alignment: .leading) {
                CurvedTrackPath()
                    .stroke(
                        LinearGradient(
                            colors: [Color(hex: "FFF3E0"), Color(hex: "FFF9C4"), Color(hex: "C8E6C9")],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .frame(width: sliderWidth, height: 60)
                    .padding(.horizontal, 30)
                
                // Draggable knob (Flower placeholder)
                Image(systemName: "sparkles")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
                    .offset(x: 30 + (progress * sliderWidth) - 12)
                    .offset(y: calculateYOffset(progress: progress, height: 60))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newProgress = (value.location.x - 30) / sliderWidth
                                progress = min(max(newProgress, 0), 1)
                            }
                    )
            }
        }
    }
    
    func calculateYOffset(progress: CGFloat, height: CGFloat) -> CGFloat {
        let normalized = (progress * 2) - 1
        let curve = 1 - (normalized * normalized)
        return 20 - (curve * 30)
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
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}



#Preview {
    AppThemeManager {
        HomePageView()
    }
}
