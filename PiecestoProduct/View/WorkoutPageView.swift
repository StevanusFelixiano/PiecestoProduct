//
//  WorkoutPageView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct WorkoutPageView: View {
    
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    
    var body: some View {
        Text("Workout Plan")
    }
}

#Preview {
    AppThemeManager {
        WorkoutPageView()
            .onAppear {
                UserDefaults.standard.removeObject(forKey: "hasCompletedInitialSetup")
            }
    }
}
