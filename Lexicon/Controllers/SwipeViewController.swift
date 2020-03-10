//
//  SwipeViewController.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Экран со Свайпом слов.

class SwipeViewController: UIViewController, ReloadInputViews {

    var array = [String]()
    let SetupButtons = SetupSwipeButtons.shared
    let Actions = OutletsSwipeActions.shared
    let SwDataModel = SwipeDataModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColors.shared.getBackgroundColour()
        alertView()
        setupSwipe()
        delegating()
        SetupButtons.setup()

        // Do any additional setup after loading the view.
    }
    
    private func delegating(){
        Actions.delegate = self
        Actions.selfView = view
        SetupButtons.selfView = view
        SwDataModel.reset()
        SwDataModel.array = array
        
    }
    
    func alertView(){
        let alert = UIAlertController(title: "", message: "Swipe right - unknown word \n\nSwipe left - familiar word \n\nSwipe UP - next word \n\nSwipe down - prev. word \n", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        SetupButtons.changScale()
    }
    
    private func setupSwipe(){
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(recognizer:)))
        SetupSwipeButtons.shared.mainWordButton.addGestureRecognizer(pan)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        Actions.handleSwipe(sender)
        if (SwDataModel.isFinished()) {
            RoutStartViewController.shared.goToListOfProblemWordsAfterSwipe()
        }
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        Actions.handlePan(recognizer: recognizer)
        if (SwDataModel.isFinished()) {
            RoutStartViewController.shared.goToListOfProblemWordsAfterSwipe()
        }
    }
    
    func reload() {
        
        self.reloadInputViews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
