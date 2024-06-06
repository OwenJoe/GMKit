//
//  GMChatModel.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit
enum OperatorType: Codable {
    case other  //其他人
    case mySelf   //自己
}

class GMChatModel: Codable {
    
    var recent:String? = "" //下方小字提示内容
    var messageCount: Int? = 0
    var time: String? = "2024-01-01"
    var pic: String?
    var name: String?
    var content: String?
    var type: OperatorType?
    
    init() {
        
    }
    
    class func initModel(recent: String?, messageCount: Int? , time:String?, pic: String? , name: String? ,content: String? ,type:OperatorType? ) -> GMChatModel {
        
         let model = GMChatModel()
        model.recent = recent
        model.messageCount = messageCount
        model.time = time
        model.pic = pic
        model.name = name
        model.content = content
        model.type = type
        return model
    }
}
