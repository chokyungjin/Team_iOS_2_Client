//
//  PasswordViewController.swift
//  90's
//
//  Created by 홍정민 on 2020/04/09.
//  Copyright © 2020 홍정민. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfNewPass: UITextField!
    @IBOutlet weak var tfConfirmPass: UITextField!
    @IBOutlet weak var selectorImageView1: UIImageView!
    @IBOutlet weak var selectorImageView2: UIImageView!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.isEnabled = false
        tfConfirmPass.isEnabled = false
        validationLabel.isHidden = true
        
        tfNewPass.delegate = self
        tfConfirmPass.delegate = self
        
        tfNewPass.becomeFirstResponder()
        
        //새로운 패스워드 TF에 대한 옵저버
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: tfNewPass, queue: .main, using : {
            _ in
            let str = self.tfNewPass.text!.trimmingCharacters(in: .whitespaces)
            
            if(str != ""){
                self.selectorImageView1.backgroundColor = UIColor.black
                self.tfConfirmPass.isEnabled = true
            }else {
                self.selectorImageView1.backgroundColor = UIColor.gray
           self.tfConfirmPass.isEnabled = false
            }
            
        })
        
        
        //패스워드 확인 TF에 대한 옵저버
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: tfConfirmPass, queue: .main, using : {
            _ in
            let str = self.tfConfirmPass.text!.trimmingCharacters(in: .whitespaces)
            
            if(str != ""){
                self.selectorImageView2.backgroundColor = UIColor.black
                self.nextBtn.backgroundColor = UIColor.black
                self.nextBtn.isEnabled = true
            }else {
                self.selectorImageView2.backgroundColor = UIColor.gray
                self.nextBtn.backgroundColor = UIColor.gray
                self.nextBtn.isEnabled = false
            }
            
        })

    }
    
    //다음 버튼 클릭 시 액션
    @IBAction func clickNextBtn(_ sender: Any) {
        let newPass = tfNewPass.text!
        let confirmPass = tfConfirmPass.text!
        if(newPass == confirmPass){
            let telephoneVC = storyboard?.instantiateViewController(identifier: "TelephoneViewController") as! TelephoneViewController
            navigationController?.pushViewController(telephoneVC, animated: true)
        }else {
            validationLabel.isHidden = false
        }
    }
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfNewPass.endEditing(true)
        tfConfirmPass.endEditing(true)
    }
    
    //키보드 리턴 버튼 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == tfNewPass){
            tfConfirmPass.becomeFirstResponder()
        }
        return true
    }
    
    
}
