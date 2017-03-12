//
//  WebServiceRequest.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-16.
//  Copyright (c) 2017 School of ICT, Seneca College. All rights reserved.
//

import UIKit

protocol WebServiceRequestDelegate : class {
    func webServiceRequestDidChangeContent(model: Model)
}

class WebServiceRequest {
    
    // MARK: - Properties
    
    var urlBase = "https://ict.senecacollege.ca/api"
    var httpMethod = "GET"
    var headerAccept = "application/json"
    var headerContentType = "application/json"
    
    // MARK: - Public methods

    func sendRequest(toUrlPath urlPath: String, dataKeyName: String?, completion: @escaping ([AnyObject])->Void) {
        
        // Assemble the URL
        guard let url = URL(string: "\(urlBase)\(urlPath)") else {
            print("Failed to construct url with \(urlBase)\(urlPath)")
            return
        }
        
        // Diagnostic
        print(url.description)

        // Create a session configuration object
        let sessionConfig = URLSessionConfiguration.default

        // Create a session object
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: OperationQueue.main)

        // ^^^ Beware: there is a `URLSession.shared` available, this will respond off the main thread.
        // This URLSession uses OperationQueue.main, which directs it to callback on the main thread only.


        // Create a request object
        let request = NSMutableURLRequest(url: url)

        // Set its important properties
        request.httpMethod = httpMethod
        request.setValue(headerAccept, forHTTPHeaderField: "Accept")

        // Define a network task; after it's created, it's in a "suspended" state
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                print("Task request error: \(error.localizedDescription)")
            } else if let data = data {
                // FYI, show some details about the response
                // This code is interesting during development, but you would not leave it in production/deployed code
                let r = response as? HTTPURLResponse
                print("Response data...\nStatus code: \(r?.statusCode)\nHeaders:\n\(r?.allHeaderFields.description)")

                var results: Any! = nil
                // Attempt to deserialize the data from the response
                do {
                    results = try JSONSerialization.jsonObject(with: data)
                } catch {
                    print("json error: \(error.localizedDescription)")
                    return
                }

                // The request was successful, and deserialization was successful.

                if let dataKeyName = dataKeyName {
                    // Therefore, extract the data we want from the dictionary, and call the completion callback.
                    // This version of the code works only with
                    // top/first level key-value pairs in the source JSON data
                    if let resultDict = results as? NSDictionary, let extractedData = resultDict[dataKeyName] as? [AnyObject] {
                        completion(extractedData)
                    } else {
                        print("Error extracting from json dict for key \(dataKeyName)")
                    }
                } else {
                    completion(results as! [AnyObject])
                }
            } else {
                let r = response as? HTTPURLResponse
                print("No data!\nStatus code: \(r?.statusCode)\nHeaders:\n\(r?.allHeaderFields.description)")
            }
            
            // Finally, reference the app's network activity indicator in the status bar
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })

        // Force the task to execute
        task.resume()

        // Reference the app's network activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}
