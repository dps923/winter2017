//
//  WebServiceRequest.swift
//  Classes
//
//  Created by Peter McIntyre on 2015-02-16.
//  Copyright (c) 2015 School of ICT, Seneca College. All rights reserved.
//

import UIKit

#if ADDITIONAL_NETWORK_FUNCTIONS

class WebServiceRequest {
    
    // MARK: - Properties
    
    var urlBase: String?
    //var urlPath: String?
    var httpMethod: String?
    var headerAccept: String?
    var headerContentType: String?
    var headerAuthorization: String?
    var messageBody: AnyObject?
    
    // MARK: - Public methods
    
    func sendRequestToUrlPath(_ urlPath: String, forDataKeyName dataKeyName: String, from sender: AnyObject, propertyNamed propertyName: String) {
        
        // Assemble the URL
        let url = URL(string: "\(urlBase!)\(urlPath)")
        
        // Diagnostic
        print(url?.description)

        // Create a session configuration object
        let sessionConfig = URLSessionConfiguration.default
        
        // Create a session object
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
        
        // Create a request object
        let request = NSMutableURLRequest(url: url!)

        // Set its important properties
        request.httpMethod = httpMethod!
        request.setValue(headerAccept, forHTTPHeaderField: "Accept")

        // If a message body was configured...
        if let mb: AnyObject = messageBody {
            var error: NSError? = nil
            let message = JSONSerialization.dataWithJSONObject(mb, options: nil, error: &error)
            
            if error != nil {
                print("Error creating message body: \(error?.description)")
            }
            request.HTTPBody = message
        }

        // Reference the app's network activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Define a network task; after it's created, it's in a "suspended" state
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if let error = error {
                print("Task request error: \(error.description)")
            } else {
                // FYI, show some details about the response
                // This code is interesting during development, but you would not leave it in production/deployed code
                let r: HTTPURLResponse = response as HTTPURLResponse
                print("Response data...\nStatus code: \(r.statusCode)\nHeaders:\n\(r.allHeaderFields.description)")
                
                // Attempt to deserialize the data from the response
                var jsonError: NSError? = nil
                let results: AnyObject? = JSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError)
                
                if let jsonError = jsonError {
                    print("Task request error: \(jsonError.description)")
                } else {
                    // The request was successful, and deserialization was successful
                    // Therefore, extract the data we want from the dictionary
                    // and assign it to the passed-in property
                    // This version of the code works only with
                    // top/first level key-value pairs in the source JSON data
                    sender.setValue((results as NSDictionary)[dataKeyName], forKey: propertyName)
                }

                // Next, post a notification for interested listeners
                let completed = "\(sender.name)_\(propertyName)_fetch_completed"
                
                // Diagnostic
                print(completed)
                
                NotificationCenter.defaultCenter().postNotificationName(completed, object: nil)
            }
            
            // Finally, reference the app's network activity indicator in the status bar
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        })

        // Force the task to execute
        task.resume()
    }
    
    
    init() {
        // Initial values
        urlBase = "http://dps907fall2013.azurewebsites.net/api"
        httpMethod = "GET"
        headerAccept = "application/json"
        headerContentType = headerAccept
    }
}

#endif
