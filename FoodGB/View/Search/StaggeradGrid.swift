//
//  StaggeradGrid.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 25.11.2022.
//

import SwiftUI

struct StaggeradGrid<Content: View, T: Identifiable>: View where T: Hashable {
    
    // MARK: - Properties
    var content: (T) -> Content
    var list: [T]
    var columns: Int
    var showsInndicators: Bool
    var spacing: CGFloat
    
    // MARK: - Initialisation
    init(columns: Int, showsInndicators: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.list = list
        self.columns = columns
        self.showsInndicators = showsInndicators
        self.spacing = spacing
    }
    
    // MARK: - Functions
    func setUpList() -> [[T]] {
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        var currantIndex: Int = 0
        for object in list {
            gridArray[currantIndex].append(object)
            if currantIndex == (columns - 1) {
                currantIndex = 0
            } else {
                currantIndex += 1
            }
        }
        return gridArray
    }
    
    func getIndex(values: [T]) -> Int {
        setUpList().firstIndex { $0 == values } ?? 0
    }
    
    // MARK: - Views
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ForEach(setUpList(), id: \.self) { columnsData in
                LazyVStack(spacing: spacing) {
                    ForEach(columnsData) { object in
                        content(object)
                    }
                }
                .padding(.top, getIndex(values: columnsData) == 1 ? 80 : 0)
            }
        }
        .padding(.vertical)
    }
}
