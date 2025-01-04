//
//  JudgementViewController.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-22.
//

import UIKit

class JudgementViewController: UIViewController {
    
    @IBOutlet weak var tblJudgementInput: UITableView!
    
    var playerCount = 0
    var arrPlayerNames: [String] = []
    var counts: [Int] = []
    var switchStates: [Bool] = []
    var isJudgementView = true
    var dictPlayerScore : [String: Int] = [:]
    var trumpCounter = 0
    var isScoreLabelHidden = true
    var roundCounter = 1
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblRound: UILabel!
    @IBOutlet weak var imgTrump: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dictPlayerScore = UserDefaultHelper.shared.getPlayerDetails()
        
        tblJudgementInput.delegate = self
        tblJudgementInput.dataSource = self
        
        tblJudgementInput.register(UINib(nibName: "JudgementTableViewCell", bundle: nil), forCellReuseIdentifier: "JudgementTableViewCell")
        tblJudgementInput.register(UINib(nibName: "CheckerTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckerTableViewCell")
        
        counts = Array(repeating: 0, count: playerCount)
        switchStates = Array(repeating: false, count: playerCount)
        
        imgTrump.image = UIImage(systemName: "suit.spade.fill")
        lblScore.isHidden = true
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        isJudgementView = !isJudgementView
        tblJudgementInput.reloadData()
        
        if !isJudgementView {
            
        }else{
            for i in 0..<playerCount{
                if switchStates[i] {
                    let tempScore = (dictPlayerScore[arrPlayerNames[i]] ?? 0) + (Int("1" + "\(counts[i])") ?? 0)
                    
                    dictPlayerScore[arrPlayerNames[i]] = tempScore
                }
            }
            UserDefaultHelper.shared.setPlayerDetails(data: dictPlayerScore)
            print(dictPlayerScore)
            
            counts = counts.map { _ in 0 }
            switchStates = Array(repeating: false, count: playerCount)
            
            trumpCounter += 1
            roundCounter += 1
            lblRound.text = "Round \(roundCounter)"
            
            if trumpCounter == 0 {
                imgTrump.image = UIImage(systemName: "suit.spade.fill")
            }else if trumpCounter == 1 {
                imgTrump.image = UIImage(systemName: "suit.diamond.fill")
            }else if trumpCounter == 2 {
                imgTrump.image = UIImage(systemName: "suit.club.fill")
            }else{
                imgTrump.image = UIImage(systemName: "suit.heart.fill")
                trumpCounter = -1
            }
            
        }
    }
    
    @IBAction func checkScore(_ sender: Any) {
        
        if isScoreLabelHidden{
            
            let dict = UserDefaultHelper.shared.getPlayerDetails()
            var str = ""
            for key in dict.keys {
                str.append("\(key) : \(dict[key]!)\n")
            }
            print(str + "TESTING")
            lblScore.text = str
            lblScore.isHidden = false
        }else{
            lblScore.isHidden = true
        }
        isScoreLabelHidden = !isScoreLabelHidden
    }
}

extension JudgementViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (isJudgementView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "JudgementTableViewCell", for: indexPath) as! JudgementTableViewCell
            cell.lblName.text = arrPlayerNames[indexPath.row]
            cell.lblCount.text = "\(counts[indexPath.row])"
            
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckerTableViewCell", for: indexPath) as! CheckerTableViewCell
            cell.lblPlayerName.text = arrPlayerNames[indexPath.row]
            cell.lblCount.text = "\(counts[indexPath.row])"
            cell.swichIsCorrect.isOn = switchStates[indexPath.row]
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
        
    }
}

extension JudgementViewController: JudgementTableViewCellDelegate, CheckerTableViewCellDelegate {
    func didTapMinusButton(at indexPath: IndexPath) {
        if counts[indexPath.row] > 0 {
            counts[indexPath.row] -= 1
            tblJudgementInput.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didTapPlusButton(at indexPath: IndexPath) {
        counts[indexPath.row] += 1
        tblJudgementInput.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func didToggleSwitch(at indexPath: IndexPath, isOn: Bool) {
        switchStates[indexPath.row] = isOn
    }
}
