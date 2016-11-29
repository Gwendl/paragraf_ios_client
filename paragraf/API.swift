//
//  API.swift
//  paragraf
//
//  Created by gwendal lasson on 24/11/16.
//  Copyright © 2016 Adrien Morel. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import SwiftyJSON



class API {
    
    enum APIError : Error {
        case facebookTokenError
        case APITokenError
    }
    
    let serverURL: String
    let port: Int
    private var session: Session? = nil
    
    init(serverURL: String, port: Int) {
        self.serverURL = serverURL
        self.port = port
    }
    
    func retrieveSession(success successHandler: @escaping (_ session: Session) -> (), error errorHandler: @escaping (_ error: Error) -> ()) {
        
        guard session == nil else {
            return successHandler(session!)
        }
        
        guard let facebookToken = FBSDKAccessToken.current()?.tokenString else {
            return errorHandler(APIError.facebookTokenError)
        }
        
        let parameters: Parameters = ["access_token" : facebookToken]
        let request = serverURL + ":" + String(port) + "/token"
        Alamofire.request(request , method: .get, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Token granted")
                let json = JSON(value)
                successHandler(Session(json: json))
            case .failure(let error):
                print("Failed to retrieve token")
                errorHandler(error)
            }
        }

    }
    
    func retrieveProfile(id: Int,success SuccessHandler: @escaping (_ profile: Profile) -> (), error errorHandler: @escaping (_ error: Error) -> ()) {
       
        retrieveSession(success: {token in
            let request = self.serverURL + ":" + String(self.port) + String(id)
            let parameters: Parameters = ["access_token": token]
            Alamofire.request(request, method: .get, parameters: parameters).validate().responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    print("Profile retrieved")
                    let json = JSON(value)
                    SuccessHandler(Profile(json: json))
                    
                case .failure(let error):
                    print("Failed to retrieve profile")
                    errorHandler(error)
                }
            }
        }, error: { retriveTokenError in errorHandler(retriveTokenError) })
        
    }
    
}
