//
//  NameUsernameView.swift
//  Evento
//
//  Created by Ramir Amrayev on 13.06.2023.
//

import SwiftUI

struct NameUsernameView: View {
    let name: String
    let username: String
    
    var body: some View {
        VStack(alignment: .leading) {
            CustText(text: name, weight: .regular, size: 16)
            CustText(text: "@\(username)", weight: .regular, size: 15.5)
                .foregroundColor(CustColor.lightGray)
        }
    }
}
