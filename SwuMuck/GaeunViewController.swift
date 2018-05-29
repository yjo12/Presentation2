//
//  GaeunViewController.swift
//  SwuMuck
//
//  Created by 연쟁 on 2018. 5. 29..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class GaeunViewController: UIViewController, UITableViewDataSource {
    
    var gaeun:[String: [String]] = ["가은":["아메리카노", "카푸치노", "더치커피", "녹차라떼", "고구마라떼", "초코라떼"]] //
    let GaeunTitle : [String] = ["커피","음료"] //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   //섹션 어떻게 나눌지는 상점별로 다르기 때문에 상점별 메뉴 구분을 보고 추후 정할 예정임
     func numberOfSections (in tableView: UITableView) -> Int {
        return 2 //
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return GaeunTitle[section]
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return gaeun.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Gaeun Cell", for: indexPath)
        // Configure the cell...
        var collegeName = Array(gaeun.keys) //
        cell.textLabel?.text = collegeName[indexPath.row] //
        return cell
    }
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
