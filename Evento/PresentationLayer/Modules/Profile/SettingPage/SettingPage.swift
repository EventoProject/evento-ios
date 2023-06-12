//
//  SettingPage.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import SwiftUI
import Foundation

struct SettingPage: View {
    @ObservedObject var viewModel: GeneralViemModel
    @State private var selectedSegmentIndex: Int = 0
    private let segments = ["General", "Profile"]
    @State var selectedTabIndex = 0
    var body: some View {
        VStack {
            CustomSegmentController(selectedSegmentIndex: $selectedSegmentIndex, segments: segments)
                .padding(.horizontal)
            TabView(selection: $selectedSegmentIndex) {
                GeneralPage(viewModel: viewModel)
                    .tag(0)
                ProfileSetPage(viewModel: ProfileSetViewModel())
                    .tag(1)
            }
        }
    }
}

