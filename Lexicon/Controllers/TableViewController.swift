//
//  TableViewController.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView.init(frame: .zero, style: .plain)
    var link = [dictionary]()
    var pushedButtom: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColors.shared.getBackgroundColour()
        setupTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        //CoreDataManager.shared.cleanLexiconWords()
        //CoreDataManager.shared.cleanProblemWords()

        // Do any additional setup after loading the view.
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 120, right: 0)
//            tableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 120, right: 0)
//            tableView.reloadData()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }

    func setupTableView() {
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: "CustomViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
       }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.reloadData()
        self.reloadInputViews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return link.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomViewCell", for: indexPath) as? CustomViewCell else { print("else")
            return UITableViewCell()
        }
        cell.dict = link[indexPath.row]
        cell.TranslText.delegate = self
        cell.indexSell = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
     }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            link.remove(at: indexPath.row)
            DataModel.shared.deleteWord(index: indexPath.row, source: pushedButtom ?? "")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
         tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
       // print(indexPath.row)
    }
    

    

    
//    func tableView
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
  

// Работает иногда непредсказуемо (из-за кривого определения ячейки,в которой вводят текст - скроллит вверх при обновлении)
extension TableViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let x = textView.superview as! CustomViewCell
        guard let i: Int = x.indexSell else {return}
        
        link[i].translation = textView.text
        tableView.reloadData()
        DataModel.shared.addWord(index: i, source: pushedButtom ?? "", toSave: link[i])
        if pushedButtom == "problem" {link = DataModel.shared.getProblemWords()}
        else if pushedButtom == "swipe" {}
        else if pushedButtom == "lexicon" {link = DataModel.shared.getLexiconWords()}
        reloadInputViews()
        //tableView.reloadData()
        
    }
}
