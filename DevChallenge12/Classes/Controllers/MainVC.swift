//
//  MainVC.swift
//  DevChallenge12
//
//  Created by " " on 5/7/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var borderButton: UIButton!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var sensitivitySlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var sensativiyyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var amountOfBarrierLabel: UILabel!
    @IBOutlet weak var amountOfBarrierSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !Storage.default.isNewUserPresentInStorage() {
            showGameInfo()
            Storage.default.isNewUser = false
        }
        print(Storage.default.isNewUser)
    }

    func setupScreen() {
        Storage.default.isContainsBorders = false
        setupLabel()
    }

    func setupLabel() {
        if !Storage.default.isSensitivityInStorage() {
            Storage.default.sensitivity = 0.3
            sensitivitySlider.value = Float(Storage.default.sensitivity)
        }
        if !Storage.default.isSpeedPresentInStorage() {
            Storage.default.speed = 0.3
            speedSlider.value = Float(Storage.default.speed)
        }
        if !Storage.default.isScorePresentInStorage() {
            Storage.default.score = 0
        }
        if !Storage.default.isAmountOfBarrierPresentInStorage() {
            Storage.default.amountOfBarrier = 3
            amountOfBarrierSlider.value = Float(Storage.default.amountOfBarrier) / 10
        }
        updateSpeedLabel()
        updateSensitivityLabel()
        updateScoreLabel()
        updateAmountIfBarrierLabel()
    }

    func updateScoreLabel() {
        bestScoreLabel.text = "Best score: " + String(Storage.default.score)
    }

    func updateSensitivityLabel() {
        sensativiyyLabel.text = "Sensitivity: " + String(Int(Storage.default.sensitivity * 10))
        sensitivitySlider.value = Float(Storage.default.sensitivity)

    }

    func updateAmountIfBarrierLabel() {
        amountOfBarrierLabel.text = "Amount of barrier: " + String(Storage.default.amountOfBarrier)
        amountOfBarrierSlider.value = Float(Storage.default.amountOfBarrier) / 10
    }

    func updateSpeedLabel() {
        speedLabel.text = "Snake speed: " + String(Int(Storage.default.speed * 10))
        speedSlider.value = Float(Storage.default.speed)
    }

    func showGameInfo() {
        let alertController = UIAlertController(title: "Game Info", message: "", preferredStyle: .alert)
        let image = #imageLiteral(resourceName: "InfoShake")
        alertController.addImage(image)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func showDemoInfo() {
        let message = "You can control your snake with voice. Say `Left` for turn left or `Right` for turn right. This demo version has a lot of bugs! But still funy :))"
        let alertController = UIAlertController(title: "Game Info", message: message, preferredStyle: .alert)
        let image = #imageLiteral(resourceName: "infoDemo")
        alertController.addImage(image)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func startDemoVersion() {
        if !Storage.default.isDemoVersionPresentInStorage() {
            showDemoInfo()
        }
        Storage.default.isDemoVersion = true
        performSegue(withIdentifier: "CameVC", sender: nil)
    }



    @IBAction func changeBorder(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "checkbox") {
            sender.setImage(UIImage(named: "checkmarkFilled"), for: .normal)
            Storage.default.isContainsBorders = true
        } else {
            sender.setImage(UIImage(named: "checkbox"), for: .normal)
            Storage.default.isContainsBorders = false
        }
    }

    @IBAction func sensitivityChange(_ sender: UISlider) {
       Storage.default.sensitivity = Double(sender.value)
        updateSensitivityLabel()
    }

    @IBAction func speedChange(_ sender: UISlider) {
        Storage.default.speed = Double(sender.value)
        updateSpeedLabel()
    }

    @IBAction func amountOfBarrier(_ sender: UISlider) {
        Storage.default.amountOfBarrier = Int(sender.value * 10.0)
        updateAmountIfBarrierLabel()
    }

    @IBAction func startDemoVersion(_ sender: UIButton) {
        startDemoVersion()
    }


    @IBAction func showInfoOfDemoVersion(_ sender: UIButton) {
        showDemoInfo()
    }

    @IBAction func showInfoPressed(_ sender: UIButton) {
        showGameInfo()
    }

}
