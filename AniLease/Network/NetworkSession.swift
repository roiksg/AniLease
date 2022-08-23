//
//  NetworkSession.swift
//  AniLease
//
//  Created by VironIT on 19.08.22.
//

import Foundation

class Network {
    private static let defaultSession = URLSession(configuration: .default)
    private static var dataTask: URLSessionDataTask?
    
    static func makeAnimeImage() {
        let createURl = "https://www.livechart.me/schedule/tv"
        guard let url = URL(string: createURl) else {return}
        
        dataTask = defaultSession.dataTask(with: url) {
            (data, response, error) in
            guard error == nil else {
                print("\n Error: \(error!.localizedDescription)")
                return
            }
            
            if response != nil {
                print("\n", response!.debugDescription)
            }
            if let url = URL(string: createURl) {
                do {
                    let contents = try String(contentsOf: url)
                    print(contents)
                } catch {
                    // contents could not be loaded
                }
            } else {
                // the URL was bad!
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                print(httpResponse.statusCode)
            }
            
            if data != nil {
            }
        }
        dataTask?.resume()
    }
}
