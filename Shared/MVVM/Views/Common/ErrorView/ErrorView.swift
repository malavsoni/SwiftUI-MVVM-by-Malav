//
//  ErrorView.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 17/05/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct ErrorView: View {

    var message:String
    var action:(() -> Void)?

    var body: some View {
        HStack(alignment: VerticalAlignment.center, spacing: 0.0) {
            Spacer()
            VStack(alignment: HorizontalAlignment.center, spacing: 10.0) {
                Text(message)
                    .scaledFont(type: .regular, size: 20.0)
                    .foregroundColor(Color.white)
                    .fixedSize(horizontal: false, vertical: false)
                    .multilineTextAlignment(.center)
                Button(action: {
                    self.action?()
                }, label: {
                    Image("baseline_refresh_white_36pt").foregroundColor(Color.white)
                })
            }.padding()
            Spacer()
        }
        .background(Color.appSecondary)
        .cornerRadius(10.0)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .buttonStyle(PlainButtonStyle())
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "No internet connection")
    }
}
