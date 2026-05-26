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
            ScrollView(.horizontal){
                HStack{
                    Circle()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                                .overlay(
                                    Text("1-2 hours")
                                        .foregroundColor(.white)
                                )
                        )
                    Circle()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                                .overlay(
                                    Text("3-4 hours")
                                        .foregroundColor(.white)
                                )
                        )
                    Circle()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                                .overlay(
                                    Text("5-6 hours")
                                        .foregroundColor(.white)
                                )
                        )

                    Circle()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                                .overlay(
                                    Text("7-8 hours")
                                        .foregroundColor(.white)
                                )
                        )

                    Circle()
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                                .overlay(
                                    Text("9-10 hours")
                                        .foregroundColor(.white)
                                )
                        )
                }
            }
            Spacer()
//            Circle()
//                .frame(width: 500, height: 500)
//                .overlay(
//                    Circle()
//                        .frame(width: 350, height: 350)
//                        .foregroundColor(.blue)
//                )
        }
        .padding (.horizontal, 20)
    }
}

#Preview {
    HomePageView()
}
