//
//  CustomViewCell.swift
//  Lexicon
//
//  Created by admin on 28.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    
    var dict = dictionary.init(word: "", translation: "")
    var EngText = UITextView()
    var TranslText = UITextView()
    var Delimetr = UITextView()
    var indexSell: Int?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = UIColors.shared.getCellColour()
        setupEngText()
        setupTranslText()
        setupDelimetr()
        // Configure the view for the selected state
    }
    
    func setupEngText(){
        addSubview(EngText)
        EngText.text = dict.word
        EngText.frame = CGRect(x: 0, y: bounds.height/3, width: (bounds.width / 2) - 10, height: (2 * bounds.height)/3 - 10)
        EngText.backgroundColor = UIColors.shared.getCellTextFieldColour()
        EngText.textAlignment = .center
        EngText.font = .systemFont(ofSize: 19, weight: .semibold)
        EngText.textColor = .black
        EngText.isEditable = false
    }
    
    func setupTranslText(){
        addSubview(TranslText)
        TranslText.text = dict.translation
        TranslText.frame = CGRect(x: (bounds.width / 2) + 10, y: bounds.height/3, width: (bounds.width / 2) - 20, height: (2 * bounds.height)/3 - 10)
        TranslText.backgroundColor = UIColors.shared.getCellTextFieldColour()
        TranslText.textAlignment = .center
        TranslText.font = .systemFont(ofSize: 19, weight: .semibold)
        TranslText.textColor = .black
        TranslText.isEditable = true
    
    }
    
    func setupDelimetr(){
        addSubview(Delimetr)
        Delimetr.frame = CGRect(x: (bounds.width / 2) - 5, y: 0, width: 10, height: bounds.height)
        Delimetr.backgroundColor = UIColors.shared.getTextColour()
    }


}
