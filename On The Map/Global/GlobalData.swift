//
//  GlobalData.swift
//  On The Map
//
//  Created by Pierre Younes on 3/8/21.
//

import Foundation

class GlobalData: NSObject {
    
    static let shared: GlobalData = GlobalData()
    
    var locations = [StudentLocation]()
    
    var sessionID: String? = nil
    var uniqueKey = ""
    var firstName = "Pierre"
    var lastName = "Younes"
    var objectID = ""
    
    func logOut() {
        self.sessionID = nil
        self.uniqueKey = ""
        self.firstName = ""
        self.lastName = ""
        self.objectID = ""
    }
}
