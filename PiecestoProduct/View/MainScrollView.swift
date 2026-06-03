//
//  MainScrollView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 03/06/26.
//

import SwiftUI

struct MainScrollView: View {
    @State private var isScrollDisabled = true
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        HomePageView(onWorkoutTap: {
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
                        })
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
                case .plan:
                    WorkoutPlanView()
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
