//
//  GameVC.swift
//  DevChallenge12
//
//  Created by Serhii on 5/7/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    @IBOutlet weak var gameAreaView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var addPart: UIButton!
    @IBOutlet weak var move: UIButton!

    var snake: SnakeBody = SnakeBody()
    var withBorder: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameArea()
        startGame()
        snake.delegate = self
    }



    func startGame() {
        gameAreaView.addSubview(snake)
    }

    func setupGameArea() {
        if withBorder {
            gameAreaView.layer.borderWidth = 5.0
            gameAreaView.layer.borderColor = UIColor.black.cgColor
            snake.withBorder = true
        } else {
            snake.withBorder = false
        }
    }

    @IBAction func turnLeft(_ sender: UIButton) {
        snake.turnLeft()
    }

    @IBAction func turnRight(_ sender: UIButton) {
        snake.turnRight()
    }

    @IBAction func addPart(_ sender: UIButton) {
        snake.addPart()
    }

    @IBAction func move(_ sender: UIButton) {
        snake.move()
    }


}

extension GameVC: SnakeDelegate {
    func gameOver() {
        self.view.layer.backgroundColor = UIColor.red.cgColor
    }
}
