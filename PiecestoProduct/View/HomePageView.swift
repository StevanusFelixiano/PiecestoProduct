//
//  HomePageView.swift
//  PiecestoProduct
//
//  Created by Satria Adi Firmansyah on 23/05/26.
//

import SwiftUI

struct HomePageView: View {
    @AppStorage("hasCompletedInitialSetup") private var hasCompletedInitialSetup = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .center){
                Text("Hi, Sora!")
                    .font(Font.title.bold())
                Text("Let us do the gentle check, How many hours did you sleep last night?")
                Circle()
                    .frame(width: 200, height: 200)
                    .overlay(
                        Text ("Element")
                            .foregroundColor(.white)
                    )
                EnergyScroll()
                
                NavigationLink{
                    //TBD
                    WorkoutPageView()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 200, height: 50)
                        .foregroundColor(.blue)
                        .overlay(
                            Text ("Go to Workout")
                                .foregroundColor(.white)
                        )
                }
                
                
    //            Spacer()
    //            Circle()
    //                .frame(width: 500, height: 500)
    //                .overlay(
    //                    Circle()
    //                        .frame(width: 350, height: 350)
    //                        .foregroundColor(.blue)
    //                )
            }
        }
        .padding (.horizontal, 20)
    }
}

#Preview {
    HomePageView()
}
