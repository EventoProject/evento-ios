//
//  CustInjection.swift
//  Evento
//
//  Created by Ramir Amrayev on 02.05.2023.
//

import Foundation
import Swinject

/// Buffer protocol from Swinject to Feature Module Assemblies to provide dependencies
/// It provides an abstraction, allowing for assemblies to not be aware of 3rd-party lib existence
protocol CustInjection {
    func inject<Dependency>(_ serviceType: Dependency.Type) -> Dependency
    func reset(_ objectScope: ObjectScope)
}
