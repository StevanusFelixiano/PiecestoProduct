//
//  MainScrollView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 03/06/26.
//

import SwiftUI

struct MainScrollView: View {
    @State private var isScrollDisabled = true
    
    @State private var selectedEnergy: EnergyState = .findingRhythm
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        HomePageView(onWorkoutTap: {_ in 
                            isScrollDisabled = false
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.85)) {
                                proxy.scrollTo("workout_plan_section", anchor: .top)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isScrollDisabled = true
                            }
                        })
                        .id("homepage_section")
                        .containerRelativeFrame(.vertical, alignment: .center)
                        
                        WorkoutPlanView(onBackTap: {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.85)) {
                                proxy.scrollTo("homepage_section", anchor: .top)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                isScrollDisabled = false
                            }
                        }, energyState: selectedEnergy)
                        .id("workout_plan_section")
                        .containerRelativeFrame(.vertical, alignment: .center)
                    }
                }
                .scrollDisabled(isScrollDisabled)
                .ignoresSafeArea()
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .home:
                    HomePageView()
                case .plan (let exactEnergyState):
                    WorkoutPlanView(energyState: exactEnergyState)
                case .video:
                    WorkoutVideoView()
                case .breathing:
                    BreathingExerciseView()
                case .finish:
                    PostExerciseView()
                }
            }
        }
    }
}

#Preview {
    AppThemeManager{
        MainScrollView()
    }
}
