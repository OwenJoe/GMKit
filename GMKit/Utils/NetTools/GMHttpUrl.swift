//
//  GMHttpUrl.swift
//  Gimmi
//
//  Created by hule on 2024/4/25.
//

import Foundation

// 新闻套壳测试
//x 新闻基本路由
let NewsUrl = "https://newsdata.io/api/1"    //"https://newsapi.org/v2"
//新闻搜索
let NewsSearchUrl =  NewsUrl +  "/latest" //NewsUrl + "/everything"    //不要在末尾添加? ,否则请求报错
//新闻国家 && 机构
let NewsHeadLinesUrl = NewsUrl + "/top-headlines"
//key
let NewsApiKey = "pub_45271532986a13b78df005e1d3ac401281abe" //"89b5847d607144489f708429daab46e0"


//根据环境判断,测试环境参数不需要加密,正式环境需要AES加密,请求到的结果还要AES解密
//真实URL
let GMProApiUrl = "https://www.gimmelive.net"
//测试URL
let GMTestApiUrl = "http://47.119.173.119"
//H5 真实url
let GMProH5Url = "https://res.gimmelive.net"
//H5 测试url
let GMTestH5Url = "http://47.119.173.119"

var GMBaseUrl: String = ""
var GMH5Url: String = ""




//国家地区请求
let CountryUrl = "/client/country"



