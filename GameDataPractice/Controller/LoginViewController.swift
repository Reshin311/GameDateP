//
//  Login.swift
//  GameDataPractice
//
//  Created by Shin on 2021/01/27.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import PKHUD


class LoginViewController: UIViewController {
  
    
    @IBOutlet weak var LoginEmailTextField: UITextField!
    @IBOutlet weak var LoginNameTextField: UITextField!
    @IBOutlet weak var LoginRegisterButton: UIButton!

    
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
        print("tapped LoginRegisterButton")
   
    

        guard let email = LoginEmailTextField.text else { return }
        guard let LoginName = LoginNameTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: LoginName) { (res, err) in
            if let err = err {
                print("ログイン情報の取得に失敗しました。\(err)")
                return
            }
            print("ログインに成功しました。")
    
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let userRef = Firebase.firestore().collection("games").document(uid)
            userRef.setData(docDate) { (err) in
                if let err = err {
                    
                    print("Firestoreへの保存に失敗しました。\(err)" )
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                    return
                    
                }
                print("Firestoreへの保存に成功しました。" )
                
                
                
                userRef.getDocument { (snapshot, err) in
                    if let err = err {
                        print("ユーザー情報の取得に失敗しました。\(err)")
                        HUD.hide { (_) in
                            HUD.flash(.error, delay: 1)
                        }
    
    }
    
    }

    
    override func viewDidLoad() {
    super.viewDidLoad()
   
        LoginNameTextField.delegate = self
        LoginNameTextField.delegate = self
    
    
    
    
    }
}
// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let LoginEmailIsEmpty = LoginEmailTextField.text?.isEmpty ?? true
        let LoginNameIsTextIsEmpty = LoginNameTextField.text?.isEmpty ?? true
        
        
  //        print("opponentTextField.text@: ",textField.text)

        if LoginEmailIsEmpty || LoginNameIsTextIsEmpty {
            LoginRegisterButton.isEnabled = false
            //ボタン押せない時に色変える（省略）
        //    gameRegisterButton.backgroundColor = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        } else {
            LoginRegisterButton.isEnabled = true

        }
    }
    
}


