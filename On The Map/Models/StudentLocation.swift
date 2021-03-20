//
//  StudentLocation.swift
//  On The Map
//
//  Created by Pierre Younes on 3/8/21.
//

import Foundation


struct StudentLocation: Codable {
    
    var objectId:  String?
    var uniqueKey: String
    var firstName: String
    var lastName:  String
    var mapString: String
    var mediaURL:  String
    var longitude: Double
    var latitude:  Double
    var createdAt: String?
    var updatesAt: String?
    
    
}

//MARK: - Add Student Location Response Model
struct AddStudentLocationResponse: Codable {
    let objectId:   String
    let createdAt:  String
}


//MARK: - Get Student Locations Response Model
struct GetStudentLocationResponse: Codable {
    let results: [StudentLocation]
}


//MARK: - Update Student Locations Response Model
struct UpdStudentLocationResponse: Codable {
    let updatesAt: String
}

//MARK: - Failure Response Model
struct StudentLocationFailure: Codable {
    let code: Int
    let error: String
}

extension StudentLocationFailure: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
