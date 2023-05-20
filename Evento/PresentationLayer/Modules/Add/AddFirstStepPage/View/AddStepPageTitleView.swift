//
//  AddStepPageTitleView.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.05.2023.
//

import SwiftUI

struct AddStepPageTitleView: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            CustText(
                text: text,
                weight: .semiBold,
                size: 16
            )
            
            Spacer()
        }.padding(.bottom, 14)
    }
}

struct AddStepPageTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AddStepPageTitleView("Step title")
    }
}
