//
//  UserLogin.swift
//  On The Map
//
//  Created by Pierre Younes on 3/8/21.
//

import Foundation

struct UserLogin: Codable {
    
    let account: Account!
    let session: Session

    struct Account: Codable {
        let registered: Bool
        let key:        String
    }

    struct Session: Codable {
        let id:         String
        let expiration: String
    }

}



struct Credentials: Codable {
    let username: String
    let password: String
}

struct Udacity: Codable {
    let udacity: Credentials
}

//MARK: - Failure Response Model
struct UdacityFailure: Codable {
    let status: Int
    let error: String
}

extension UdacityFailure: LocalizedError {
    var errorDescription: String? {
        return error
    }
}



// MARK: - PublicUser

struct UserResponse: Codable {
    let user: UserData?
}

struct UserData: Codable {
    let key: String?
    let nickname: String?
}
