//
//  GMPKRoomController.swift
//  GMKit
//
//  Created by hule on 2024/6/20.
//

import UIKit

class GMPKRoomController: GMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //主播A开播
    @IBAction func anchor_A_Live(_ sender: Any) {
        navTitle = "主播A开播"
    }
    
    //主播A邀请主播B进行PK
    @IBAction func anchor_A_invite_B(_ sender: Any) {
    }
    
    //主播A离开PK
    @IBAction func anchor_A_Leave(_ sender: Any) {
    }
    
    
    
    //主播B开播
    @IBAction func anchor_B_Live(_ sender: Any) {
        
        navTitle = "主播B开播"
    }
    
    //主播B接受主播A进行PK
    @IBAction func anchor_B_accept_A(_ sender: Any) {
    }
    
    //主播B离开PK
    @IBAction func anchor_B_Leave(_ sender: Any) {
    }
    

    
    //观众A进入直播间
    @IBAction func audience_A_watch(_ sender: Any) {
        navTitle = "观众A进入直播间"
    }
    
    
    //观众B进入直播间
    @IBAction func audience_B_watch(_ sender: Any) {
        navTitle = "观众B进入直播间"
    }
}
