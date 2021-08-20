//
//  LinkToken.swift
//  Example for PinwheelSDK
//
//  Created by Robby Abaya on 11/16/20.
//

import Foundation

class LinkToken {
    var delegate: LinkTokenDelegate?
    var linkToken: String?
    var isLoaded = false;
    
    func fetchTokenWithAttributes(_ attributes: LinkTokenAttributes) {
        guard let url = URL(string: "https://sandbox.getpinwheel.com/v1/link_tokens") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(attributes)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(apiSecret, forHTTPHeaderField: "X-API-SECRET")
            
            URLSession.shared.dataTask(with: request) { apiData, response, error in
                if let error = error {
                    print("there was an error")
                    print(error)
                }
                guard let data = apiData else {
                    print("No data")
                    return;
                }
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        // TODO: fix the modal not showing up on the first load
                        self.linkToken = decodedResponse.data.token
                        self.isLoaded = true
                        
                        if let d = self.delegate {
                            d.onComplete(linkToken: decodedResponse.data.token)
                        }
                    }
                }
            }.resume()
        } catch { print(error) }
        
    }
}

struct ResponseData: Codable {
    var token: String
}

struct Response: Codable {
    var data: ResponseData
}

struct LinkTokenAttributes: Codable {
    var account_number: String?
    var account_type: String?
    var job: String?
    var mode: String?
    var org_name: String?
    var routing_number: String?
    var skip_exit_survey: Bool?
    var skip_intro_screen: Bool?
}

protocol LinkTokenDelegate {
    func onComplete(linkToken: String)
}
