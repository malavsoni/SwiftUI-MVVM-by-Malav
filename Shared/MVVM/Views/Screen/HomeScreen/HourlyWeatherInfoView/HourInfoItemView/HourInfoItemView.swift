//
//  HourInfoItemView.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct HourInfoItemView: View {
    typealias ButtonAction = ((Int) -> Void)

    // MARK: - Private Properties
    private let gradient = LinearGradient.init(
        gradient: Gradient.init(colors: [.appPrimary,.appPrimaryLight]),
        startPoint: UnitPoint.init(x: 0, y: 0),
        endPoint: UnitPoint.init(x: 1.0, y: 1.0)
    )
    private var isSelected:Bool = false
    private var model:HourlyViewModel
    private var index:Int
    private var action:ButtonAction?

    // MARK: - Init
    init(withModel model:HourlyViewModel,index:Int, isSelected:Bool,action:ButtonAction? = nil) {
        self.model = model
        self.isSelected = isSelected
        self.index = index
        self.action = action
    }

    // MARK: - Body
    var body: some View {
        Button(action: {
            self.action?(self.index)
        }, label: {
            ZStack(alignment: Alignment.center) {
                // Background Gradient
                GeometryReader { geometry in
                    self.addGradiend(withSuperViewWidth: geometry.size.width)
                }
                // Info
                VStack(alignment: HorizontalAlignment.center, spacing: 5.0) {
                    Text(model.time)
                        .foregroundColor(.white)
                        .scaledFont(type: .medium, size: 13.0)
                        .fixedSize(horizontal: true, vertical: false)
                    Image(model.icon)
                        .aspectRatio(contentMode: ContentMode.fit)
                        .foregroundColor(Color.white)
                    Text(model.temprature)
                        .foregroundColor(.white)
                        .scaledFont(type: .medium, size: 13.0)
                }
                .padding(.vertical,5.0)
                .padding(.horizontal, 14.0)
            }
        })
    }

    // MARK: - Helpers
    func addGradiend(withSuperViewWidth width:CGFloat) -> some View {
        return Rectangle()
            .fill(gradient)
            .cornerRadius(16.0)
            .frame(width: width + 7.5)
            .opacity(isSelected ? 1.0 : 0.0)
            .offset(x: -3.75, y: 0)
    }
}
