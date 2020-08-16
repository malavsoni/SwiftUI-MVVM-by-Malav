//
//  HourlyWeatherInfoView.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct HourlyWeatherInfoView: View {
    // MARK: - Published Properties
    @ObservedObject var model:ContentViewModel

    // MARK: - Private Properties
    private let shape = RoundedRectangle(cornerRadius: 20.0)

    // MARK: - Init
    init(withInfo model:ContentViewModel) {
        self.model = model
    }

    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: VerticalAlignment.top, spacing: 0.0) {
                Spacer()
                ForEach(0..<model.hourlyInfo.count) {
                    HourInfoItemView(
                        withModel: self.model.hourlyInfo[$0],
                        index: $0,
                        isSelected: $0 == self.model.selectedHourIndex,
                        action: { (index) in
                           OperationQueue.main.addOperation {
                               self.model.selectedHourIndex = index
                           }
                    })
                }
                Spacer()
            }
        }
        .padding(.horizontal,0.0)
        .padding(.vertical,5.0)
        .background(Color.appPrimary).cornerRadius(20.0)
    }
}

struct HourlyWeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherInfoView(withInfo: ContentViewModel())
    }
}
