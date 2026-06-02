//
//  WorkoutPlanItem.swift
//  PiecestoProduct
//
//  Created by Stevanus Felixiano on 02/06/26.
//

import Foundation

struct WorkoutPlanItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: String
}
