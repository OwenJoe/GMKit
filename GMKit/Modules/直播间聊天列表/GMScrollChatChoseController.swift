//
//  GMScrollChatChoseController.swift
//  GMKit
//
//  Created by owen on 2024/6/16.
//

import UIKit

class GMScrollChatChoseController: GMBaseViewController, UITableViewDelegate, UITableViewDataSource {

    let cellID  = "cell"
    var listArr = ["GCD模式","NSTime模式", "数据自动插入"]
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GMScrollChatCellKey, bundle: nil), forCellReuseIdentifier: GMScrollChatCellKey)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? UITableViewCell
        cell?.textLabel?.text = listArr[indexPath.row]
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let oneVc =  GMScrollChatOneController()
            self.navigationController?.pushViewController(oneVc, animated: true)
        }
        else if indexPath.row == 1{
            
            let twoVc =  GMScrollChatTwoController()
            self.navigationController?.pushViewController(twoVc, animated: true)
        }       
        else if indexPath.row == 2{
            
            let twoVc =  GMScrollChatThreeController()
            self.navigationController?.pushViewController(twoVc, animated: true)
        }
    }
}
