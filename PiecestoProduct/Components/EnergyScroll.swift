//
//  EnergyScroll.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 26/05/26.
//

import SwiftUI

struct EnergyScroll: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                        .frame(width: 200, height: 300)
                        .scrollTransition(axis: .horizontal) { content, phase in
                            content
                                // Optional: Add vertical offset for a curved path
                                .offset(y: phase.isIdentity ? 0 : abs(phase.value) * 50)
                                // Rotary rotation effect
                                .rotationEffect(.degrees(phase.value * 30))
                        }
                }
            }
            .scrollTargetLayout() // Ensures snapping works correctly
        }
        .scrollTargetBehavior(.viewAligned) // Snaps to each item

    }
}

#Preview {
    EnergyScroll()
}
