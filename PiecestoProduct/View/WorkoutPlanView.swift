//
//  WorkoutPlanView.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 29/05/26.
//

import SwiftUI

struct WorkoutPlanView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var headerSection: some View {
        ZStack(alignment: .bottomTrailing) {
            colourPeach
            .shadow(color: colourPeach.opacity(0.3), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Spacer()
                    
                    Button {
                        //TODO!!!
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.black.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 100)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("WORKOUT")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(.white)
                    
                    Text("Mat Pilates with Julius")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                    
//                        Text("Gentle movements to help you feel stronger and lighter")
//                            .font(.system(size: 16, weight: .regular))
//                            .foregroundStyle(.white.opacity(0.9))
//                            .padding(.top, 4)
//                            .lineSpacing(4)
                }
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var colourPeach: Color {
            Color(red: 250/255, green: 154/255, blue: 138/255)
        }
        private var colourPink: Color {
            Color(red: 0.82, green: 0.43, blue: 0.52)
        }
        private var textBrown: Color {
            Color(red: 0.46, green: 0.36, blue: 0.35)
        }
    
    var body: some View {
            VStack(spacing: 150) {
                headerSection
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 10)
                    .padding(.top, 20)
                
                VStack(spacing: 24) {
                    HStack {
                        Image("WorkoutIcon")
                        VStack(alignment: .leading) {
                            Text("Mat Pilates With Jacob")
                            Text("We do it for 10 minutes")
                        }
                    }
                    
                    HStack {
                        Image("BreathingIcon")
                        VStack(alignment: .leading) {
                            Text("Mat Pilates With Jacob")
                            Text("We do it for 10 minutes")
                        }
                    }
                    
                    Button {
                    } label: {
                        Text("START")
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
                    .padding(.top, 20)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                ZStack(alignment: .topLeading){
                    Image("Background")
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
                            .ignoresSafeArea()
                    }
                }
            }
        }
}

#Preview {
    WorkoutPlanView()
}
