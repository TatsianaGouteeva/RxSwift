//
//  DevelopersViewModel.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/9/20.
//


import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class DevelopersViewModel {
    
    private let randomNameUseCase = RandomNameUseCase()

}

// MARK: ViewModelType
extension DevelopersViewModel: ViewModelType {
    
    struct Input {
        let addTap: Driver<Void>
    }
    
    struct Output {
        let elements: Driver<[Developer]>
    }
    
    func transform(input: Input) -> Output {
        let useCaseOutput = randomNameUseCase.produce(input: .init(tap: input.addTap))
//        let combinedSequence = Driver.combineLatest(useCaseOutput.name, useCaseOutput.profession)

        let elements = useCaseOutput.developer.scan([]) { (oldValue, newValue) -> [Developer] in
            oldValue + [newValue]
        }
        
        return Output(elements: elements)
    }
}
