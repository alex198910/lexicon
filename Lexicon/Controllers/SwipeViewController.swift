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
    let DataModel = SwipeDataModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColors.shared.getBackgroundColour()
        setupSwipe()
        delegating()
        SetupButtons.setup()
        print(array)

        // Do any additional setup after loading the view.
    }
    
    private func delegating(){
        Actions.delegate = self
        Actions.selfView = view
        SetupButtons.selfView = view
        DataModel.reset()
        DataModel.array = array
        
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
        SetupSwipeButtons.shared.filterButton.addGestureRecognizer(pan)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        Actions.handleSwipe(sender)
        if (DataModel.isFinished()) {
            RoutStartViewController.shared.goToListOfProblemWordsAfterSwipe()
        }
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func reload() {
        self.reloadInputViews()
        
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
