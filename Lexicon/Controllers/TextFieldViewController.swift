//
//  TextFieldViewController.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Экран с полем для вставки текста. Появляется после нажатия на главном экране кнопки "Start"

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    
    var TextField: UITextField = UITextField()
    let TextButton: UIButton = UIButton(type: .custom)
    let InfoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColors.shared.getBackgroundColour()
        TextField.delegate = self
        setupTextField()
        setupTextButton()
        setupInfolabel()

        // Do any additional setup after loading the view.
    }
    
    
    func setupTextField(){
        view.addSubview(TextField)
        TextField.translatesAutoresizingMaskIntoConstraints = false
        TextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        TextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        TextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        TextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140).isActive = true
        TextField.backgroundColor = UIColor(red:0.96, green:0.90, blue:0.90, alpha:1.0)
        TextField.backgroundColor = .white
        TextField.textColor = UIColor(red:0.34, green:0.29, blue:0.56, alpha:1.0)
        TextField.layer.cornerRadius = 30
    }
    
    func setupTextButton(){
        view.addSubview(TextButton)
        TextButton.translatesAutoresizingMaskIntoConstraints = false
        TextButton.centerYAnchor.constraint(equalTo: TextField.bottomAnchor, constant: 50).isActive = true
        TextButton.centerXAnchor.constraint(equalTo: TextField.centerXAnchor).isActive = true
        TextButton.setTitle("Start!", for: .normal)
        TextButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
        TextButton.addTarget(self, action:  Selector(("onTextButtonTap")), for: .touchUpInside)
    }
    func setupInfolabel(){
        view.addSubview(InfoLabel)
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        InfoLabel.centerYAnchor.constraint(equalTo: TextField.topAnchor, constant: -15).isActive = true
        InfoLabel.centerXAnchor.constraint(equalTo: TextField.centerXAnchor).isActive = true
        InfoLabel.text = "Add a text in English, then push Start"
        InfoLabel.font = .systemFont(ofSize: 18, weight: .light)
        InfoLabel.textColor = .white
    }
    
    @objc func onTextButtonTap() {
        OutletsStartActions.shared.textButtonAction(TextField.text ?? "")
      }
    /*
    // MARK: - Navigation""

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
