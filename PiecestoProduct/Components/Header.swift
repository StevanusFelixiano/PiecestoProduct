//
//  Header.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 02/06/26.
//

import SwiftUI

struct Header: View {
    
    let content: HeaderContent
    private var textBottomPadding: CGFloat {
        content.subtitle.isEmpty ? 60 : 50
    }
    
    private var headerSection: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 6) {
                Text(content.title)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.white)
                
                if !content.subtitle.isEmpty {
                    Text(content.subtitle)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 275, alignment: .leading)
                }
                
                if !content.description.isEmpty {
                    Text(content.description)
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 1.00))
                        .frame(maxWidth: 270, alignment: .leading)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, textBottomPadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            
            Image("WhiteFlower")
                .resizable()
                .scaledToFit()
                .opacity(0.3)
                .frame(width: 260, alignment: .trailing)
                .offset(x: 230, y: 125)
                .ignoresSafeArea()
        }
        .frame(height: 285)
        .background(colourPeach)
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 32, bottomTrailingRadius: 32))
        .padding(.bottom, 8)
        .background(colourOrange)
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 18, bottomTrailingRadius: 18))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    private var colourPeach: Color {
        Color(red: 250/255, green: 154/255, blue: 138/255)
    }
    
    private var colourOrange: Color {
        Color(red: 251/255, green: 212/255, blue: 171/255)
    }
    
    var body: some View {
        headerSection
            .ignoresSafeArea(edges: .top)
    }
}

#Preview {
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
