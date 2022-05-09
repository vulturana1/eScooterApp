//
//  Session.swift
//  eScooter
//
//  Created by Ana Vultur on 18.04.2022.
//

import Foundation

class Session: ObservableObject {
    
    static var shared = Session()
    
    private init() {}
    
    var authToken: String? {
        get {
            UserDefaults.standard.string(forKey: "authToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "authToken")
        }
    }
    
    var isValidSession: Bool {
        API.getCurrentCustomer { response in
            switch response {
            case .success(let user):
                if user.customer.drivingLicense == "" {
                    self.authToken = nil
                }
            case .failure:
                break
            }
        }
        return authToken != nil
    }
    
    func invalidateSession() {
        print(authToken! as String)
        authToken = nil
        objectWillChange.send()
    }

}

