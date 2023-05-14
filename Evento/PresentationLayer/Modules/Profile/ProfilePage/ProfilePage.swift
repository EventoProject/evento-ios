//
//  ProfilePage.swift
//  Evento
//
//  Created by  Yeskendir Ayat on 14.05.2023.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        CircularImageView(imageName: "person_circle")
    }
}

struct CircularImageView: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 0)
            .position(x: 200, y: 150)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
