//
//  ViewController.swift
//  Judgement Card
//
//  Created by Meetkumar Pandya on 2024-12-20.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var lblPlayerCount: UILabel!
    @IBOutlet weak var pickerCount: UIPickerView!
    
    var totalPlayerCount = 0
    let playerCountOptions = Array(1...20)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerCount.delegate = self
        self.pickerCount.dataSource = self
        
        pickerCount.selectRow(0, inComponent: 0, animated: false)
        totalPlayerCount = playerCountOptions[0]
        lblPlayerCount.text = "\(totalPlayerCount)"
    }
    
    @IBAction func onClickNextBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PlayerNameViewController") as? PlayerNameViewController
        vc?.playerCount = totalPlayerCount
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playerCountOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        
        return "\(playerCountOptions[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        totalPlayerCount = playerCountOptions[row]
        lblPlayerCount.text = "\(totalPlayerCount)"
    }
}

