//
//  GMAPIManager.swift
//  Gimme
//
//  Created by hule on 2024/6/3.
//



// 空响应类型，用于不需要解析特定模型的请求
struct EmptyResponse: Codable {}

// 自定义错误类型
enum GMAPIError: Error {
    case requestFailed(statusCode: Int)
    case invalidResponseCode(code: Int, message: String)
    case dataParsingError(description: String, message: String?)
    case networkError(description: String)
}



class GMAPIManager {
    static let shared = GMAPIManager()

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = defaultTimeout
        session = Session(configuration: configuration)
    }

    var baseURL: String = GMBaseUrl
    var defaultTimeout: TimeInterval = 30
    var defaultHeaders: HTTPHeaders = []
    var defaultMethod: HTTPMethod = .get

    private var session: Session

    func request<T: Codable>(path: String,
                             method: HTTPMethod? = nil,
                             parameters: Parameters? = nil,
                             headers: HTTPHeaders? = nil,
                             timeout: TimeInterval? = nil,
                             nestedKeys: [String]? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             completion: @escaping (Result<T, Error>) -> Void) {

        let fullURL = "\(baseURL)\(path)"

        let requestMethod = method ?? defaultMethod
        let requestHeaders = headers ?? defaultHeaders
        let requestParams = GMAPIManager.handleParams(dict: parameters)

        print("请求方法 -->: \(requestMethod.rawValue)")
        print("请求地址 -->: \(fullURL)")
        print("请求参数 -->: \(parameters ?? [:])")

        GMProgressHUD.show()

        session.request(fullURL, method: requestMethod, parameters: requestParams, encoding: encoding, headers: requestHeaders)
            .validate()
            .responseData { response in
                print("请求响应码 -->: \(response.response?.statusCode ?? 0)")

                switch response.result {
                case .success(let data):
                    print("请求成功 -->: \(String(data: data, encoding: .utf8) ?? "No data")")

                    do {
                        // 尝试从原始 data 中提取 message 字段
                        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let code = jsonObject["code"] as? Int,
                           let message = jsonObject["message"] as? String {
                            // 检查 code 字段
                            if code == 200 {
                                let decodedObject: T
                                if let keys = nestedKeys {
                                    var nestedJsonObject = jsonObject
                                    for key in keys {
                                        if let nestedObject = nestedJsonObject[key] as? [String: Any] {
                                            nestedJsonObject = nestedObject
                                        } else if let nestedArray = nestedJsonObject[key] {
                                            let nestedData = try JSONSerialization.data(withJSONObject: nestedArray, options: [])
                                            decodedObject = try JSONDecoder().decode(T.self, from: nestedData)
                                            completion(.success(decodedObject))
                                            GMProgressHUD.dismiss()
                                            return
                                        } else {
                                            throw GMAPIError.dataParsingError(description: "找不到键路径中的键：\(key)", message: message)
                                        }
                                    }
                                    let finalData = try JSONSerialization.data(withJSONObject: nestedJsonObject, options: [])
                                    decodedObject = try JSONDecoder().decode(T.self, from: finalData)
                                } else {
                                    decodedObject = try JSONDecoder().decode(T.self, from: data)
                                }
                                completion(.success(decodedObject))
                                GMProgressHUD.dismiss()
                            } else {
                                // code 不是 200，创建并传递 invalidResponseCode 错误
                                let error = GMAPIError.invalidResponseCode(code: code, message: message)
                                completion(.failure(error))
                                GMProgressHUD.showError("请求失败:\(message)") //请求失败：
                            }
                        } else {
                            throw GMAPIError.dataParsingError(description: "Invalid JSON format", message: nil)
                        }

                    } catch {
                        // 捕获解析 JSON 时的错误
                        if let jsonString = String(data: data, encoding: .utf8) {
                            var cleanedString = jsonString
                            // 移除转义字符
                            cleanedString = cleanedString.replacingOccurrences(of: "\\", with: "")
                            // 移除多余的引号
                            if cleanedString.hasPrefix("\"") && cleanedString.hasSuffix("\"") {
                                cleanedString.removeFirst()
                                cleanedString.removeLast()
                            }
                            
                            var message: String? = nil
                            
                            // 尝试从处理后的字符串中提取 message 字段
                            if let jsonData = cleanedString.data(using: .utf8),
                               let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                message = jsonObject["message"] as? String
                            }
                            
                            let parsingError = GMAPIError.dataParsingError(description: error.localizedDescription, message: message)
                            completion(.failure(parsingError))
                            GMProgressHUD.showError("\(message ?? error.localizedDescription)")//数据解析失败：
                        } else {
                            let parsingError = GMAPIError.dataParsingError(description: error.localizedDescription, message: nil)
                            completion(.failure(parsingError))
                            GMProgressHUD.showError("\(error.localizedDescription)")//数据解析失败：
                        }
                    }

                case .failure(let error):
                    // 网络请求失败，创建并传递 networkError 错误
                    let networkError = GMAPIError.networkError(description: error.localizedDescription)
                    completion(.failure(networkError))
                    GMProgressHUD.showError("\(error.localizedDescription)") //网络错误：
                }
            }
    }
}


extension GMAPIManager {
    //两个字典合并,并返回一个新的
    static func handleParams(dict: [String: Any]?) -> [String: Any] {
        let cashDict = [String: Any]()
        // 如果 dict 是 nil，则直接返回 cashDict
        guard let dict = dict else {
            return cashDict
        }
        // 合并两个字典，并在发生键冲突时选择 dict 中的值
        return cashDict.merging(dict){(_, new) in new}
     }
}
