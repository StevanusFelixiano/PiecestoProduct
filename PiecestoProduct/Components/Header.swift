//
//  Header.swift
//  PiecestoProduct
//
//  Created by Julius Diky Ardianto on 02/06/26.
//

import SwiftUI

struct Header: View {
    
    @State var title: String
    @State var subtitle: String
    @State var description: String
    
    private var headerSection: some View {
        ZStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Text(subtitle)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Text(description)
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(.top, 100)
                .padding(.bottom, 36)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
        
            Image("WhiteFlower")
                .resizable()
                .scaledToFit()
                .opacity(0.3)
                .frame(width: 180, alignment: .trailing)
                .offset(x: 270, y: 110)
                .ignoresSafeArea()
        }
        
        .background(colourPeach)
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 32, bottomTrailingRadius: 32))
        .padding(.bottom, 6)
        
        .background(colourOrange)
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 28, bottomTrailingRadius: 28))
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
        
        Spacer()
    }
}

#Preview {
    Header(title: "WORKOUT", subtitle: "Mat Pilates with Julius", description: "Gentle movements to help you feel stronger and lighter")
}
