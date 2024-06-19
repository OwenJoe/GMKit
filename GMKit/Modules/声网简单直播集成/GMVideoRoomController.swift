//
//  GMVideoRoomController.swift
//  GMKit
//
//  Created by hule on 2024/6/18.
//  参考 https://doc.shengwang.cn/doc/rtc/ios/get-started/quick-start

import UIKit

//用户角色设置
enum VideoRoleType {
   case Broadcaster //主播
   case Audience  //观众
}


class GMVideoRoomController: GMBaseViewController {

    let masterUid = UInt(123456789) //房主ID
    let patronIID = UInt(888999666) //客人ID
    let roomid = "GMDemo"
    var profile:AgoraChannelProfile = .liveBroadcasting
    let appid = "378f8206974d4010a6ae06fb2dff4b3f"
    let token = "007eJxTYBBavDri2GGvLeGslcr6itMi+F5M9HWTm89jtZ/9lt+xdEkFBmNzizQLIwMzS3OTFBMDQ4NEs8RUA7O0JKOUtDSTJOO0u+ZFaQ2BjAwPtfKZGRkgEMRnY3D3dUnNzWdgAACV5Bz4"  //24小时内鉴权key会失效 需要重新配置
    // 本地视频视图
    var localView: UIView!
    // 远端视频视图
    var remoteView: UIView!
    // RTC 引擎
    var agoraKit: AgoraRtcEngineKit!

    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "声网简单直播demo集成"
        view.backgroundColor = .white
        localView = UIView(frame: UIScreen.main.bounds)
        //右上角视频
        remoteView = UIView(
            frame: CGRect(x: self.view.bounds.width - 135, y: 50, width: 135, height: 240))
        self.view.insertSubview(localView, at: 0)
        self.view.addSubview(remoteView)
        // 当加载视图后，你可以进行其他其他设置

    }
    
    //配置必要参数
    func setupConfig(type: VideoRoleType)  {
        // 在这里输入你在声网控制台中获取的 App ID
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId:appid, delegate: self)
        // 启用视频模块
        agoraKit.enableVideo()

        // 使用临时 Token 加入频道，在这里传入你的项目的 Token 和频道名
        // uid 为 0 表示由引擎内部随机生成; 成功后会触发 didJoinChannel 回调
        let options = AgoraRtcChannelMediaOptions()
        // 设置频道场景为直播
        options.channelProfile = .liveBroadcasting
        // 设置用户角色为主播；如果要将用户角色设置为观众，保持默认值即可
        if type == .Broadcaster {
            options.clientRoleType = .broadcaster  // 设置用户角色为主播
            // 发布麦克风采集的音频
            options.publishMicrophoneTrack = true
            // 发布摄像头采集的视频
            options.publishCameraTrack = true
            // 自动订阅所有音频流
            options.autoSubscribeAudio = true
            // 自动订阅所有视频流
            options.autoSubscribeVideo = true
        }
        else {
            options.clientRoleType = .audience  // 设置用户角色为观众
        }
        let result = agoraKit.joinChannel(byToken: token, channelId: roomid, uid: type == .Broadcaster ? masterUid : patronIID, mediaOptions: options)
        if result != 0 {
            self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
        } else {
            print("当前用户>>>>\(type == .Broadcaster ? masterUid : patronIID)成功加入频道")
            SVProgressHUD.showSuccess(withStatus: "当前用户>>>>\(type == .Broadcaster ? masterUid : patronIID)成功加入频道")
        }
    }
    
    
    //主播或者观众身份
    func setupRole(type: VideoRoleType){
       
        //主播
        if type == .Broadcaster {
            
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.view = localView
            videoCanvas.renderMode = .hidden
            // 设置本地视图
            agoraKit.setupLocalVideo(videoCanvas)
            // 开始本地视频预览
            agoraKit.startPreview()
//            agoraKit.setClientRole(.broadcaster, options: nil)
        }
        //观众
        else if type == .Audience {
            
            agoraKit.setupLocalVideo(nil)
//            let options = AgoraClientRoleOptions()
//            options.audienceLatencyLevel = .ultraLowLatency
//            agoraKit.setClientRole(.audience, options: options)
        }

        let option = AgoraRtcChannelMediaOptions()
        option.clientRoleType = type == .Broadcaster ? .broadcaster : .audience
        option.publishCameraTrack = type == .Broadcaster ? true : false
        option.publishMicrophoneTrack = type == .Broadcaster ? true : false
        agoraKit.updateChannel(with: option)
    }


    
    
    //销毁
    @IBAction func destroyVideo(_ sender: Any) {
        agoraKit.stopPreview()
        agoraKit.leaveChannel(nil)
    }
    
    //结束
    @IBAction func stopVideo(_ sender: Any) {
        AgoraRtcEngineKit.destroy()
    }
    
    
    //房主创建房间
    @IBAction func createVideoRoom(_ sender: Any) {
        setupConfig(type: .Broadcaster)
        setupRole(type: .Broadcaster)
    }
    
    //用户加入房间
    @IBAction func JoinVideoRoom(_ sender: Any) {
        
        setupConfig(type: .Audience)
        setupRole(type: .Audience)
    }
    
  
    //观众连麦 参考:https://doc.shengwang.cn/doc/showroom/ios/basic-features/integrate-showroom#%E8%A7%82%E4%BC%97%E8%BF%9E%E9%BA%A6
    @IBAction func AudienceConnection(_ sender: Any) {
        //无论是主播邀请连麦,还是观众发起请求连麦,都是观众身份切换为主播身份,下麦后又重新切回观众身份
        // set up local video to render your local camera preview
        self.setupRole(type: .Broadcaster)
        print("开始连麦")
        SVProgressHUD.showInfo(withStatus: "尝试准备开始连麦")
    }
    
    
    //观众下麦 下麦后又重新切回观众身份
    @IBAction func AudienceDrinking(_ sender: Any) {
        // 设置用户角色为观众
        print("下麦")
    }
}


///AgoraRtcEngineDelegate
extension GMVideoRoomController : AgoraRtcEngineDelegate {
    
    //发生错误回调
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccur errorType: AgoraEncryptionErrorType) {
        self.showAlert(title: "发生错误了", message: "didOccur: \(errorType), please check your params")
    }
    
    //远端用户（通信场景）/主播（直播场景）加入当前频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
//        self.showAlert(title: "Info", message: "有人加入了当前频道:didJoinedOfUid: \(uid)")
        print("有人加入了当前频道回调:didJoinedOfUid: \(uid)")
        // 当远端用户加入频道后，显示指定 uid 的远端视频流
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteView
        videoCanvas.renderMode = .hidden
        agoraKit.setupRemoteVideo(videoCanvas)
    }
    
    //成功加入频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        print("当前用户:\(uid)成功加入房间回调")
        print("didJoinChannel: \(channel), uid: \(uid)")

    }
    
    //远端用户（通信场景）/主播（直播场景）离开当前频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        print("当前用户:\(uid)离开频道回调")
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = nil
        agoraKit.setupRemoteVideo(videoCanvas)
    }
}


//弹窗提示
extension GMVideoRoomController {
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
