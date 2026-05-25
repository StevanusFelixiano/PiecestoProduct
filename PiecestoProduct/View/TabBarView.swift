//
//  TabBarView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            WorkoutPageView()
                .tabItem {
                    Label("Workout", systemImage: "dumbbell.fill")
                }
        }
    }
}

#Preview {
    TabBarView()
}
