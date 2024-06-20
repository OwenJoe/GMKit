//
//  GMPKRoomController.swift
//  GMKit
//
//  Created by hule on 2024/6/20.
//  参考 https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_channel#joinChannelExByToken%20[2/2]

import UIKit

//用户角色设置
enum PKRoomRoleType {
   case Broadcaster //主播
   case Audience  //观众
}


class GMPKRoomController: GMBaseViewController {
    
    let masterUid_A = UInt(123456789) //主播A
    let masterUid_B = UInt(11112222) //主播A
    let patronIID_A = UInt(888999666) //客人A
    let patronIID_B = UInt(020202020) //客人B
    var profile:AgoraChannelProfile = .liveBroadcasting
    let appid = "378f8206974d4010a6ae06fb2dff4b3f"
    let roomid_A = "GMPK_A"
    let token_A = "007eJxTYBBS+BSu5i4yNaL4UXq0gnljFt+C74sO8TXJtcz4Ulj5MkyBwdjcIs3CyMDM0twkxcTA0CDRLDHVwCwtySglLc0kyTiN9UlxWkMgI8OFjnxmRgYIBPHZGNx9A7zjHRkYAO6dHj0="  //24小时内鉴权key会失效 需要重新配置
    let userAccount_A = "AAAAAA"
    let roomid_B = "GMPK_B"
    let token_B = "007eJxTYKjR0LNYJ/XOl3O1h96aIxwyX87eFv22wZWT+d+1u0c1D8soMBibW6RZGBmYWZqbpJgYGBokmiWmGpilJRmlpKWZJBmnpT8pTmsIZGTwUbzJxMgAgSA+G4O7b4B3vBMDAwAx+B7d"  //24小时内鉴权key会失效 需要重新配置
    let userAccount_B = "BBBBBB"
    // 本地视频视图
    var localView: UIView!
    // 远端视频视图
    var remoteView: UIView!
    // RTC 引擎
    var agoraKit: AgoraRtcEngineKit!
    // PK 的另外一个窗口
    var pkView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        localView = UIView(frame: UIScreen.main.bounds)
        //右上角视频
        remoteView = UIView(
            frame: CGRect(x: self.view.bounds.width - 135, y: 50, width: 135, height: 240))
        self.view.insertSubview(localView, at: 0)
        self.view.addSubview(remoteView)
        
        pkView = UIView(frame: CGRectMake(200, ScreenHeight - 135, 135, 240))
        pkView.backgroundColor = .orange
        self.view.addSubview(pkView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AgoraRtcEngineKit.destroy() //销毁
    }
    
    //配置必要参数
    func setupConfig(type: PKRoomRoleType, myUid: UInt)  {
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
        
        var roomid: String {
            if myUid == patronIID_A || myUid == masterUid_A {
                return roomid_A
            }
            return roomid_B
        }
        
        var token: String {
            if myUid == patronIID_A || myUid == masterUid_A {
                return roomid_A
            }
            return roomid_B
        }
        
        let result = agoraKit.joinChannel(byToken: token, channelId: roomid, uid: myUid, mediaOptions: options)
        if result != 0 {
            self.showAlert(title: "Error", message: "joinChannel call failed: \(result), please check your params")
        } else {
            print("当前用户>>>>\(myUid)成功加入频道")
            SVProgressHUD.showSuccess(withStatus: "当前用户>>>>\(myUid)成功加入频道")
        }
    }
    
    
    //主播或者观众身份
    func setupRole(type: PKRoomRoleType){
       
        //主播
        if type == .Broadcaster {
            
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.view = localView
            videoCanvas.renderMode = .hidden
            // 设置本地视图
            agoraKit.setupLocalVideo(videoCanvas)
            // 开始本地视频预览
            agoraKit.startPreview()
        }
        //观众
        else if type == .Audience {
            
            agoraKit.setupLocalVideo(nil)
        }

        let option = AgoraRtcChannelMediaOptions()
        option.clientRoleType = type == .Broadcaster ? .broadcaster : .audience
        option.publishCameraTrack = type == .Broadcaster ? true : false
        option.publishMicrophoneTrack = type == .Broadcaster ? true : false
        agoraKit.updateChannel(with: option)
    }

    /******************************************************************************************/
    //主播A开播
    @IBAction func anchor_A_Live(_ sender: Any) {
        navTitle = "主播A开播"
        setupConfig(type: .Broadcaster, myUid: masterUid_A)
        setupRole(type: .Broadcaster)
    }
    
    //主播A邀请主播B进行PK
    @IBAction func anchor_A_invite_B(_ sender: Any) {
        
        let channelOptions:AgoraRtcChannelMediaOptions = AgoraRtcChannelMediaOptions()
        agoraKit.joinChannelEx(byToken: token_B, channelId: roomid_B, userAccount: userAccount_B, delegate: nil, mediaOptions: channelOptions) { str, oneInt, twoInt in
            
            
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = self.masterUid_B
            videoCanvas.view = self.pkView
            videoCanvas.renderMode = .hidden
            self.agoraKit.setupRemoteVideo(videoCanvas)
        }

    }
    
    //主播A离开PK
    @IBAction func anchor_A_Leave(_ sender: Any) {
    }
    
    
    /******************************************************************************************/
    //主播B开播
    @IBAction func anchor_B_Live(_ sender: Any) {
        
        navTitle = "主播B开播"
        setupConfig(type: .Broadcaster, myUid: masterUid_B)
        setupRole(type: .Broadcaster)
    }
    
    //主播B接受主播A进行PK
    @IBAction func anchor_B_accept_A(_ sender: Any) {
        
        let channelOptions:AgoraRtcChannelMediaOptions = AgoraRtcChannelMediaOptions()
        agoraKit.joinChannelEx(byToken: token_A, channelId: roomid_A, userAccount: userAccount_A, delegate: nil, mediaOptions: channelOptions) { str, oneInt, twoInt in
            
            
            let videoCanvas = AgoraRtcVideoCanvas()
            videoCanvas.uid = self.masterUid_A
            videoCanvas.view = self.pkView
            videoCanvas.renderMode = .hidden
            self.agoraKit.setupRemoteVideo(videoCanvas)
        }
    }
    
    //主播B离开PK
    @IBAction func anchor_B_Leave(_ sender: Any) {
    }
    

    /******************************************************************************************/
    //观众A进入直播间
    @IBAction func audience_A_watch(_ sender: Any) {
        navTitle = "观众A进入直播间"
        setupConfig(type: .Audience,myUid: patronIID_A)
        setupRole(type: .Audience)
    }
    
    
    //观众B进入直播间
    @IBAction func audience_B_watch(_ sender: Any) {
        navTitle = "观众B进入直播间"
        setupConfig(type: .Audience,myUid: patronIID_B)
        setupRole(type: .Audience)
    }
}


///AgoraRtcEngineDelegate
extension GMPKRoomController : AgoraRtcEngineDelegate {
    
    //发生错误回调
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccur errorType: AgoraEncryptionErrorType) {
        self.showAlert(title: "发生错误了", message: "didOccur: \(errorType), please check your params")
    }
    
    //远端用户（通信场景）/主播（直播场景）加入当前频道回调。
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {

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
extension GMPKRoomController {
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
