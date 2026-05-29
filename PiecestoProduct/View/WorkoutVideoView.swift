//
//  WorkoutVideoView.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 29/05/26.
//

import SwiftUI

struct WorkoutVideoView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var colourPeach: Color {
        Color(red: 250/255, green: 154/255, blue: 138/255)
    }
    private var colourPink: Color {
        Color(red: 0.82, green: 0.43, blue: 0.52)
    }
    private var textBrown: Color {
        Color(red: 0.46, green: 0.36, blue: 0.35)
    }
    
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 0) {
                
                // Header to be reused
                headerSection
                
                VStack(alignment: .leading, spacing: 24) {
                    //Video z stack
                    ZStack {
                        // TODO: placeholder!!!!
                        Color.gray.opacity(0.2)
                            .frame(height: 220)
                            .cornerRadius(20)
                        
                        // Play Button
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
                    //                                            Text("Gentle movements to help you feel stronger and lighter")
                    //                                                .font(.system(size: 16, weight: .regular))
                    //                                                .foregroundStyle(colorScheme == .dark ? colourPink : textBrown)
                    //                                                .padding(.top, 4)
                    //                                                .lineSpacing(4)
                    
                    //Steps v stack
                    VStack(alignment: .leading, spacing: 16) {
                        Text("STEPS")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(colorScheme == .dark ? colourPink : textBrown)
                            .tracking(1.0) //make text more clear
                        
                        //list easier to work with backend
                        let steps = [
                            "Sit comfortably on your mat",
                            "Start with gentle neck and shoulder stretches",
                            "Slowly roll your shoulders and loosen your back",
                            "Follow light core and leg movements",
                            "Focus on breathing and moving at your own pace",
                            "Finish with a full body stretch and short rest"
                        ]
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(steps.indices, id: \.self) { index in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                    
                                    Text(steps[index])
                                        .lineSpacing(4)
                                }
                                .font(.system(size: 16))
                                .foregroundStyle(colorScheme == .dark ? .white : textBrown.opacity(0.9))
                            }
                        }
                    }
                    
                    Button {
                        // TODO: Add Functionality
                    } label: {
                        Text("Breathing Exercise")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(colorScheme == .dark ? colourPink : colourPeach)
                            .clipShape(Capsule())
                            .shadow(color: colourPeach.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea(edges: .top) // Allows header to bleed to the top edge
        .background {
            // Subtle background gradient matching the app's theme
            LinearGradient(
                colors: [colourPeach.opacity(0.1), colourPeach.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
    private var headerSection: some View {
        ZStack(alignment: .bottomTrailing) {
            colourPeach
                .shadow(color: colourPeach.opacity(0.3), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button {
                        //TODO: back button!!!
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.black.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button {
                        //TODO: menu button!!!
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.black.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 60)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("WORKOUT")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(colorScheme == .light ? .white : textBrown.opacity(0.9))
                    
                    Text("Mat Pilates with Julius")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(colorScheme == .light ? .white : textBrown.opacity(0.9))
                    
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
}

#Preview {
    WorkoutVideoView()
}
