//
//  GameVC.swift
//  DevChallenge12
//
//  Created by Serhii on 5/7/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit
import CoreMotion

class GameVC: UIViewController {
    @IBOutlet weak var gameAreaView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    var snake: SnakeBody = SnakeBody()
    let defaults = UserDefaults.standard
    var withBorder: Bool = UserDefaults.standard.bool(forKey: "isWithBorder")
    var motionManager = CMMotionManager()
    var lastRotation: Double = 0.0
    var deltaRotation: Double = 0.0
    let sensitivity: Double = UserDefaults.standard.double(forKey: "sensitivity")
    var isGameOver: Bool = false {
        didSet {
            self.view.layer.backgroundColor = UIColor.red.cgColor
        }
    }
    var meal: MealView = MealView()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            if score > defaults.integer(forKey: "score") {
                defaults.set(score, forKey: "score")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameArea()
        startGame()
        snake.delegate = self
        moveSnake()
        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            guard let xRotation = data?.acceleration.x else {return}
            self.deltaRotation = xRotation - self.lastRotation
            print(self.deltaRotation)
            if self.deltaRotation > self.sensitivity, xRotation > 0 {
                self.snake.turnRight()
            } else if self.deltaRotation < -self.sensitivity, xRotation < 0 {
                self.snake.turnLeft()
            }
            self.lastRotation = xRotation
        }
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
            delayWithSeconds(1.03 - defaults.double(forKey: "speed")) {
                self.moveSnake()
            }
        }
    }

    func startNewGame() {
        self.snake.removeSnakeFromSuperView()
        self.snake = SnakeBody()
        self.meal.removeFromSuperview()
        self.view.layer.backgroundColor = UIColor.blue.cgColor
        scoreLabel.text = "Score: 0"
        setupGameArea()
        startGame()


    }

    @IBAction func restart(_ sender: UIButton) {
       startNewGame()
    }

    @IBAction func returnToMenu(_ sender: UIButton) {
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
