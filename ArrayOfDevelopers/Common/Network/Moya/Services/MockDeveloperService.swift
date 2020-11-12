//
//  MockDeveloperService.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import Moya
import RxSwift

class MockDeveloperService: NetworkService {

    let provider = MoyaProvider<MockAPI>(stubClosure: MoyaProvider.delayedStub(1.0))

    func getDevelopers() -> Single<Result<[MockData], NetworkError>> {
        fetchArray(.getDevelopers)
    }
}
