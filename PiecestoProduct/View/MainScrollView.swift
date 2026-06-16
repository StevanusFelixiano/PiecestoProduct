//
//  MainScrollView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 03/06/26.
//

import SwiftUI

struct MainScrollView: View {
    @State private var path = NavigationPath()
    @State private var selectedEnergy: EnergyState = .findingRhythm
    @State private var workoutPlanRefreshID = UUID()
    @State private var currentSection: String?
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        HomePageView(
                            topPadding: 44,
                            topBarPadding: 22,
                            settingsPopoverTopPadding: 60,
                            curvedSectionYOffset: -8,
                            menuButtonYPosition: 81,
                            colorPadding: 42,
                            onWorkoutTap: { incomingEnergy in
                                selectedEnergy = incomingEnergy
                                workoutPlanRefreshID = UUID()
                                
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
                            },
                            onEnergyChange: { newEnergy in
                                selectedEnergy = newEnergy
                            }
                        )
                        .id("homepage_section")
                        .containerRelativeFrame(.vertical, alignment: .center)
                        
                        ZStack {
                            WorkoutPlanView(
                                onBackTap: {
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
                                },
                                energyState: $selectedEnergy
                            )
                            .id(workoutPlanRefreshID)
                        }
                        .id("workout_plan_section")
                        .containerRelativeFrame(.vertical, alignment: .center)
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(0, for: .scrollContent)
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $currentSection)
                .onChange(of: currentSection) { oldValue, newValue in
                    if newValue == "workout_plan_section",
                       oldValue != "workout_plan_section" {
                        workoutPlanRefreshID = UUID()
                    }
                }
                .ignoresSafeArea()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .video(let selectedVideo):
                        WorkoutVideoView(video: selectedVideo)
                        
                    case .breathing:
                        BreathingExerciseView {
                                path.append(AppRoute.finish)
                            }
                        
                    case .finish:
                        PostExerciseView {
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
