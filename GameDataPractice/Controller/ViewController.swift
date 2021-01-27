//
//  ViewController.swift
//  GameDataPractice
//
//  Created by Shin on 2021/01/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var gameRegisterButton: UIButton!
        
    @IBOutlet weak var opponentTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var matchResultTextField: UITextField!
    @IBOutlet weak var stadiumTextField: UITextField!
    @IBOutlet weak var gameMemoTextField: UITextField!
  
    
    @IBAction func tappedRegisterButton(_ sender: Any) {
       
        let opponent = opponentTextField.text
        let date = dateTextField.text
        let matchResult = matchResultTextField.text
        let stadium = stadiumTextField.text
        let gameMemo = gameMemoTextField.text
        
        let docData = ["opponent": opponent, "date": date, "matchResult": matchResult, "stadium": stadium, "gameMemo": gameMemo] as [String : Any]
    
       Firestore.firestore().collection("games").document().setData(docData) { (err) in if let err = err {
        print("Firestoreへの保存に失敗しました。\(err)")
                return
            }
        
        print("Firestoreへの保存に成功しました。")
        
        }





    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameRegisterButton.isEnabled = false
       
        opponentTextField.delegate = self
        dateTextField.delegate = self
        matchResultTextField.delegate = self
        stadiumTextField.delegate = self
        gameMemoTextField.delegate = self


    }

    //入力フォーム以外をタッチすると、キーボードが下がる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let opponentIsEmpty = opponentTextField.text?.isEmpty ?? true
        let dateTextIsEmpty = dateTextField.text?.isEmpty ?? true
        let matchResultIsEmpty = matchResultTextField.text?.isEmpty ?? true
        let stadiumIsEmpty = stadiumTextField.text?.isEmpty ?? true
        let gameMemoIsEmpty = gameMemoTextField.text?.isEmpty ?? true
        
        print("opponentTextField.text@: ",textField.text)

        if opponentIsEmpty || dateTextIsEmpty || matchResultIsEmpty || stadiumIsEmpty || gameMemoIsEmpty {
            gameRegisterButton.isEnabled = false
            //ボタン押せない時に色変える（省略）
        //    gameRegisterButton.backgroundColor = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        } else {
            gameRegisterButton.isEnabled = true

        }
    }
    
}
