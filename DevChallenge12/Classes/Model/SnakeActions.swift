//
//  SnakeActions.swift
//  DevChallenge12
//
//  Created by " " on 5/10/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit


class SnakeActions {
    var delegate: SnakeDelegate?
    let heightOfSnake: CGFloat = 10.0

    func move(snake: SnakeBody, array: [BarrierView] ) {
        guard !isSnakeBitHimself(snake) else {
            delegate?.gameOver();
            return
        }
        guard !isSnakeBitBarrier(snake, array: array) else {
            delegate?.gameOver();
            return
        }
        let newFrame = CGRect(x: snake.returnPositionX(), y: snake.returnPositionY(), width: self.heightOfSnake, height: self.heightOfSnake)
        if snake.withBorder {
            guard !snake.isBitBorder(newFrame) else {
                delegate?.gameOver()
                return
                
            }
        }
        for index in stride(from: snake.bodyArray.count - 1, to: 0, by: -1 ) {
            snake.bodyArray[index].frame = snake.bodyArray[index - 1].frame
        }
        snake.bodyArray.first?.frame = newFrame
    }

    func moveTo(snake: SnakeBody, newPosition: CGPoint) {
        for index in stride(from: snake.bodyArray.count - 1, to: 0, by: -1 ) {
            snake.bodyArray[index].frame = snake.bodyArray[index - 1].frame
        }
        snake.bodyArray.first?.frame = CGRect(x: newPosition.x, y: newPosition.y, width: 10, height: 10)
    }

    func isSnakeBitHimself(_ snake: SnakeBody) -> Bool {
        var currentState = false
        for i in snake.bodyArray {
            guard i != snake.bodyArray[0] else { continue }
            guard currentState != true else { break }
            currentState = snake.bodyArray[0].frame.intersects(i.frame)
        }
        return currentState
    }

    func isSnakeBitBarrier(_ snake: SnakeBody, array: [BarrierView]) -> Bool {
        var currentState = false
        array.forEach {
            if $0.frame.intersects((snake.bodyArray.first?.frame)!) {
                currentState = true
            }
        }
        return currentState
    }

    func turnRight(snake: SnakeBody) {
        guard snake.headPositionAfterLastRotate != snake.bodyArray[0].frame.origin else { return }
        switch snake.bodyDirection {
        case .up:
            snake.bodyDirection = .right
        case .left:
            snake.bodyDirection = .up
        case .down:
            snake.bodyDirection = .left
        case .right:
            snake.bodyDirection = .down
        }
        snake.headPositionAfterLastRotate = snake.bodyArray[0].frame.origin
    }

    func turnLeft(snake: SnakeBody) {
        guard snake.headPositionAfterLastRotate != snake.bodyArray[0].frame.origin else { return }
        switch snake.bodyDirection {
        case .up:
            snake.bodyDirection = .left
        case .left:
            snake.bodyDirection = .down
        case .down:
            snake.bodyDirection = .right
        case .right:
            snake.bodyDirection = .up
        }
        snake.headPositionAfterLastRotate = snake.bodyArray[0].frame.origin
    }

    func increaseBody(snake: SnakeBody) {
        snake.addPart()
    }

    func isSnakeAteMeal(_ meal: CGRect, snake: SnakeBody) -> Bool {
        return snake.bodyArray[0].frame.intersects(meal)
    }

}
