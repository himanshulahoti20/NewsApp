//
//  Networking.swift
//  News
//
//  Created by Himanshu Lahoti on 08/07/22.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol FetchDataDelegate{
    func reloadData(newsArray : [NewsModel])
}
struct Networking {
    var delegate : FetchDataDelegate?
    
    func getNewsData(complete: @escaping (_ status: Bool) -> ()) {
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=157e2062a9be47d7855341cd01ff1f6b", method: .get).responseData { (response) in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(NewsModel.self, from: data)
                
                self.delegate?.reloadData(newsArray: [decodedData])
                complete(true)
            } catch let error {
                print(error)
            }
        }
    }
}

