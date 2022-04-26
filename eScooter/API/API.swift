//
//  API.swift
//  eScooter
//
//  Created by Ana Vultur on 18.04.2022.
//

import Alamofire
import SwiftUI
import UIKit

typealias Result<T> = Swift.Result<T, Error>

struct APIError: Error {
    let message: String
    var localizedDescription: String {
        return message
    }
}

struct API {
    
    static let URLString = "https://move-scooter-app.herokuapp.com"
    
    static func handleResponse<T: Decodable>(response: AFDataResponse<Data?>) -> Result<T> {
        do {
            if response.response?.statusCode == 401 {
                Session.shared.invalidateSession()
                return .failure(APIError.init(message: "Session not valid"))
            }
            if response.response?.statusCode == 200 {
                let result = try JSONDecoder().decode(T.self, from: response.data!)
                return .success(result)
            } else {
                if let data = response.data {
                    let result = try JSONDecoder().decode(Message.self, from: data)
                    return .failure(APIError(message: result.message))
                } else {
                    return .failure(APIError(message: "No data found"))
                }
            }
        } catch DecodingError.keyNotFound(let key, let context) {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
        return .failure(APIError(message: "no data"))
    }
    
    static func register(email: String, username: String, password: String, _ callback: @escaping (Result<Authentication>) -> Void) {
        AF.request("\(URLString)/customer/register",
                   method: .post,
                   parameters: ["email": email, "username": username, "password": password],
                   encoder: JSONParameterEncoder.default)
        .response { response in
            debugPrint(response)
            let result: Result<Authentication> = handleResponse(response: response)
            callback(result)
        }
    }
    
    static func login(email: String, password: String, _ callback: @escaping (Result<Authentication>) -> Void) {
        AF.request("\(URLString)/customer/login",
                   method: .post,
                   parameters: ["email": email, "password": password],
                   encoder: JSONParameterEncoder.default)
        .response { response in
            let result: Result<Authentication> = handleResponse(response: response)
            callback(result)
        }
    }
    
    static func uploadPicture(image: Image, _ callback: @escaping (Result<Bool>) -> Void) {
        guard let token = Session.shared.authToken else {
            callback(.failure(APIError.init(message: "Invalid token")))
            return
        }
        let header: HTTPHeaders = ["Authorization": "Bearer " + token]
        let uiImage = image.asUIImage()
        let imgData = uiImage.jpegData(compressionQuality: 0.85)
        
        AF.upload(multipartFormData: {
            multipartFormData in
            if let data = imgData {
                multipartFormData.append(data, withName: "license", fileName: "file.jpg", mimeType: "image/jpg")
            }
        }, to: "\(URLString)/customer/license",
                  usingThreshold: UInt64.init(),
                  method: .post,
                  headers: header,
                  interceptor: nil,
                  fileManager: FileManager.default,
                  requestModifier: nil)
        .response { response in
            debugPrint(response)
            if response.response?.statusCode == 200 {
                callback(.success(true))
            } else {
                callback(.failure(APIError.init(message: "Failed to upload")))
            }
        }
    }
    
    static func logout() {
        guard let token = Session.shared.authToken else {
            return
        }
        let header: HTTPHeaders = ["Authorization": "Bearer " + token]
        AF.request("\(URLString)/customer/logout", method: .delete, parameters: ["":""], encoder: JSONParameterEncoder.default, headers: header, interceptor: nil, requestModifier: nil).response { response in
            if let data = response.data {
                let jsonString = String(data: data, encoding: .utf8)
                print(jsonString ?? "No data")
                Session.shared.authToken = nil
            }
        }
        Session.shared.authToken = nil
    }
    
    static func getCurrentCustomer(_ callback: @escaping (Result<CustomerData>) -> Void) {
        guard let token = Session.shared.authToken else {
            callback(.failure(APIError.init(message: "Invalid token")))
            return
        }
        let header: HTTPHeaders = ["Authorization" : "Bearer " + token]
        AF.request("\(URLString)/customer/data", method: .get, headers: header).response { response in
            debugPrint(response)
            let result: Result<CustomerData> = handleResponse(response: response)
            callback(result)
        }
    }
}
