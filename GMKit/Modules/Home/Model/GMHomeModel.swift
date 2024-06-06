//
//  GMHomeModel.swift
//  GMKit
//
//  Created by hule on 2024/6/6.
//

enum HomeType: Codable {
    case defaultType //默认
}

struct GMHomeModel: Codable {
    
    var content: String?
    var type: HomeType?
}
