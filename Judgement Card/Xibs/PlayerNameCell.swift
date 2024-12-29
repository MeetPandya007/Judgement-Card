//
//  PlayerNameCell.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-20.
//

import UIKit

class PlayerNameCell: UITableViewCell {
    
    @IBOutlet weak var txtPlayerName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func getPlayerName() -> String? {
        return txtPlayerName.text
    }
}
