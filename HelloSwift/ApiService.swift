//
//  ApiService.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 08/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import Foundation
import Alamofire


class ApiService<T : Codable> {
    var router: String = "";
    var method: HTTPMethod = .get
    var parameters: [String: Any]? = nil
    var request: DataRequest? = nil

    public init(){}
   
    var domain: String {
        return "http://192.168.8.109:8080"
    }
    
    public func post(_ action: String, parameters: [String: Any]? = nil) -> Self {
        
         let url = "\(domain)/\(action)"
        
        self.method = .post
        self.parameters = parameters;
        self.router = action;
        
        typealias T = AccessToken;
    
         self.request = Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default)
        return self;
    }
    
    public func get(_ action: String, parameters: [String: Any]? = nil) -> Self {
        
          let url = "\(domain)/\(action)"
        
        self.method = .get
        self.parameters = parameters;
        self.router = action;
        
         self.request = Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default)
        
        return self;
    }
    
    public func authenticate() -> Self {
        self.request = request?.authenticate(user: "test-client", password: "secret");
        return self;
    }
    
    public func token(_ accessToken : String) -> Self {
        
         let url = "\(domain)/\(router)"
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
        ]
        self.request = Alamofire.request(url, method: self.method, parameters: self.parameters,encoding: URLEncoding.default, headers: headers)
        return self;
    }
    
    // T is used in DataResponse<T>
    public func call(completionHandler: @escaping (DataResponse<T>) -> Void) {
        request?.responseDecodable(completionHandler: completionHandler)
    }
}



// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
          
            let apiResponse =  Result { try JSONDecoder().decode(T.self, from: data) }
            
            print("\n\nApi Response\n___________________________\n\n")
            debugPrint(apiResponse.value ?? "empty")
            print("___________________________\n\n")
            return apiResponse;
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let apiRequest =  response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
        print("\n\nApi Request\n___________________________\n\n")
        debugPrint(apiRequest)
         print("___________________________\n\n")
        
        return apiRequest;
    }
   
}
