//
//  GMMineController.swift
//  GMKit
//
//  Created by hule on 2024/6/6.
//

import UIKit

class GMMineController:  GMBaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    var listArr : [GMHomeModel]?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GMHomeCellID, bundle: nil), forCellReuseIdentifier: GMHomeCellID)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        view.addSubview(tableView)
        getData()
    }
    
    
    func getData()  {
        listArr = [
            GMHomeModel.init(content: "错题解决库", type: .errorResolutionLibrary),
        ]
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GMHomeCellID, for: indexPath) as? GMHomeCell
        cell?.rowStr = String(indexPath.section)
        cell?.model = listArr?[indexPath.section]
        return cell ?? GMHomeCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
}
