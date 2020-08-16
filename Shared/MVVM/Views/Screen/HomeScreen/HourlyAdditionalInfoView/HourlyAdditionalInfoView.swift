//
//  HourlyAdditionalInfoView.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct HourlyAdditionalInfoView: View {

    // MARK: - Properties
    var model:HourlyViewModel

    // MARK: - Init
    init(withInfo model:HourlyViewModel) {
        self.model = model
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 0.0) {
            Text("Additional Info")
                .foregroundColor(Color.appPrimary)
                .scaledFont(type: .semiBold, size: 18.0)
            HStack(alignment: VerticalAlignment.center, spacing: 0.0) {
                HourlyAdditionalDetailView(model: model.precipitation)
                HourlyAdditionalDetailView(model: model.humidity)
                HourlyAdditionalDetailView(model: model.windy)
            }.padding(.vertical)
        }.padding(.vertical)
    }
}

private struct HourlyAdditionalDetailView: View {
    // MARK: - Properties
    var model:AdditionalHourInfo

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 8.0) {
            Text(model.name)
                .foregroundColor(Color.appSecondary)
                .scaledFont(type: .regular, size: 13.0)
            Text(model.value)
                .foregroundColor(Color.appPrimary)
                .scaledFont(type: .semiBold, size: 15.0)
                .fixedSize(horizontal: true, vertical: false)
        }
        .frame(minWidth: 0, maxWidth: .infinity,alignment: Alignment.leading)
    }
}
