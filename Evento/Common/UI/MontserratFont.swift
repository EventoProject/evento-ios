//
//  CustFont.swift
//  Evento
//
//  Created by Ramir Amrayev on 19.04.2023.
//

import UIKit.UIFont
import SwiftUI

struct MontserratFont {
    enum Weight {
        case bold
        case semiBold
        case medium
        case regular
        case thin
    }
    
    static func createUIFont(weight: Weight, size: CGFloat) -> UIFont {
        let font: UIFont?
        
        switch weight {
        case .bold:
            font = UIFont(name: "Montserrat-Bold", size: size)
        case .semiBold:
            font = UIFont(name: "Montserrat-SemiBold", size: size)
        case .medium:
            font = UIFont(name: "Montserrat-Medium", size: size)
        case .regular:
            font = UIFont(name: "Montserrat-Regular", size: size)
        case .thin:
            font = UIFont(name: "Montserrat-Thin", size: size)
        }
        
        return font ?? UIFont.systemFont(ofSize: 12)
    }
    
    static func createFont(weight: Weight, size: CGFloat) -> Font {
        return Font(createUIFont(weight: weight, size: size))
    }
}
