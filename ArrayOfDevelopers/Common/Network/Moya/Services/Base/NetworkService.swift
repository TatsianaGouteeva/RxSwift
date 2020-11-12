//
//  NetworkService.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

protocol NetworkService {
    associatedtype API: TargetType
    var provider: MoyaProvider<API> { get }
}

//MARK: - Private
extension NetworkService {
    
    typealias ServiceError = AppError & ResponseHandler
    
    func send<Error: ServiceError>(_ api: API) -> Single<Result<Void, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                guard (try? response.filterSuccessfulStatusCodes()) != nil else { return .failure(Error(response: response)) }
                return .success(())
            }
        }
    }
    
    func fetchString<Error: ServiceError>(_ api: API) -> Single<Result<String, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                guard let data = try? response.mapString() else { return .failure(Error(response: response)) }
                return .success(data)
            }
        }
    }
    
    func fetchValue<T, Error: ServiceError>(_ api: API, key: String? = nil) -> Single<Result<T, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                let valueForKey = key.flatMap { response.json?[$0] as? T }
                guard let data = valueForKey ?? (try? response.mapJSON()).flatMap({ $0 as? T }) else { return .failure(Error(response: response)) }
                return .success(data)
            }
        }
    }
    
    func fetchMappable<T: Mappable, Error: ServiceError>(_ api: API, key: String? = nil) -> Single<Result<T, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                let valueForKey = key.flatMap { response.json?[$0] as? [String: Any] }.map { T(JSON: $0) }
                guard let data = valueForKey ?? T(response: response) else { return .failure(Error(response: response)) }
                return .success(data)
            }
        }
    }
    
    func fetchArray<T: Mappable, Error: ServiceError>(_ api: API, key: String? = nil) -> Single<Result<[T], Error>> {
       return makeRequest(to: api).map { result in

            return result.flatMap { response in
                let valueForKey = key.flatMap { response.json?[$0] as? [[String: Any]] }.map { [T](JSONArray: $0) }
                guard let data = valueForKey ?? [T](response: response) else { return .failure(Error(response: response)) }
                return .success(data)

            }
        }
    }
    
    private func makeRequest<Error: ServiceError>(to api: API) -> Single<Result<Response, Error>> {
        return provider.rx.request(api)
            .map { .success($0) }
            .catchError { Single.just(.failure(Error(message: $0.localizedDescription))) }
    }
}

