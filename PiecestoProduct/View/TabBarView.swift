//
//  TabBarView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        Button("Settings") {
            // Action will be added later
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 20)
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
