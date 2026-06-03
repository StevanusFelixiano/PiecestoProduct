//
//  WorkoutPlanView.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 29/05/26.
//

import SwiftUI

struct WorkoutPlanView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var showSettings = false
    
    var onBackTap: () -> Void = {}
    
    private let workoutItems = [
        WorkoutPlanItem(
            iconName: "WorkoutIcon",
            title: "Mat Pilates with Julius",
            subtitle: "We do it for 10 minutes"
        ),
        WorkoutPlanItem(
            iconName: "BreathingIcon",
            title: "Breathing Exercise",
            subtitle: "We do it for 5 minutes"
        )
    ]
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var peach: Color {
        Color(red: 250/255, green: 154/255, blue: 138/255)
    }
    
    private var darkPeach: Color {
        Color(red: 0.82, green: 0.43, blue: 0.52)
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
    }

    
    private var mainContent: some View {
        VStack(spacing: 0) {
            headerArea
            
            VStack(spacing: 34) {
                VStack(spacing: 32) {
                    ForEach(workoutItems) { item in
                        WorkoutPlanRow(
                            item: item,
                            textScale: textScale,
                            isDark: isDark
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                NavigationLink(value: AppRoute.video) {
                    Text("START")
                        .font(.system(size: 17 * textScale, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 170, height: 54)
                        .background(isDark ? darkPeach : peach)
                        .clipShape(Capsule())
                        .shadow(
                            color: (isDark ? darkPeach : peach).opacity(0.30),
                            radius: 10,
                            y: 5
                        )
                }
                .padding(.top, 24)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundView
        }
    }
    
    private var headerArea: some View {
        ZStack(alignment: .topTrailing){
            Header(
                content: HeaderContent(
                    title: "WORKOUT PLAN",
                    subtitle: "",
                    description: "We got u mama, leave it to us!"
                )
            )
            .onTapGesture {
                onBackTap()
            }
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
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .buttonStyle(.plain)
            .opacity(showSettings ? 0 : 1)
            .allowsHitTesting(!showSettings)
        }
    }
    
    private var backgroundView: some View {
        ZStack(alignment: .topLeading) {
            Image("PlanBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("BotLeftFlower")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomTrailing
                )
                .offset(x: -208, y: 7)
                .opacity(1.1)
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
}

struct WorkoutPlanRow: View {
    let item: WorkoutPlanItem
    let textScale: Double
    let isDark: Bool
    
    private var textBrown: Color {
        Color(red: 0.36, green: 0.27, blue: 0.24)
    }
    
    private var subtitleBrown: Color {
        Color(red: 0.46, green: 0.36, blue: 0.35)
    }
    
    var body: some View {
        HStack(spacing: 22) {
            Image(item.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.system(size: 20 * textScale, weight: .bold))
                    .foregroundStyle(
                        isDark
                        ? Color.white.opacity(0.92)
                        : textBrown
                    )
                    .frame(maxWidth: 300, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(item.subtitle)
                    .font(.system(size: 15 * textScale, weight: .regular))
                    .foregroundStyle(
                        isDark
                        ? Color.white.opacity(0.78)
                        : subtitleBrown
                    )
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AppThemeManager {
        WorkoutPlanView()
    }
}
