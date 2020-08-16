//
//  CityInfoView.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct CityInfoView: View {

    // MARK: - Properties
    var model:ContentViewModel

    // MARK: - Init
    init(withInfo model:ContentViewModel) {
        self.model = model
    }

    // MARK: - Body
    var body: some View {
        HStack(alignment: VerticalAlignment.top, spacing: 0.0) {
            VStack(alignment: HorizontalAlignment.leading, spacing: 4.0) {
                Text("\(model.city),\n\(model.country)")
                    .foregroundColor(Color.appPrimary)
                    .scaledFont(type: .bold, size: 25.0)
                    .fixedSize(horizontal: false, vertical: true)
                Text(model.currentDate)
                    .foregroundColor(Color.appSecondary)
                    .scaledFont(type: .semiBold, size: 15.0)
            }
            Spacer()
            Image("Bitmap")
                .frame(width: 130, height: 110, alignment: Alignment.center)
                .cornerRadius(10)
        }
    }
}
