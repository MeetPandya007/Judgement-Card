//
//  JudgementTableViewCell.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-22.
//

import UIKit

protocol JudgementTableViewCellDelegate: AnyObject {
    func didTapMinusButton(at indexPath: IndexPath)
    func didTapPlusButton(at indexPath: IndexPath)
}

class JudgementTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgMinus: UIImageView!
    @IBOutlet weak var imgPlus: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    
    weak var delegate: JudgementTableViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let minusTapGesture = UITapGestureRecognizer(target: self, action: #selector(minusButtonTapped))
                imgMinus.addGestureRecognizer(minusTapGesture)
                imgMinus.isUserInteractionEnabled = true
                
                let plusTapGesture = UITapGestureRecognizer(target: self, action: #selector(plusButtonTapped))
                imgPlus.addGestureRecognizer(plusTapGesture)
                imgPlus.isUserInteractionEnabled = true
    }

    @objc func minusButtonTapped() {
            if let indexPath = indexPath {
                delegate?.didTapMinusButton(at: indexPath)
            }
        }
        
        @objc func plusButtonTapped() {
            if let indexPath = indexPath {
                delegate?.didTapPlusButton(at: indexPath)
            }
        }
    
}
