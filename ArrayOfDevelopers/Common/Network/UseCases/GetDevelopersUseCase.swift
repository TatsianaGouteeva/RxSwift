//
//  GetDevelopersUseCase.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import RxSwift
import RxCocoa
import Action

struct GetDevelopersUseCase {
    let service: MockDeveloperService

    struct Input { }
    
    func
    produce(input: Input) -> Action<Void, [MockData]> {
        
        return Action<Void, [MockData]> {_ in
            let request = Observable.just(())
                .flatMap { self.service.getDevelopers()}
                .do(onNext: {
                    guard let data = try? $0.get() else { return }
                    print ("got data")
                })
            
            return unwrapResult(request).map{$0}
        }

    }
}
