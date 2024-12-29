//
//  PlayerNameViewController.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-20.
//

import UIKit

class PlayerNameViewController: UIViewController {

    @IBOutlet weak var tblPlayerNameInput: UITableView!
    
    var playerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPlayerNameInput.delegate = self
        tblPlayerNameInput.dataSource = self
        
        tblPlayerNameInput.register(UINib(nibName: "PlayerNameCell", bundle: nil), forCellReuseIdentifier: "PlayerNameCell")
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        var playerNames: [String] = []
        var playerDict: [String: Int] = [:]
               for row in 0..<playerCount {
                   if let cell = tblPlayerNameInput.cellForRow(at: IndexPath(row: row, section: 0)) as? PlayerNameCell {
                       if let playerName = cell.getPlayerName() {
                           playerNames.append(playerName)
                           playerDict[playerName] = 0
                       }
                   }
               }
        print(playerNames)
        
        UserDefaultHelper.shared.setPlayerDetails(data: playerDict)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JudgementViewController") as? JudgementViewController
        vc?.playerCount = playerCount
        vc?.arrPlayerNames = playerNames
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}

extension PlayerNameViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNameCell", for: indexPath) as! PlayerNameCell
        
        cell.txtPlayerName.delegate = self
        
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Dismiss the keyboard by resigning the first responder
            textField.resignFirstResponder()
            return true
        }
    
    
}
