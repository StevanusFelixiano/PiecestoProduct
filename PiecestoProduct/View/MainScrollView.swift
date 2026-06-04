//
//  MainScrollView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 03/06/26.
//

import SwiftUI

struct MainScrollView: View {
    @State private var path = NavigationPath()
    @State private var isScrollDisabled = true
    @State private var selectedEnergy: EnergyState = .findingRhythm
    @State private var workoutPlanRefreshID = UUID()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        HomePageView(
                            topPadding: 44,
                            onWorkoutTap: { incomingEnergy in
                                print("MainScrollView received energy state: \(incomingEnergy.title)")
                                
                                selectedEnergy = incomingEnergy
                                workoutPlanRefreshID = UUID()
                                isScrollDisabled = false
                                
                                withAnimation(
                                    .spring(
                                        response: 0.6,
                                        dampingFraction: 0.85
                                    )
                                ) {
                                    proxy.scrollTo(
                                        "workout_plan_section",
                                        anchor: .top
                                    )
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    isScrollDisabled = true
                                }
                            }
                        )
                        .id("homepage_section")
                        .containerRelativeFrame(.vertical, alignment: .center)
                        
                        ZStack {
                            WorkoutPlanView(
                                onBackTap: {
                                    isScrollDisabled = false
                                    
                                    withAnimation(
                                        .spring(
                                            response: 0.6,
                                            dampingFraction: 0.85
                                        )
                                    ) {
                                        proxy.scrollTo(
                                            "homepage_section",
                                            anchor: .top
                                        )
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        isScrollDisabled = true
                                    }
                                },
                                energyState: $selectedEnergy
                            )
                            .id(workoutPlanRefreshID)
                        }
                        .id("workout_plan_section")
                        .containerRelativeFrame(.vertical, alignment: .center)
                    }
                }
                .contentMargins(0, for: .scrollContent)
                .scrollDisabled(isScrollDisabled)
                .ignoresSafeArea()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .video(let selectedVideo):
                        WorkoutVideoView(video: selectedVideo)
                        
                    case .breathing:
                        BreathingExerciseView()
                        
                    case .finish:
                        PostExerciseView {
                            isScrollDisabled = false
                            
                            var transaction = Transaction()
                            transaction.animation = nil
                            
                            withTransaction(transaction) {
                                proxy.scrollTo(
                                    "homepage_section",
                                    anchor: .top
                                )
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                path.removeLast(path.count)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isScrollDisabled = true
                                }
                            }
                        }
                        
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    AppThemeManager {
        MainScrollView()
    }
}
