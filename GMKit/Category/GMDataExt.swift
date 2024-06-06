//
//  GMDataExt.swift
//  Gimme
//
//  Created by hule on 2024/5/14.
//
import Foundation
import CommonCrypto

extension Data {
    
    //AES加密
    func jx_AES256Encrypt(withKey key: Data, iv: Data) -> Data? {
        return self._jx_crypt(operation: CCOperation(kCCEncrypt), algorithm: CCAlgorithm(kCCAlgorithmAES128), key: key, iv: iv)
    }
    
    //AES具体加密方法
    private func _jx_crypt(operation: CCOperation, algorithm: CCAlgorithm, key: Data, iv: Data) -> Data? {
        var blockSize: Int = 0
        var options: CCOptions = 0
        
        switch algorithm {
        case UInt32(kCCAlgorithmAES128):
            guard [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256].contains(key.count), iv.count == kCCBlockSizeAES128 || iv.isEmpty else {
                return nil
            }
            blockSize = kCCBlockSizeAES128
            options = CCOptions(kCCOptionPKCS7Padding)
            
        case UInt32(kCCAlgorithmDES):
            guard key.count == kCCKeySizeDES, iv.count == kCCBlockSizeDES || iv.isEmpty else {
                return nil
            }
            blockSize = kCCBlockSizeDES
            options = CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode)
            
        case UInt32(kCCAlgorithm3DES):
            guard key.count == kCCKeySize3DES, iv.count == kCCBlockSize3DES || iv.isEmpty else {
                return nil
            }
            blockSize = kCCBlockSize3DES
            options = CCOptions(kCCOptionPKCS7Padding)
            
        default:
            return nil
        }
        
        let bufferSize = self.count + blockSize
        var buffer = Data(count: bufferSize)
        var numBytesCrypted: size_t = 0
        
        let status = buffer.withUnsafeMutableBytes { bufferBytes in
            self.withUnsafeBytes { dataBytes in
                key.withUnsafeBytes { keyBytes in
                    iv.withUnsafeBytes { ivBytes in
                        CCCrypt(operation,
                                algorithm,
                                options,
                                keyBytes.baseAddress,
                                key.count,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress,
                                self.count,
                                bufferBytes.baseAddress,
                                bufferSize,
                                &numBytesCrypted)
                    }
                }
            }
        }
        
        guard status == kCCSuccess else {
            return nil
        }
        
        return buffer[..<numBytesCrypted]
    }
    
    
    
    /*****AES解密*****/
    func jx_AES256Decrypt(withKey key: Data, iv: Data) -> Data? {
        return self._jx_decrypt(operation: CCOperation(kCCDecrypt), algorithm: CCAlgorithm(kCCAlgorithmAES128), key: key, iv: iv)
    }

    // AES具体解密方法
    private func _jx_decrypt(operation: CCOperation, algorithm: CCAlgorithm, key: Data, iv: Data) -> Data? {
        var blockSize: Int = 0
        var options: CCOptions = 0
        
        switch algorithm {
        case UInt32(kCCAlgorithmAES128):
            guard [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256].contains(key.count), iv.count == kCCBlockSizeAES128 || iv.isEmpty else {
                return nil
            }
            blockSize = kCCBlockSizeAES128
            options = CCOptions(kCCOptionPKCS7Padding)
            
        case UInt32(kCCAlgorithmDES):
            guard key.count == kCCKeySizeDES, iv.count == kCCBlockSizeDES || iv.isEmpty else {
                return nil
            }
            blockSize = kCCBlockSizeDES
            options = CCOptions(kCCOptionPKCS7Padding | kCCOptionECBMode)
            
        case UInt32(kCCAlgorithm3DES):
            guard key.count == kCCKeySize3DES, iv.count == kCCBlockSize3DES || iv.isEmpty else {
                return nil
            }
            blockSize = kCCBlockSize3DES
            options = CCOptions(kCCOptionPKCS7Padding)
            
        default:
            return nil
        }
        
        let bufferSize = self.count + blockSize
        var buffer = Data(count: bufferSize)
        var numBytesCrypted: size_t = 0
        
        let status = buffer.withUnsafeMutableBytes { bufferBytes in
            self.withUnsafeBytes { dataBytes in
                key.withUnsafeBytes { keyBytes in
                    iv.withUnsafeBytes { ivBytes in
                        CCCrypt(operation,
                                algorithm,
                                options,
                                keyBytes.baseAddress,
                                key.count,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress,
                                self.count,
                                bufferBytes.baseAddress,
                                bufferSize,
                                &numBytesCrypted)
                    }
                }
            }
        }
        
        guard status == kCCSuccess else {
            return nil
        }
        
        return buffer[..<numBytesCrypted]
    }


}
