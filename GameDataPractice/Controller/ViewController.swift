//
//  ViewController.swift
//  GameDataPractice
//
//  Created by Shin on 2021/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameRegisterButton: UIButton!
        
    @IBOutlet weak var opponentTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var matchResultTextField: UITextField!
    @IBOutlet weak var stadiumTextField: UITextField!
    @IBOutlet weak var gameMemoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        if opponentIsEmpty || dateTextIsEmpty || matchResultIsEmpty || stadiumIsEmpty || gameMemoIsEmpty {
            gameRegisterButton.isEnabled = false
            //ボタン押せない時に色変える（省略）
        //    gameRegisterButton.backgroundColor = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        } else {
            gameRegisterButton.isEnabled = true

        }
    }
    
}
