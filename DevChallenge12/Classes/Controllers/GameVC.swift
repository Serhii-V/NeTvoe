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
    @IBOutlet weak var scoreLabel: UILabel!

    var snake: SnakeBody = SnakeBody()
    var withBorder: Bool = false
    var isGameOver: Bool = false {
        didSet {
            self.view.layer.backgroundColor = UIColor.red.cgColor
        }
    }
    var meal: MealView = MealView()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameArea()
        startGame()
        snake.delegate = self
        moveSnake()
    }



    func startGame() {
        gameAreaView.addSubview(snake)
    }

    func setupGameArea() {
        meal.setupFrame(superView: gameAreaView)
        gameAreaView.addSubview(meal)
        if withBorder {
            gameAreaView.layer.borderWidth = 5.0
            gameAreaView.layer.borderColor = UIColor.black.cgColor
            snake.withBorder = true
        } else {
            snake.withBorder = false
        }
    }

    func moveSnake() {
        snake.move()
        if snake.isSnakeAteMeal(meal.frame) {
            snake.addPart()
            score += 1
            meal.removeFromSuperview()
            meal.setupFrame(superView: gameAreaView)
            gameAreaView.addSubview(meal)
        }
        if !isGameOver {
            delayWithSeconds(0.5) {
                self.moveSnake()
            }
        }
    }

    @IBAction func turnLeft(_ sender: UIButton) {
        snake.turnLeft()
    }

    @IBAction func turnRight(_ sender: UIButton) {
        snake.turnRight()
    }

}

extension GameVC {
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}

extension GameVC: SnakeDelegate {
    func gameOver() {
        isGameOver = true
    }
}
