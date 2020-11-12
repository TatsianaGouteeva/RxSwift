//
//  RandomNameUseCase.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/9/20.
//

import RxCocoa
import RxSwift

protocol UseCaseType {
    
    associatedtype Input
    associatedtype Output
    
    func produce(input: Input) -> Output
}

struct RandomNameUseCase {
    
    private let names = ["Jhonny", "Jimmy", "Katty"]
    private let professions = ["ios", "android", "BA"]
}

// MARK: UseCaseType
extension RandomNameUseCase: UseCaseType {
    
    struct Input {
        let tap: Driver<Void>
    }
    
    struct Output {
        let developer: Driver<Developer>
    }
    
    func produce(input: Input) -> Output {
        let developerDriver = input.tap.map { () -> Developer in
            let position = Array(0...names.count - 1).randomElement() ?? 0
            return Developer(name: names[position], profession: professions[position])
        }

        return Output(developer: developerDriver)
    }
}
