//
//  RootView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    
    var body: some View {
        if hasCompletedInitialSetup {
            HomePageView()
        } else {
            OnboardPageView()
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
