//
//  GameVC.swift
//  DevChallenge12
//
//  Created by " " on 5/7/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    @IBOutlet weak var gameAreaView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    var gameHistoryLog: [GameHistory] = []
    var snake: SnakeBody = SnakeBody()
    var meal: MealView = MealView()
    var lastRotation: Double = 0.0
    var deltaRotation: Double = 0.0
    var barrierArray: [BarrierView] = []
    var isGameOver: Bool = false {
        didSet {
            self.view.layer.backgroundColor = UIColor.red.cgColor
            if isGameOver {
                showGameOverAlert()
            }
        }
    }
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            if score > Storage.default.score {
                Storage.default.score = score
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isEnabled = true
        gameHistoryLog.removeAll()
        setupGameArea()
        gameAreaView.addSubview(snake)
        snake.actions.delegate = self
        snake.delegate = self
        moveSnake()
        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AccelerometerHandler.accelerometrManager.runAccelerometer(snake)
    }

    //
    func setupGameArea() {
        createBarriers()
        gameAreaView.addSubview(meal)
        meal.changeMeelPosition(sView: gameAreaView)
        checkMealWithBoarder()
        if Storage.default.isContainsBorders {
            gameAreaView.layer.borderWidth = 5.0
            gameAreaView.layer.borderColor = UIColor.black.cgColor
            snake.withBorder = true
        } else {
            snake.withBorder = false
        }
    }

    func createBarriers() {
        let amount = Storage.default.amountOfBarrier
        if amount != 0 {
            for _ in 0..<amount {
                barrierArray.append(unicBarrier())
            }
            barrierArray.forEach {self.gameAreaView.addSubview($0)
                $0.borderPosition(sView: gameAreaView)
            }
        }
    }

    func unicBarrier() -> BarrierView {
        let new = BarrierView()
        new.borderPosition(sView: gameAreaView)
        for i in barrierArray {
            if i.frame.intersects(new.frame) {
                return unicBarrier()
            }
        }
        return new
    }
//        if
//        for i in borderArray {
//            if i.frame.intersects(self.meal.frame) {
//                meal.changeMeelPosition(sView: gameAreaView)
//                checkMealWithBoarder()
//            }
//        }
//    }

    func checkMealWithBoarder() {
        for i in barrierArray {
            if i.frame.intersects(self.meal.frame) {
                meal.changeMeelPosition(sView: gameAreaView)
                checkMealWithBoarder()
            }
        }
    }

    func moveSnake() {
        var addPart = false
        snake.actions.move(snake: self.snake, array: barrierArray)
        guard !isGameOver else { return }
        if snake.actions.isSnakeAteMeal(meal.frame, snake: self.snake) {
            snake.addPart()
            score += 1
            addPart = true
            meal.changeMeelPosition(sView: gameAreaView)
        } 
        gameHistoryLog.append(GameHistory(addPart: addPart, headPosition: snake.bodyArray[0].frame.origin, meal: meal.frame.origin))
        delayWithSeconds(1.03 - Storage.default.speed) {
            self.moveSnake()
        }
    }

    func startNewGame() {
        snake.restartSnake()
        self.meal.changeMeelPosition(sView: gameAreaView)
        self.view.layer.backgroundColor = UIColor.blue.cgColor
        scoreLabel.text = "Score: 0"
        setupGameArea()
        gameAreaView.addSubview(snake)
    }

    func restartGame() {
        gameHistoryLog.removeAll()
        self.isGameOver = false
        snake.restartSnake()
        self.meal.changeMeelPosition(sView: gameAreaView)
        self.view.layer.backgroundColor = UIColor.blue.cgColor
        scoreLabel.text = "Score: 0"
        if Storage.default.isContainsBorders {
            gameAreaView.layer.borderWidth = 5.0
            gameAreaView.layer.borderColor = UIColor.black.cgColor
            snake.withBorder = true
        } else {
            snake.withBorder = false
        }
        self.moveSnake()
    }

    func showGameOverAlert() {
        let alert = UIAlertController.init(title: "Game Over" , message: "Your score: \(score) \n Try more.", preferredStyle: .actionSheet)
        alert.addImage(#imageLiteral(resourceName: "gameOver"))
        let tryAction = UIAlertAction(title: "Try more", style: .default) { (alert) in
            self.restartGame()
            self.restartButton.isEnabled = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            self.returnToMenu()
        }
        let showLastGameAction = UIAlertAction(title: "Watch game recording", style: .default) { alert in
            self.showGameRecording()
        }
        alert.addAction(tryAction)
        alert.addAction(cancelAction)
        alert.addAction(showLastGameAction)
        self.present(alert, animated: true, completion: nil)

    }

    func showGameRecording() {
        restartButton.isEnabled = false
        self.isGameOver = false
        snake.restartSnake()
        self.view.layer.backgroundColor = UIColor.blue.cgColor
        if Storage.default.isContainsBorders {
            gameAreaView.layer.borderWidth = 5.0
            gameAreaView.layer.borderColor = UIColor.black.cgColor
            snake.withBorder = true
        } else {
            snake.withBorder = false
        }
        moveToPosition()
    }

    func moveToPosition(_ index: Int = 0 ) {
        let lastIndex: Int = gameHistoryLog.count - 1
        let savedPosition = gameHistoryLog[index]
        self.meal.frame.origin = savedPosition.meelFrame
        delayWithSeconds(0.2) {
            if savedPosition.addPart {
                self.snake.addPart()
                self.snake.actions.moveTo(snake: self.snake, newPosition: savedPosition.headPosition)
            } else {
                self.snake.actions.moveTo(snake: self.snake, newPosition: savedPosition.headPosition)
            }
            if index < lastIndex {
                self.moveToPosition(index + 1)
            } else {
                self.isGameOver = true
            }
        }
    }

    func returnToMenu() {
        performSegue(withIdentifier: "mainVC", sender: nil)
        for i in gameHistoryLog {
            print(i.addPart)
            print(i.headPosition)
            print(i.meelFrame)
        }
    }

    @IBAction func restart(_ sender: UIButton) {
       restartGame()
    }

    @IBAction func returnToMenu(_ sender: Any) {
        returnToMenu()
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
