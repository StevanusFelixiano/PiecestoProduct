//
//  RootView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenOnboard") private var hasSeenOnboard = false
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    
    var body: some View {
        if !hasSeenOnboard {
            OnboardPageView()
        } else if !hasCompletedInitialSetup {
            AddNameView()
        } else {
            HomePageView()
        }
    }
}

#Preview {
    AppThemeManager {
        RootView()
            .onAppear {
                UserDefaults.standard.removeObject(forKey: "hasCompletedInitialSetup")
            }
    }
}
