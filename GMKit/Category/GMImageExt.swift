//
//  GMImageExt.swift
//  Gimmi
//
//  Created by hule on 2024/4/28.
//

import UIKit

extension UIImage {

    //图片转颜色
    func averageColor() -> UIColor? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height
        
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        
        let imageData = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height * bytesPerPixel)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        guard let context = CGContext(data: imageData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var totalR: CGFloat = 0
        var totalG: CGFloat = 0
        var totalB: CGFloat = 0
        
        for y in 0..<height {
            for x in 0..<width {
                let byteIndex = (bytesPerRow * y) + (bytesPerPixel * x)
                let red = CGFloat(imageData[byteIndex]) / 255.0
                let green = CGFloat(imageData[byteIndex + 1]) / 255.0
                let blue = CGFloat(imageData[byteIndex + 2]) / 255.0
                
                totalR += red
                totalG += green
                totalB += blue
            }
        }
        
        let pixelCount = CGFloat(width * height)
        let averageR = totalR / pixelCount
        let averageG = totalG / pixelCount
        let averageB = totalB / pixelCount
        
        imageData.deallocate()
        
        return UIColor(red: averageR, green: averageG, blue: averageB, alpha: 1.0)
    }
    
    
    //传入图片数组名称,随机返回任意一张图片
    static func randomImage(from imageNames: [String]) -> UIImage? {
        guard !imageNames.isEmpty else {
            return UIImage(named: "placeholder-01")
        }
        
        let randomIndex = Int.random(in: 0..<imageNames.count)
        return UIImage(named: imageNames[randomIndex])
    }
}


//对图片从中间两边拉伸
extension UIImage {
    /// 创建一个将图片中间部分拉伸而其他部分保持不变的图片
    /// - Returns: 拉伸后的图片
    func stretchableImage() -> UIImage {
        let width = self.size.width
        let height = self.size.height
        
        // 指定拉伸区域的边距，确保中间部分被拉伸，其余部分保持不变
        let capInsets = UIEdgeInsets(top: height / 2 - 1, left: width / 2 - 1, bottom: height / 2, right: width / 2)
        
        // 创建并返回拉伸后的图片
        return self.resizableImage(withCapInsets: capInsets, resizingMode: .stretch)
    }
}
