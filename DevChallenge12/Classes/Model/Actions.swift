//
//  Actions.swift
//  DevChallenge12
//
//  Created by Serhii on 5/8/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

extension SnakeBody {
//    func move() {
//        guard !isSnakeBitHimself() else { delegate?.gameOver(); return }
//        addPart()
//        var lastIndex = bodyArray.count - 1
//        bodyArray[lastIndex].removeFromSuperview()
//        bodyArray.removeLast()
//        lastIndex = bodyArray.count - 1
//        bodyArray[lastIndex].changeColor(bodyColor: .blue)
//    }
    
    func move() {
        let newFrame = CGRect(x: returnPositionX(), y: returnPositionY(), width: heightOfSnake, height: heightOfSnake)
        for index in stride(from: self.bodyArray.count - 1, to: 0, by: -1 ) {
            self.bodyArray[index].frame = self.bodyArray[index - 1].frame
        }
        self.bodyArray.first?.frame = newFrame
    }

    func isSnakeBitHimself() -> Bool {
        var currentState = false
        for i in bodyArray {
            guard i != bodyArray[0] else { continue }
            guard currentState != true else { break }
            currentState = bodyArray[0].frame.intersects(i.frame)
        }
        return currentState
    }

    func turnRight() {
        guard headPositionAfterLastRotate != bodyArray[0].frame.origin else { return }
        switch bodyDirection {
        case .up:
            bodyDirection = .right
        case .left:
            bodyDirection = .up
        case .down:
            bodyDirection = .left
        case .right:
            bodyDirection = .down
        }
        headPositionAfterLastRotate = bodyArray[0].frame.origin
    }

    func turnLeft() {
        guard headPositionAfterLastRotate != bodyArray[0].frame.origin else { return }
        switch bodyDirection {
        case .up:
            bodyDirection = .left
        case .left:
            bodyDirection = .down
        case .down:
            bodyDirection = .right
        case .right:
            bodyDirection = .up
        }
        headPositionAfterLastRotate = bodyArray[0].frame.origin
    }

    func increaseBody() {
        self.addPart()
    }

    func isSnakeAteMeal(_ meal: CGRect) -> Bool {
        return bodyArray[0].frame.intersects(meal)
    }
}
