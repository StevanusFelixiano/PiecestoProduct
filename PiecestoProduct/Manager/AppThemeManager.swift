//
//  AppThemeManager.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 25/05/26.
//

import SwiftUI

struct AppThemeManager<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("hasSetThemeManually") private var hasSetThemeManually = false
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                if !hasSetThemeManually {
                    isDarkMode = colorScheme == .dark
                }
            }
    }
}
