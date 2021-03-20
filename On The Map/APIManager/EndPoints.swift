//
//  EndPoints.swift
//  On The Map
//
//  Created by Pierre Younes on 3/8/21.
//

import Foundation


enum EndPoints {
    static let baseURL = "https://onthemap-api.udacity.com/v1"
    
    case studentLocation(Location)
    case user(User)
    
    var string: String {
        switch self {
        case .studentLocation(let location):
            switch location {
            case .getStudentLocation:
                return "/StudentLocation?limit=100&order=-updatedAt"
            case .addStudentLocation:
                return "/StudentLocation"
            case .updStudentLocation(let uniqueKey):
                return "/StudentLocation/\(uniqueKey)"
            }
            
        case .user(let action):
            switch action {
            case .login, .logout:
                return "/session"
            case .getUserData(let id):
                return "/users/\(id)"
            }
        }
    }
    
    // Returns the String Url and convert it to URL
    var url: URL {
        return URL(string: "\(EndPoints.baseURL)\(string)")!
    }
}

// MARK: - Location EndPoint Enum
enum Location {
    case getStudentLocation
    case addStudentLocation
    case updStudentLocation(String)
}


// MARK: - User EndPoint Enum
enum User {
    case login
    case logout
    case getUserData(String)
}
