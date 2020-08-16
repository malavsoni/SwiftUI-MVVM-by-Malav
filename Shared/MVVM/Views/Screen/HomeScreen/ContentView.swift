//
//  ContentView.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    // MARK: - Observed Properties
    @ObservedObject var viewModel:ContentViewModel = ContentViewModel()

    init() {
        self.defaultUISettings()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                // Location Information View
                if (self.viewModel.locationInfo != nil) {
                    VStack(alignment: HorizontalAlignment.center, spacing: 10.0) {
                        CityInfoView(withInfo: viewModel)
                        if self.viewModel.locationInfo?.weatherInfo != nil {
                            HourlyWeatherInfoView(withInfo: viewModel)
                                .padding(.vertical)
                        }
                        Spacer()
                        Divider()
                    }
                }
                // Additional Information View
                if self.viewModel.selectedHourInfo != nil {
                    VStack(alignment: HorizontalAlignment.center, spacing: 10.0) {
                        HourlyAdditionalInfoView(withInfo: viewModel.selectedHourInfo!)
                        Divider()
                    }
                }
                // Error View
                if viewModel.errorMessage != nil {
                    ErrorView(message: viewModel.errorMessage!, action: {
                        self.viewModel.fetchLocation()
                    })
                } else if self.viewModel.locationInfo == nil || self.viewModel.selectedHourInfo == nil {
                    // Loading Indicator
                    LoadingView()
                }
            }
            .padding(20.0)
            .onAppear(perform: {
                self.viewModel.fetchLocation()
            })
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                    }, label: {
                        Image("setting-slider-horizontal")
                            .renderingMode(.template)
                            .foregroundColor(Color.appPrimary)
                            .padding(.leading, 5.0)
                    }),
                trailing:
                    Button(
                        action: {},
                    label: {
                        Image("real-estate-search-house")
                            .renderingMode(.template)
                            .foregroundColor(Color.appPrimary)
                            .padding(.trailing, 5.0)
            }))
        }
    }

    func defaultUISettings() {
        // this is not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()

        // this overrides everything you have set up earlier.
        appearance.backgroundColor = UIColor.white
        appearance.backgroundImage = nil
        appearance.shadowColor = .clear

        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().shadow = true

        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
