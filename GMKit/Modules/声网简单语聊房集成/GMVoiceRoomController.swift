//
//  GMVoiceRoomController.swift
//  GMKit
//
//  Created by hule on 2024/6/18.
//

// 参考链接  https://blog.csdn.net/agora_cloud/article/details/130828327

import UIKit

//用户角色设置
enum VoiceRoleType {
   case Broadcaster //主播
   case Audience  //观众
}

class GMVoiceRoomController: GMBaseViewController, UICollectionViewDelegate {
    // 初始化操作
    var agoraKit : AgoraRtcEngineKit!
    //初始化 参数配置:https://console.shengwang.cn/overview?_gl=1*d0e3a8*_gcl_au*ODg0Njk3NjcwLjE3MTQxMjg3NTU.*_ga*MTA5OTcwMDE0NC4xNzE0MTI4NzIw*_ga_BFVGG7E02W*MTcxODY5MDg5NS4xNS4xLjE3MTg2OTEyNDMuMC4wLjA.
    let appid = "378f8206974d4010a6ae06fb2dff4b3f"
    let token = "007eJxTYHjb2P152rEEg/ClE8+nTelq3ts1e6dpYNvDrPDEiQzCWe4KDMbmFmkWRgZmluYmKSYGhgaJZompBmZpSUYpaWkmScZp53QL0xoCGRkO7wpmYmSAQBCfi8HdNyw/MzkoPz+XgQEAYrUiVA=="  //24小时内鉴权key会失效 需要重新配置
    let masterUid = 123456789 //房主ID
    let patronIID = 000000000 //客人ID
    let roomid = "GMVoicRoom"
    var profile:AgoraChannelProfile = .liveBroadcasting


    //展示用户列表
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navTitle = "声网语聊房demo测试"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        agoraKit.leaveChannel()
    }
    

    //配置房间的一些参数
    func setupConfig(uid: Int, type: VoiceRoleType)  {
        // 初始化AgoraRtcEngineKit，可加入自定义配置，比如加入频道是否开启麦克风、摄像头等。
        let config = AgoraRtcEngineConfig()
        config.appId = appid
        config.channelProfile = profile // 设置频道模式
        agoraKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
        agoraKit.enableAudio() // 启用音频
        agoraKit.disableVideo()  // 禁用视频
        agoraKit.enableAudioVolumeIndication(200, smooth: 3, reportVad: true)  // 启用音量提示
        
        // 默认加入频道即发送音频，不发送视频
        let option = AgoraRtcChannelMediaOptions()
        option.publishCameraTrack = false  // 禁用摄像头
        if type == .Broadcaster {
            option.clientRoleType = .broadcaster  // 设置用户角色为主播
            option.publishMicrophoneTrack = true  // 启用麦克风
//            option.enableAudioRecordingOrPlayout = true  // 启用音频录制或播放
        }
        else {
            //观众只是进入房间无需立马启用麦克风或者启用音频录制或者播放
            option.clientRoleType = .audience  // 设置用户角色为观众
        }
        
        option.autoSubscribeAudio = true  // 自动订阅音频
        let result = agoraKit.joinChannel(byToken: token, channelId: roomid, uid: UInt(uid), mediaOptions: option)
        if result != 0 {
            self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
        } else {
            print("当前用户>>>>\(uid)成功加入频道")
            SVProgressHUD.showSuccess(withStatus: "当前用户>>>>\(uid)成功加入频道")
        }
    }
    
    //房主创建房间
    @IBAction func createVoiceRoom(_ sender: Any) {
        
        setupConfig(uid: masterUid, type: .Broadcaster)
    }
    
    //用户加入房间
    @IBAction func JoinVoiceRoom(_ sender: Any) {
        
        setupConfig(uid: patronIID, type: .Audience)
    }
    
    //打开麦克风
    @IBAction func openMic(_ sender: UIButton) {
        agoraKit.muteLocalAudioStream(false)
    }
    
    //关闭麦克风
    @IBAction func closeMic(_ sender: UIButton) {
        agoraKit.muteLocalAudioStream(true)
    }
    
    //离开房间
    @IBAction func leaceRoom(_ sender: Any) {
        agoraKit.leaveChannel()
        print("离开了房间")
    }
    
    //观众连麦 参考:https://doc.shengwang.cn/doc/showroom/ios/basic-features/integrate-showroom#%E8%A7%82%E4%BC%97%E8%BF%9E%E9%BA%A6
    @IBAction func AudienceConnection(_ sender: Any) {
        //无论是主播邀请连麦,还是观众发起请求连麦,都是观众身份切换为主播身份,下麦后又重新切回观众身份
//        agoraKit.setClientRole(.broadcaster)
        print("开始连麦")
    }
    
    
    //观众下麦 下麦后又重新切回观众身份
    @IBAction func AudienceDrinking(_ sender: Any) {
        
//        agoraKit.setClientRole(.audience)
        print("下麦,切回普通身份")
    }
}


///AgoraRtcEngineDelegate
///相关API预览: https://doc.shengwang.cn/api-ref/rtc/ios/API/rtc_api_overview
extension GMVoiceRoomController : AgoraRtcEngineDelegate {
    
    //发生错误回调
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccur errorType: AgoraEncryptionErrorType) {
        self.showAlert(title: "Error", message: "didOccur: \(errorType), please check your params")
    }
    
    //远端用户（通信场景）/主播（直播场景）加入当前频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        self.showAlert(title: "Info", message: "有人加入了当前频道:didJoinedOfUid: \(uid)")
    }
    
    //成功加入频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
       print("当前用户:\(uid)成功加入房间回调")

    }
    
    //远端用户（通信场景）/主播（直播场景）离开当前频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        print("当前用户:\(uid)离开频道回调")
    }
}


//弹窗提示
extension GMVoiceRoomController {
    //弹窗提示
    func showAlert(title: String? = nil, message: String, textAlignment: NSTextAlignment = .center) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        if let messageLabel = alertController.view.value(forKeyPath: "_messageLabel") as? UILabel {
            messageLabel.textAlignment = textAlignment
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
