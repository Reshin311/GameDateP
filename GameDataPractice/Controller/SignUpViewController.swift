//
//  SignUp.swift
//  GameDataPractice
//
//  Created by Shin on 2021/01/27.
//

import UIKit
import Firebase
import FirebaseAuth
import PKHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpNameTextField: UITextField!
    @IBOutlet weak var signUpRegisterButton: UIButton!
    @IBOutlet weak var goMainButton: UIButton!
    
    
    @IBAction func tappedSignUpButton(_ sender: Any) {
      print("tappedSignUpButton")
        handleAuthToFirebase()
             print("tappedRegisterButton")
         }
         
         private func handleAuthToFirebase() {
             guard let email = signUpEmailTextField.text else { return }
             guard let LoginName = signUpNameTextField.text else { return }
             
             Auth.auth().createUser(withEmail: email, password: LoginName) { (res, err) in
                 if let err = err {
                     print("認証情報の保存に失敗しました。\(err)")
                     return
                 }
                 print("認証情報の保存に成功しました。")
         }

         }
    
    
    @IBAction func pushGoMainButton(_ sender: Any) {
   
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        signUpRegisterButton.isEnabled = false
        
/*        signUpEmailTextField.delegate = self
        signUpNameTextField.delegate = self
  */
    }
     
    private func presentToMainViewController() {
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyBoard.instantiateViewController(identifier: "ViewController") as! LoginViewController
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        }
    
    
    
    
    
    
        //入力フォーム以外をタッチすると、キーボードが下がる
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }





}

/*
extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let signUpEmailIsEmpty = signUpEmailTextField.text?.isEmpty ?? true
        let signUpNameTextIsEmpty = signUpNameTextField.text?.isEmpty ?? true
    
  //        print("opponentTextField.text@: ",textField.text)

        if signUpEmailIsEmpty || signUpNameTextIsEmpty {
            signUpRegisterButton.isEnabled = false
            //ボタン押せない時に色変える（省略）
        //    gameRegisterButton.backgroundColor = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        } else {
            signUpRegisterButton.isEnabled = true

        }
    }
    
}
*/
