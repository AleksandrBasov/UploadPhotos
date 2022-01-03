//
//  NetworkManager.swift
//  Photo
//
//  Created by Александр Басов on 1/1/22.
//

import UIKit

class NetworkManager {
    
    init() { }
    
    static let shared = NetworkManager()
    
    let session = URLSession(configuration: .default)
    

    func getPhoto(url: String?, onSuccess: @escaping (UIImage?) -> Void, onError: @escaping (String) -> Void) {
        
        guard let url = URL(string: url ?? "") else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    onError("Invalid data or response")
                    return
                }
                
                let image = UIImage(data: data)
                onSuccess(image)
       
            }
        }
        task.resume()
    }
}
