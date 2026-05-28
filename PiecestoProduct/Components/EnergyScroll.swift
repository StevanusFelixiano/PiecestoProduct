//
//  EnergyScroll.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 26/05/26.
//

import SwiftUI

struct EnergyScroll: View {
    @State private var selectedIndex: Int? = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(selectedIndex == index ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 200, height: 300)
                        .scaleEffect(selectedIndex == index ? 1.05 : 1.0)
                        .scrollTransition(axis: .horizontal) { content, phase in
                            content
                                .offset(y: phase.isIdentity ? 0 : abs(phase.value) * 50)
                                .rotationEffect(.degrees(phase.value * 30))
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                selectedIndex = index
                            }
                        }
                        // 1. Assign an ID to each item so the ScrollView can track it
                        .id(index)
                }
            }
            .padding(.horizontal, 40)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        // 2. Bind the scroll position to your selectedIndex state
        .scrollPosition(id: $selectedIndex)
        // 3. Add an animation so the color/scale changes smoothly as it snaps
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedIndex)
    }
}

#Preview {
    EnergyScroll()
}


////
////  EnergyScroll.swift
////  PiecestoProduct
////
////  Created by Satria Adi Firmansyah on 26/05/26.
////
//
//import SwiftUI
//
//struct EnergyScroll: View {
//    @State private var selectedIndex: Int? = 0
//    
//    // 1. Imagine you have an array of image names from your Assets catalog
//    let images = ["energy_0", "energy_1", "energy_2", "energy_3", "energy_4", "energy_5", "energy_6", "energy_7", "energy_8", "energy_9"]
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyHStack(spacing: 20) {
//                // 2. Loop through the array using indices
//                ForEach(images.indices, id: \.self) { index in
//                    Image(images[index])
//                        .resizable() // Tells SwiftUI the image is allowed to resize
//                        .scaledToFill() // Ensures the image fills the frame without stretching
//                        .frame(width: 200, height: 300)
//                        // 3. Clip the image to keep those nice rounded corners
//                        .clipShape(RoundedRectangle(cornerRadius: 25))
//                        
//                        // 4. Update the selection styling for images
//                        .opacity(selectedIndex == index ? 1.0 : 0.5) // Dim unselected images
//                        .overlay(
//                            // Optional: Add a blue border around the selected image
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(selectedIndex == index ? Color.blue : Color.clear, lineWidth: 4)
//                        )
//                        .scaleEffect(selectedIndex == index ? 1.05 : 1.0)
//                        
//                        .scrollTransition(axis: .horizontal) { content, phase in
//                            content
//                                .offset(y: phase.isIdentity ? 0 : abs(phase.value) * 50)
//                                .rotationEffect(.degrees(phase.value * 30))
//                        }
//                        .onTapGesture {
//                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
//                                selectedIndex = index
//                            }
//                        }
//                        .id(index)
//                }
//            }
//            .padding(.horizontal, 40)
//            .scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
//        .scrollPosition(id: $selectedIndex)
//        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedIndex)
//    }
//}
//
//#Preview {
//    EnergyScroll()
//}
