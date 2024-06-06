//
//  GMStringExt.swift
//  Gimme
//
//  Created by hule on 2024/5/14.
//

import UIKit
import CommonCrypto

enum DESStringOperateType {
    
    /// 加密
    case encryption
    /// 解密
    case decrypt
    
    /// CCOperation 类型
    var operation: CCOperation {
        switch self {
        case .encryption: return CCOperation(kCCEncrypt)
        case .decrypt:    return CCOperation(kCCDecrypt)
        }
    }
}

extension String {

    //TODO: URL编码
    func encodeEscapesURL() -> String {
        let string = self
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: "!*'();:@&=+ $,/?%#[]")
        return self.addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey) ?? string
    }

    
    
    /// 表情 加密解密
    func dataFaceDES(processType: DESStringOperateType, key: String) -> String {
        
        return crypt(operation: processType.operation, key: key) ?? ""
    }
    
    /// svga 加密解密
//    func dataSvgaDES(processType: DESStringOperateType, key: Const = .SVGA_KEY) -> String {
//        if contains("http") || contains("https") {
//            return self
//        }
//        return crypt(operation: processType.operation, key: key.rawValue) ?? ""
//    }
    
    private func crypt(operation:CCOperation, key: String) -> String? {
        
        if let keyData = key.data(using: .utf8) {
            
            var cryptData: Data?
            
            if operation == kCCEncrypt {
                cryptData = self.data(using: .utf8)
            } else {
                cryptData = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
            }
            
            guard let crypt = cryptData else {
                return nil
            }
            
            let algoritm: CCAlgorithm = CCAlgorithm(kCCAlgorithmDES)
            let option: CCOptions = CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode)
            
            let keyBytes = [UInt8](keyData)
            let keyLength = kCCKeySizeDES
            
            
            let dataIn = [UInt8](crypt)
            let dataInlength = crypt.count
            
            let dataOutAvailable = Int(dataInlength + kCCBlockSizeDES)
            let dataOut = UnsafeMutablePointer<UInt32>.allocate(capacity: dataOutAvailable)
            let dataOutMoved = UnsafeMutablePointer<Int>.allocate(capacity: 1)
            
            dataOutMoved.initialize(to: 0)
            
            let cryptStatus = CCCrypt(operation, algoritm, option, keyBytes, keyLength, keyBytes, dataIn, dataInlength, dataOut, dataOutAvailable, dataOutMoved)
            
            guard CCStatus(cryptStatus) == CCStatus(kCCSuccess) else {
                dataOutMoved.deallocate()
                dataOut.deallocate()
                return nil
            }
            var data: Data =  Data(bytesNoCopy: dataOut, count: dataOutMoved.pointee, deallocator: .none)
            
            if operation == kCCEncrypt {
                data = data.base64EncodedData(options: .lineLength64Characters)
            }
            let dataStr = String(data: Data(data), encoding: .utf8)
            /// 摧毁指针最后执行
            dataOutMoved.deallocate()
            dataOut.deallocate()
            return dataStr
        }
        
        return nil
    }
}


