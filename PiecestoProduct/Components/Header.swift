//
//  Header.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 02/06/26.
//

import SwiftUI

struct Header: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("textScale") private var textScale = 1.0
    
    @State private var showSettings = false
    
    let content: HeaderContent
    let flowerOffset: CGSize
    
    let showMenuButton: Bool
    
    init(
        content: HeaderContent,
        flowerOffset: CGSize = CGSize(width: 100, height: 100),
        showMenuButton: Bool = true,
    ) {
        self.content = content
        self.flowerOffset = flowerOffset
        self.showMenuButton = showMenuButton
    }
    
    private var isDark: Bool {
        colorScheme == .dark
    }
    
    private var textBottomPadding: CGFloat {
        content.subtitle.isEmpty ? 90 : 60
    }
    
    private var headerSection: some View {
        ZStack(alignment: .trailing) {
            if showSettings {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(
                            .spring(response: 0.3, dampingFraction: 0.85)
                        ) {
                            showSettings = false
                        }
                    }
                    .zIndex(20)
                            
                SettingsPopoverView()
                    .frame(width: 280)
                    .padding(.trailing, 28)
                    .padding(.top, 58)
                    .transition(
                        .scale(scale: 0.92, anchor: .topTrailing)
                        .combined(with: .opacity)
                    )
                    .zIndex(30)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(content.title)
                    .font(.system(size: 25 * textScale, weight: .bold))
                    .foregroundStyle(.white)
                
                if !content.subtitle.isEmpty {
                    Text(content.subtitle)
                        .font(.system(size: 20 * textScale, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 275, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                if !content.description.isEmpty {
                    Text(content.description)
                        .font(.system(size: 15 * textScale, weight: .light))
                        .foregroundStyle(
                            isDark
                            ? Color.white.opacity(0.82)
                            : Color(red: 0.949, green: 0.949, blue: 0.969)
                        )
                        .frame(maxWidth: 270, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, textBottomPadding)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottomLeading
            )
            
            Image("WhiteFlower")
                .resizable()
                .scaledToFit()
                .opacity(isDark ? 0.18 : 0.3)
                .frame(width: 260, alignment: .leading)
                .offset(x: flowerOffset.width, y: flowerOffset.height)
                .ignoresSafeArea()
            
        }
        .frame(height: 280)
        .background(headerMainColor)
        .clipShape(
            UnevenRoundedRectangle(
                bottomLeadingRadius: 32,
                bottomTrailingRadius: 32
            )
        )
        .padding(.bottom, 8)
        .background(headerBottomColor)
        .clipShape(
            UnevenRoundedRectangle(
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20
            )
        )
        .shadow(
            color: isDark ? .black.opacity(0.25) : .black.opacity(0.1),
            radius: 10,
            x: 0,
            y: 5
        )
    }
    
    private var headerMainColor: Color {
        isDark
        ? Color(red: 0.28, green: 0.15, blue: 0.20)
        : Color(hex: "#FA9A8A")
    }
    
    private var headerBottomColor: Color {
        isDark
        ? Color(red: 0.38, green: 0.22, blue: 0.28)
        : Color(red: 251/255, green: 212/255, blue: 171/255)
    }
    
    var body: some View {
        headerSection
            .ignoresSafeArea(edges: .top)
    }
}

#Preview("Plan") {
    ZStack(alignment: .top) {
        Color.white
            .ignoresSafeArea()
        
        Header(
            content: HeaderContent(
                title: "WORKOUT",
                subtitle: "",
                description: "Gentle movements to help you feel stronger and lighter"
            )
        )
    }
}

#Preview("Video") {
    ZStack(alignment: .top) {
        Color.white
            .ignoresSafeArea()
        
        Header(
            content: HeaderContent(
                title: "WORKOUT",
                subtitle: "Mat Pilates with Julius",
                description: "Gentle movements to help you feel stronger and lighter"
            )
        )
    }
}
