//
//  GMChatController.swift
//  Gimme
//
//  Created by hule on 2024/5/24.
//

import UIKit


class GMChatController: GMBaseViewController{

    var chatTitleStr: String = ""
    let footViewHeight  = tabBarHeight - 10
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, navigationBarHeight, ScreenWidth, ScreenHeight - footViewHeight - navigationBarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "GMChatCell", bundle: nil), forCellReuseIdentifier: "GMChatCellID")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = HexString("#101123")
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    
    lazy var footerView: GMChatSendView = {
        let view = Bundle.main.loadNibNamed("GMChatSendView", owner: nil, options: [:])?.first as? GMChatSendView
        view?.frame = CGRectMake(0, ScreenHeight - footViewHeight, ScreenWidth, footViewHeight)
        view?.sendClouse = {[weak self] message  in
            
            self?.sendData(message: message)
        }
        return view ?? GMChatSendView()
    }()
    
   private var listArr: [GMChatModel] = []
    var datas  = [[GMChatModel]] () // 这里初始化为空数组
    var row: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MessageLoadNotic"), object:nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let lastIndexPath = getLastIndexPath() {
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }
    }

    
    //获取列表数据
    func getData()  {
        
        listArr = datas[row ?? 0]
        tableView.reloadData()
    }
    
    //UI添加
    func setupUI()  {
        self.title = chatTitleStr
        view.addSubview(tableView)
        view.addSubview(footerView)
    }
    
    
    //发送 插入数据并刷新
    func sendData(message: String?)  {
        
        let mes =  GMChatModel.initModel(recent: "", messageCount: 0, time: "", pic: "", name: "", content: message, type: .mySelf)
        
        listArr.append(mes)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath (row: listArr.count - 1, section: 0)], with: .fade)
        tableView.endUpdates()
        
        // 滚动到最后一条
        if let lastIndexPath = getLastIndexPath() {
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }
        
        //插入到缓存数据
        if var arr:[[GMChatModel]] = GMStorageManager.shared.getCustomModelArray(forKey: ChatModelArrKey) {
            
            arr[row ?? 0] = listArr
            GMStorageManager.shared.saveCustomModelArray(array: arr, forKey: ChatModelArrKey)
        }
    }
    
    
    // 获取最后一个 IndexPath 的方法
    func getLastIndexPath() -> IndexPath? {
        let lastSectionIndex = tableView.numberOfSections - 1
        guard lastSectionIndex >= 0 else {
            return nil
        }
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        guard lastRowIndex >= 0 else {
            return nil
        }
        return IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }
    
    

}


extension  GMChatController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GMChatCellID", for: indexPath) as? GMChatCell ?? GMChatCell()
        cell.selectionStyle = .none
        cell.model = listArr[indexPath.row]
        return cell
    }
    

}
