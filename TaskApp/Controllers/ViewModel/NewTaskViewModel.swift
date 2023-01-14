//
//  NewTaskViewModel.swift
//  TaskApp
//
//  Created by Junaid on 05/01/2023.
//

import Foundation
import Combine


class NewTaskViewModel {

    private var canceallbel = Set<AnyCancellable>()
    init() {
        
    }

    struct Input {
        let textFieldPublihser: AnyPublisher<String?, Never>
    }

    struct Output {
        let validator: AnyPublisher<Bool, Never>
    }

    func transfor(input: Input) -> Output {
        let subject: PassthroughSubject<Bool, Never> = .init()
        
        input.textFieldPublihser.sink { optionalString in
            if optionalString?.isEmpty == true || optionalString == "" {
                subject.send(false)
            } else { subject.send(true)}
        }.store(in: &canceallbel)
        
        let outPut = Output(validator:
                                subject.eraseToAnyPublisher()
        )
        return outPut
    }
}
