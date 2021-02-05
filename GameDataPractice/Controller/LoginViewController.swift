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


struct User {
    let date: String
    let gameMemo: String
    let matchResult: String
    let opponent: String
    let stadium: String
    
    init(dic: [String: Any]) {
        self.date = dic["date"] as! String
        self.gameMemo = dic["gameMemo"] as! String
        self.matchResult = dic["matchResult"] as! String
        self.opponent = dic["opponent"] as! String
        self.stadium = dic["stadium"] as! String
        
    }
}

class LoginViewController: UIViewController {
  
    
    @IBOutlet weak var LoginEmailTextField: UITextField!
    @IBOutlet weak var LoginNameTextField: UITextField!
    @IBOutlet weak var LoginRegisterButton: UIButton!

    
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
        print("tapped LoginRegisterButton")
        HUD.show(.progress, onView: self.view)
        guard let email = LoginEmailTextField.text else { return }
        guard let LoginName = LoginNameTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: LoginName) { (res, err) in
            if let err = err {
                print("ログイン情報の取得に失敗しました。", err)
                return
            }
            print("ログインに成功しました。")
   //ログインに成功した後の処理
          //  guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let uid = res?.user.uid else { return }
            let userRef = Firestore.firestore().collection("games").document(uid)
            userRef.getDocument{ (snapshot, err) in
                if let err = err {
                    
                    print("ユーザー情報の取得に失敗しました。\(err)" )
                   HUD.hide { (_) in
                    HUD.flash(.error, delay: 1)
                    }
                    return
                    
                }
            
           guard let data = snapshot?.data() else { return }
            let user = User.init(dic: data)
            
            print("ユーザー情報の取得ができました。" )
                  HUD.hide { (_) in
                  HUD.flash(.success,onView: self.view, delay: 1) { (_) in
                        self.presentToLoginViewController(user: user)
                   }
                }
            }
        }
    }

    private func presentToLoginViewController(user: User) {
    let storyBoard = UIStoryboard(name: "Login", bundle: nil)
    let LoginViewController = storyBoard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
    let navController = UINavigationController(rootViewController: LoginViewController)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true, completion: nil)
    
}
    
        
    override func viewDidLoad() {
    super.viewDidLoad()
   
        LoginNameTextField.delegate = self
        LoginNameTextField.delegate = self
    
        }

    private func presentToMainViewController() {
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyBoard.instantiateViewController(identifier: "ViewController") as! LoginViewController
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        }
    
    
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
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

        
        
