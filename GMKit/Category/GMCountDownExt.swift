//
//  GMCountDownExt.swift
//  Gimmi
//
//  Created by hule on 2024/4/28.
//

import Dispatch

extension DispatchQueue {
    private static var countdownTimerKey = "countdownTimerKey"
    private static var countdownSecondsKey = "countdownSecondsKey"

    func startCountdown(seconds: Int, completion: @escaping (Int) -> Void) {
        var timeLeft = seconds
        
        let timer = DispatchSource.makeTimerSource()
        
        timer.setEventHandler { [weak self] in
            guard let self = self else {
                return
            }
            
            if timeLeft > 0 {
                self.setCountdownSeconds(timeLeft)
                timeLeft -= 1
                completion(timeLeft)
            } else {
                self.cancelCountdown()
                completion(0)
            }
        }
        
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.resume()
        
        // 存储计时器和秒数到队列关联对象，以便后续取消和获取
        objc_setAssociatedObject(self, &DispatchQueue.countdownTimerKey, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &DispatchQueue.countdownSecondsKey, timeLeft, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func cancelCountdown() {
        if let timer = objc_getAssociatedObject(self, &DispatchQueue.countdownTimerKey) as? DispatchSourceTimer {
            timer.cancel()
            
            // 移除队列关联对象
            objc_setAssociatedObject(self, &DispatchQueue.countdownTimerKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &DispatchQueue.countdownSecondsKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func getCountdownSeconds() -> Int {
        return objc_getAssociatedObject(self, &DispatchQueue.countdownSecondsKey) as? Int ?? 0
    }
    
    private func setCountdownSeconds(_ seconds: Int) {
        objc_setAssociatedObject(self, &DispatchQueue.countdownSecondsKey, seconds, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
