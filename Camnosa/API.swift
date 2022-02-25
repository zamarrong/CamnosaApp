//
//  API.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 06/07/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit
import Foundation
import SwiftHTTP

class API {
    lazy var config: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.config)
    let queryURL: URL
    typealias JSONCompletion = (JSON?) -> Void
    
    init(url: URL) {
        //print(url.absoluteString)
        self.queryURL = url
    }
    
    class func apiURL() -> String {
        return "http://www.camnosa.com/api"
    }
    
    func get(_ completion: @escaping JSONCompletion) {
        do {
            let opt = try HTTP.GET(queryURL.absoluteString)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                let json = JSON(data: response.data)
                completion(json)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
    func post(_ parameters: [String: AnyObject], completion: @escaping JSONCompletion) {
        do {
            let opt = try HTTP.POST(queryURL.absoluteString, parameters: parameters)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                let json = JSON(data: response.data)
                completion(json)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
}
