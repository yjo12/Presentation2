//
//  CreateViewController.swift
//  Swumuck_owner_ver
//
//  Created by 연쟁 on 2018. 5. 28..
//  Copyright © 2018년 연쟁. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == self.textID { textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
        }
        else if textField == self.textPassword {
            textField.resignFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonSave() {
        if textID.text == "" {
            labelStatus.text = "ID를 입력하세요"; return; }
        if textPassword.text == "" {
            labelStatus.text = "Password를 입력하세요"; return; }
        let urlString: String = "http://localhost:8888/login/insertUser2.php"
        guard let requestURL = URL(string: urlString) else {
            return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + textID.text! + "&password=" + textPassword.text!
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
    
    @IBAction func buttonBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
