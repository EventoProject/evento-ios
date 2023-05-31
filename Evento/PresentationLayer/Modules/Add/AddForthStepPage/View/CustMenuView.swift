//
//  CustMenuView.swift
//  Evento
//
//  Created by Ramir Amrayev on 27.05.2023.
//

import SwiftUI

enum CustMenuTypes {
    case format
    case ageLimit
    
    var title: String {
        switch self {
        case .format:
            return "Format"
        case .ageLimit:
            return "Age limit"
        }
    }
    
    var items: [String] {
        switch self {
        case .format:
            return ["Offline", "Online"]
        case .ageLimit:
            return ["0+", "6+", "12+", "16+", "18+", "21+"]
        }
    }
    
    var hiddenPickerTitle: String {
        switch self {
        case .format:
            return "Select format"
        case .ageLimit:
            return "Select age limit"
        }
    }
}

struct CustMenuView: View {
    @Binding var selectedItem: String
    let title: String
    let hiddenPickerTitle: String
    let items: [String]
    
    init(selectedItem: Binding<String>, title: String, hiddenPickerTitle: String, items: [String]) {
        self._selectedItem = selectedItem
        self.title = title
        self.hiddenPickerTitle = hiddenPickerTitle
        self.items = items
    }
    
    init(selectedItem: Binding<String>, type: CustMenuTypes) {
        self.init(
            selectedItem: selectedItem,
            title: type.title,
            hiddenPickerTitle: type.hiddenPickerTitle,
            items: type.items
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: "\(title):", weight: .medium, size: 16)
            Menu(
                content: {
                    Picker(hiddenPickerTitle, selection: $selectedItem) {
                        ForEach(items, id: \.self) {
                            Text($0)
                        }
                    }
                },
                label: {
                    menuInputView
                }
            )
        }
    }
    
    private var menuInputView: some View {
        HStack {
            CustText(text: selectedItem, weight: .regular, size: 15)
                .foregroundColor(.black)
            Spacer()
            Image(uiImage: Images.menuDownArrow)
        }
        .padding(15)
        .background(CustColor.backgroundColor)
        .cornerRadius(20)
    }
}
