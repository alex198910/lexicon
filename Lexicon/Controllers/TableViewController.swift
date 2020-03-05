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
        print(link)
        //CoreDataManager.shared.cleanLexiconWords()
        //CoreDataManager.shared.cleanProblemWords()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: "CustomViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
