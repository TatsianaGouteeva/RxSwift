//
//  Reactive.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import RxSwiftExt
import RxSwift
import RxCocoa
import Action

extension ObservableType {
    
    func filterErrors() -> Observable<Error> {
        return materialize().filterMap { $0.error == nil ? .ignore : .map($0.error!) }
    }
    
    func filterElements() -> Observable<E> {
        return materialize().filterMap { $0.element == nil ? .ignore : .map($0.element!) }
    }
    
    func errorsSignal() -> Signal<Error> {
        return filterErrors().asSignal(onErrorJustReturn: EmptyError())
    }
}

func errors<ResultValue, Error: Swift.Error, O: ObservableType>(_ observable: O) -> Observable<Swift.Error>
    where O.E == Result<ResultValue, Error> {
        
    return observable.filterMap { result in
        switch result {
        case .success(_): return .ignore
        case .failure(let error): return .map(error)
        }
    }
}

func unwrapResult<ResultValue, Error: Swift.Error, O: ObservableConvertibleType>(_ observable: O) -> Observable<ResultValue>
    where O.E == Result<ResultValue, Error> {
        
    return observable.asObservable().map { result in
        switch result {
        case .failure(let error):
            throw error
        case .success(let value):
            return value
        }
    }
}

extension ObservableType where E == ActionError {
    
    func toError() -> Observable<Error> {
        return map { $0.toError }.unwrap()
    }
}

extension ActionError {
    
    var toError: Error? {
        guard case let .underlyingError(error) = self else { return nil }
        return error
    }
}

