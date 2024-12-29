//
//  CheckerTableViewCell.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-25.
//

import UIKit

protocol CheckerTableViewCellDelegate: AnyObject {
    func didToggleSwitch(at indexPath: IndexPath, isOn: Bool)
}

class CheckerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var swichIsCorrect: UISwitch!
    
    weak var delegate: CheckerTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        swichIsCorrect.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func switchToggled() {
        if let indexPath = indexPath {
            delegate?.didToggleSwitch(at: indexPath, isOn: swichIsCorrect.isOn)
        }
    }
    
}
