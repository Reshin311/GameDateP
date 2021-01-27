//
//  Login.swift
//  GameDataPractice
//
//  Created by Shin on 2021/01/27.
//

import UIKit
import Firebase
import FirebaseAuth

class Login: UIViewController {
  
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var LoginNameTextField: UITextField!
    @IBOutlet weak var LoginRegisterButton: UIButton!

    
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
   handleAuthToFirebase()
        print("tappedRegisterButton")
    }
    
    private func handleAuthToFirebase() {
        guard let email = emailTextField.text else { return }
        guard let LoginName = LoginNameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: LoginName) { (res, err) in
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                return
            }
            print("認証情報の保存に成功しました。")
    }

    }
    override func viewDidLoad() {
    super.viewDidLoad()
}
}
