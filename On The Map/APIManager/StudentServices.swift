//
//  StudentServices.swift
//  On The Map
//
//  Created by Pierre Younes on 3/8/21.
//

import Foundation


class StudentServices {
    
    static let shared: StudentServices = StudentServices()
    
    // used to send dummy body when using the .get Request
    struct Dummy: Codable {}
    
    /**
     - EndPoint name: StudentLocation?limit=100&order=-updateAt
     - Method            : GET
     - Parameters   :
     - Comment          : function to get the list of the student location limit to 100
     - Object                : StudentLocation
     */
    func getStudentLocations(completion: @escaping ([StudentLocation]?, Error?) -> Void) {
        let body = Dummy()
        TASKManager.taskHandler(url: EndPoints.studentLocation(.getStudentLocation).url
                                ,method: .get
                                ,host: .parse
                                ,responseType: GetStudentLocationResponse.self
                                ,body: body
                                ,failure: StudentLocationFailure.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    
    /**
     - EndPoint name: StudentLocation
     - Method               : POST
     - Parameters     :
     - Comment           : function to add the student location
     - Object                : StudentLocation
     */
    func addStudentLocation(studentLocation body: StudentLocation, completion: @escaping (AddStudentLocationResponse?, Error?) -> Void) {
        TASKManager.taskHandler(url: EndPoints.studentLocation(.addStudentLocation).url
                                ,method: .post
                                ,host: .parse
                                ,responseType: AddStudentLocationResponse.self
                                ,body: body
                                ,failure: StudentLocationFailure.self) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    /**
     - EndPoint name: StudentLocation
     - Method               : PUT
     - Parameters     :
     - Comment           : function to add the student location
     - Object                : StudentLocation
     */
    func updStudentLocation(uniqueKey: String, studentLocation body: StudentLocation, completion: @escaping (UpdStudentLocationResponse?, Error?) -> Void) {
        TASKManager.taskHandler(url: EndPoints.studentLocation(.updStudentLocation(uniqueKey)).url
                                ,method: .put
                                ,host: .parse
                                ,responseType: UpdStudentLocationResponse.self
                                ,body: body
                                ,failure: StudentLocationFailure.self) { (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
