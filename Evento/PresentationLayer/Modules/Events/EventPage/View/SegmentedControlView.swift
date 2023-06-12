//
//  SegmentedControlView.swift
//  Evento
//
//  Created by Ramir Amrayev on 12.06.2023.
//

import SwiftUI

struct SegementedControlView: View {
    @Binding var selectedItem: String
    let items: [String]
    
    var body: some View {
        Picker("", selection: $selectedItem) {
            ForEach(items, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
    }
}
