//
//  CustomCorners.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 27.10.2022.
//

import SwiftUI

struct CustomCorners: Shape {
    
    // MARK: - Properties
    var corners: UIRectCorner
    var radius: CGFloat
    
    // MARK: - Functions
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
