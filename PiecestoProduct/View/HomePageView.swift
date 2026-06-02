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
            if energyProgress < 0.2 { return .needingRest }
            else if energyProgress < 0.4 { return .takingItEasy }
            else if energyProgress < 0.6 { return .findingRhythm }
            else if energyProgress < 0.8 { return .feelingGood }
            else { return .energized }
        }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                
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
                    Image("PlanBackground")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    if isDark {
                        Color(red: 0.10, green: 0.07, blue: 0.09)
                            .ignoresSafeArea()
                    }
                }
            }
            .navigationDestination(for: String.self) { _ in
                    WorkoutPlanView()
            }
        }
    }

    private var contentArea: some View {
        ZStack{
            VStack(alignment: .center, spacing: 5) {
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
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                Image(energyState.imageName) // Placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .animation(.spring, value: energyProgress)
                
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
                        CurvedSlider(progress: $energyProgress)
                            .frame(height: 100)
                            .padding(.top, -20)
                        
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
        case .needingRest: return "Your body has been carrying a lot lately. Today may be a day for slowing down and giving yourself extra care."
        case .takingItEasy: return "You have some energy, but your body may still be asking for gentle movement and moments of rest."
        case .findingRhythm: return "You're moving through the day steadily. Listen to your body and take things at a pace that feels right."
        case .feelingGood: return "Your energy is showing up today. Enjoy what feels manageable while still making space for yourself."
        case .energized: return "Your body feels ready to move and engage today. Celebrate this moment and continue treating yourself with kindness."
        }
    }
    
    var imageName: String {
            switch self {
            case .needingRest: return "FlowerEmpty"
            case .takingItEasy: return "Flower4-5"
            case .findingRhythm: return "Flower6-7"
            case .feelingGood: return "Flower8-9"
            case .energized: return "FullFlower"
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
                    .stroke(
                        LinearGradient(
                            colors: [Color(hex: "C45E5E"), Color(hex: "F2EA76"), Color(hex: "80DF91")],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),

                        style: StrokeStyle(lineWidth: 60, lineCap: .square)
                    )
                    .frame(width: sliderWidth, height: 70)
                    .padding(.horizontal, 10)
                
                CurvedTrackPath()
                    .stroke(
                        Color.white.opacity(0.6),
                            style: StrokeStyle(lineWidth: 2, lineCap: .round)
                        )
                    .frame(width: sliderWidth, height: 70)
                    .padding(.horizontal, 10)
                
                Image("WhiteFlower")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .shadow(radius: 3)
                    .offset(x: 10 + (progress * sliderWidth) - 25)
                    .offset(y: calculateYOffset(progress: progress))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newProgress = (value.location.x - 10) / sliderWidth
                                progress = min(max(newProgress, 0), 1)
                            }
                    )
            }
        }
    }
    
    func calculateYOffset(progress: CGFloat) -> CGFloat {
        let t = progress
        

        let trueY = 180 * (t * t) - 180 * t + 70
        
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
