//
//  ExampleInteractor.swift
//  DVICEArchitecture
//
//  Created by Timothy Esposito on 7/28/21.
//

import Foundation
import Combine

protocol ExampleInteractor {
    func getData() -> AnyPublisher<Void, Never>
}

class WPExampleInteractor: ExampleInteractor {    
    func getData() -> AnyPublisher<Void, Never> {
        Future { promise in
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}
