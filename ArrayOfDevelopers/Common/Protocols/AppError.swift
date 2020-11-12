//
//  AppError.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import Foundation

protocol AppError: Error {
    var message: String { get }
    init(message: String)
}

struct EmptyError: Error {
    
}

struct InternalError: AppError {
    let message: String
}
