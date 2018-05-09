//
//  MainVC.swift
//  DevChallenge12
//
//  Created by Serhii on 5/7/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var borderButton: UIButton!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var sensitivitySlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var sensativiyyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

    func setupScreen() {
        defaults.set(false, forKey: "isWithBorder")
        setupLabel()
    }

    func setupLabel() {
        if !isUserDefaultsAlreadyExist("sensitivity") {
            defaults.set(0.3, forKey: "sensitivity")
        }
        if !isUserDefaultsAlreadyExist("speed") {
            defaults.set(0.3, forKey: "speed")
        }
        if !isUserDefaultsAlreadyExist("score") {
            defaults.set(0, forKey: "score")
        }
        updateSpeedLabel()
        updateSensitivityLabel()
        updateScoreLabel()
        sensitivitySlider.value = Float(defaults.double(forKey: "sensitivity"))
        speedSlider.value = Float(defaults.double(forKey: "speed"))
    }

    func updateScoreLabel() {
        bestScoreLabel.text = "Score: " + String(defaults.integer(forKey: "score"))
    }

    func updateSensitivityLabel() {
        sensativiyyLabel.text = "Sensitivity: " + String(Int(defaults.double(forKey: "sensitivity") * 10))
    }

    func updateSpeedLabel() {
        speedLabel.text = "Snake speed: " + String(Int(defaults.double(forKey: "speed") * 10))
    }

    @IBAction func changeBorder(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "checkbox") {
            sender.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
            defaults.set(true, forKey: "isWithBorder")
        } else {
            sender.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
            defaults.set(false, forKey: "isWithBorder")
        }
    }

    @IBAction func sensitivityChange(_ sender: UISlider) {
        defaults.set(sender.value, forKey: "sensitivity")
        updateSensitivityLabel()
    }

    @IBAction func speedChange(_ sender: UISlider) {
        defaults.set(sender.value, forKey: "speed")
        updateSpeedLabel()
    }
}
