//
//  LoginMainViewController.swift
//  90's
//
//  Created by 홍정민 on 2020/04/11.
//  Copyright © 2020 홍정민. All rights reserved.
//

import UIKit


class LoginMainViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var selectorImageView1: UIImageView!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var passValidationLabel: UILabel!
    @IBOutlet weak var selectorImageView2: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var buttonConst: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    
    var email:String!
    var pass:String!
    var keyboardFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTextFieldObserver()
    }
    
    @IBAction func goBack(_ sender: Any) {
        guard let count = navigationController?.viewControllers.count else { return }
        if (count >= 2){
            navigationController?.popViewController(animated: true)
        }else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.switchEnterView()
        }
    }
    
    @IBAction func goLogin(_ sender: Any) {
        //이메일 형식 검사 후 로그인 형식 맞지 않을 시 메시지 표시
        
        email = tfEmail.text!
        pass = tfPass.text!
        
        
        if(!email.validateEmail()){
            emailValidationLabel.isHidden = false
            selectorImageView1.image = UIImage(named: "path378Red")
        }else{
            //로그인 통신
            //로그인 통신 후 로그인 실패시 메시지 표시
            emailValidationLabel.isHidden = true
            goLogin(email, pass, false)
        }
        
    }
    
    @IBAction func goFindPass(_ sender: Any) {
        let authenVC = storyboard?.instantiateViewController(withIdentifier: "AuthenViewController") as!
        AuthenViewController
        authenVC.authenType = "findPass"
        self.navigationController?.pushViewController(authenVC, animated: true)
    }
    
    @IBAction func goFindEmail(_ sender: Any) {
        let authenVC =  storyboard?.instantiateViewController(withIdentifier: "AuthenViewController") as!
        AuthenViewController
        authenVC.authenType = "findEmail"
        self.navigationController?.pushViewController(authenVC, animated: true)
    }
    
    
    
    //로그인 서버통신 메소드(자체회원가입 -> 자체로그인)
    func goLogin(_ email: String, _ password: String?, _ social: Bool){
        LoginService.shared.login(email: email, password: password, sosial: social, completion: { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    guard let data = response.data else { return }
                    guard let loginResult = try? JSONDecoder().decode(SignUpResult.self, from: data) else {return}
                    guard let jwt = loginResult.jwt else { return }
                    
                    UserDefaults.standard.set(self.email, forKey: "email")
                    UserDefaults.standard.set(self.pass, forKey: "password")
                    UserDefaults.standard.set(false, forKey: "social")
                    UserDefaults.standard.set(jwt, forKey: "jwt")
                    
                    UserDefaults.standard.set("", forKey: "defaultjwt")
                   
                    isDefaultUser = false
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.switchTab()
                    break
                case 400...404:
                    self.showErrAlert()
                    print("SignIn : client Err \(status)")
                    break
                case 500:
                    self.passValidationLabel.isHidden = false
                    self.selectorImageView2.image = UIImage(named: "path378Red")
                    print("SignIn : server Err \(status)")
                    break
                default:
                    return
                }
            }
        })
    }
    
    func showErrAlert(){
        let alert = UIAlertController(title: "오류", message: "로그인 불가", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfEmail.endEditing(true)
        tfPass.endEditing(true)
    }
    
    //키보드 리턴 버튼 클릭 시 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == tfEmail){
            tfPass.becomeFirstResponder()
        }
        return true
    }
    
    func setUI(){
        tfPass.delegate = self
        tfEmail.delegate = self
        emailValidationLabel.isHidden = true
        passValidationLabel.isHidden = true
        tfPass.isEnabled = false
        loginBtn.isEnabled = false
        loginBtn.layer.cornerRadius = 8.0
        titleLabel.textLineSpacing(firstText: "환영합니다:)", secondText: "로그인해 주세요")
        
    }
    
    //TextField에 대한 옵저버 처리
    func setTextFieldObserver(){
        //이메일 TF에 대한 옵저버
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: tfEmail, queue: .main, using : {
            _ in
            let str = self.tfEmail.text!.trimmingCharacters(in: .whitespaces)
            
            if(str != ""){
                self.selectorImageView1.image = UIImage(named: "path378Black")
                self.tfPass.isEnabled = true
            }else {
                self.selectorImageView1.image = UIImage(named: "path378Grey1")
                self.tfPass.isEnabled = false
            }
            
        })
        
        
        //패스워드 TF에 대한 옵저버
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: tfPass, queue: .main, using : {
            _ in
            let str = self.tfPass.text!.trimmingCharacters(in: .whitespaces)
            
            if(str != ""){
                self.selectorImageView2.image = UIImage(named: "path378Black")
                self.loginBtn.backgroundColor = UIColor(red: 227/255, green: 62/255, blue: 40/255, alpha: 1.0)
                self.loginBtn.isEnabled = true
            }else {
                self.selectorImageView2.image = UIImage(named: "path378Grey1")
                self.loginBtn.backgroundColor = UIColor(red: 199/255,green: 201/255, blue: 208/255, alpha: 1.0)
                self.loginBtn.isEnabled = false
            }
            
        })
        
        //키보드에 대한 Observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        
        let frameHeight = self.view.frame.height
        print("\(frameHeight)")
        if(frameHeight >= 736.0){
            //iphone6+, iphoneX ... (화면이 큰 휴대폰)
            buttonConst.constant = keyboardHeight - 18
        }else if(!keyboardFlag){
            //~iphone8, iphone7 (화면이 작은 휴대폰)
            keyboardFlag = true
            topConst.constant += 70
            self.view.frame.origin.y -= keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        let frameHeight = self.view.frame.height
        
        if(frameHeight >= 736.0){
            //iphoneX~
            buttonConst.constant = 18
        }else if(keyboardFlag){
            //~iphone8
            keyboardFlag = false
            topConst.constant -= 70
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
}
