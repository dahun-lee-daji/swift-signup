//
//  NetworkManager.swift
//  SignUp
//
//  Created by 이다훈 on 2021/03/30.
//

import Foundation
class NetworkManager {
    private let url = URL.init(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp")
    
    func getUserList(closure : @escaping ([String]?) -> Void) {
        var request = URLRequest(url: self.url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) in
            let decoder = try? JSONSerialization.jsonObject(with: data!, options: []) as? Array<String>
            guard let userList = decoder?.compactMap({$0}) else { return }
            
            closure(userList)
        }).resume()
    }
    
    func postUser(userInfo : UserInformation) {
        let sendData = try? JSONEncoder().encode(userInfo)
        var request = URLRequest(url: self.url!)
        request.httpMethod = "POST"
        request.httpBody = sendData
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,error) in
            let decoder = try? JSONDecoder().decode(NetworkResponse.self, from: data!)
            guard let returnData = decoder else {
                return
            }
            // 필요한 내용 하단에 구현
        }).resume()
    }
}

struct NetworkResponse : Codable {
    var result : String
    var status : String
}
