//
//  DevelopersViewModel.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/9/20.
//

import RxSwift
import RxCocoa
import Action

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class DevelopersViewModel {
    
    private let randomNameUseCase = RandomNameUseCase()
    private let getDevelopersUseCase = GetDevelopersUseCase(service: MockDeveloperService())
    
}

// MARK: ViewModelType
extension DevelopersViewModel: ViewModelType {
    
    struct Input {
        let addTap: Driver<Void>
    }
    
    struct Output {
        let elements: Driver<[Developer]>
        let getDevelopersAction: Action<Void, [MockData]>
        let mockElements: Observable<[MockData]>
    }
    
    func transform(input: Input) -> Output {
        let useCaseOutput = randomNameUseCase.produce(input: .init(tap: input.addTap))

        let elements = useCaseOutput.developer.scan([]) { (oldValue, newValue) -> [Developer] in
            oldValue + [newValue]
        }
        
        let getDevelopersAction = getDevelopersUseCase.produce(input: .init())
        let mockElements = getDevelopersAction.elements
        
        return Output(elements: elements, getDevelopersAction: getDevelopersAction, mockElements: mockElements)
    }
}
