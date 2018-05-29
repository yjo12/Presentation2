//
//  OrderViewController.swift
//  SwuMuck
//
//  Created by SWUCOMPUTER on 2018. 5. 29..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.

import UIKit

class OrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var shopPicker: UIPickerView!
    @IBOutlet var orderRequest: UITextView!
    @IBOutlet var menuPicker: UIPickerView!
     @IBOutlet var labelStatus: UILabel!
    
    // 상점 및 메뉴 데이터. shopMenu 딕셔너리, shopList 어레이(shopPicker에 사용), menuList 어레이(menuPicker에 사용).
    var orderList: Dictionary<String,Array<String>> = Dictionary()
    let shopMenu:[String:Array<String>] = ["가은":["아메리카노", "카푸치노", "더치커피", "녹차라떼", "고구마라떼", "초코라떼"], "비틀주스":["바나나 주스", "딸기 주스", "파인애플 주스", "딸바유", "고구마유", "블루베리유"],"에땅":["햄치즈 샌드위치", "에그 샌드위치", "크로와상 샌드위치", "에땅 버거", "칠리 버거", "핫도그"], "퀴즈노스":["제스티 그릴드 스테이크", "더블 치즈 스테이크", "로스트 비프/구아카몰", "치킨 까르보나라", "치킨 베이컨 랜치", "허니 머스타드 치킨"]]
    var shopList: Array<String> = Array()
    var menuList: Array<String> = Array()
    
    var shopRow = 0
    var menuRow = 0
    
    // shopPicker, menuPicker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent
        component: Int) -> Int {
        if pickerView == shopPicker {
            return shopList.count
        } else {
            return menuList.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == shopPicker {
            return shopList[row]
        } else {
            return menuList[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // shopPicker 변경 시 menuPicker의 내용 변경
        if pickerView == shopPicker {
            shopRow = row
            shopPicker.selectedRow(inComponent: 0)
            self.menuList = Array(shopMenu[shopList[shopPicker.selectedRow(inComponent: 0)]]!)
            self.menuPicker.reloadAllComponents()
        } else {
            menuRow = row
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // shopList 및 menuList 정의
        shopList = Array(shopMenu.keys)
        for i in 0...3 {
        menuList = Array(shopMenu[shopList[i]]!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 주문 완료 버튼
    @IBAction func orderDone(_ sender: UIBarButtonItem) {
 
        // userid
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userid = appDelegate.userName
        
        // 현재 날짜, 시간
        let time = Date()
        let stringTime = String(describing: time)

        // picker에서 선택한 것
        let selectedShop = String(shopList[shopPicker.selectedRow(inComponent: 0)])
        let selectedMenu = String(menuList[menuPicker.selectedRow(inComponent: 0)])
        
        // 서버 테이블에 데이터 넣기
        let urlString: String = "http://localhost:8888/login/createOrder.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "&id=" + userid! + "&shop=" + selectedShop + "&menu=" + selectedMenu + "&time=" + stringTime + "&request=" + orderRequest.text!
        request.httpBody = restString.data(using: .utf8)
        self.executeRequest(request: request)
    }
    
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { print("Error: calling POST")
                return }
            guard let receivedData = responseData else { print("Error: not receiving Data")
                return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { DispatchQueue.main.async { // for Main Thread Checker
                self.labelStatus.text = utf8Data
                print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
                }
            } }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
