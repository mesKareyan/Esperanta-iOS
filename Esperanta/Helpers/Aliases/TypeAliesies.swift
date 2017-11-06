//
//  TypeAliesies.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/5/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import Foundation

enum RequestResult {
    case success(user: Any)
    case failure(with: Error)
}

typealias RequestCompletion = (RequestResult) -> ()

enum RequestError: Error {
    case unknown
    case facebookError
}
