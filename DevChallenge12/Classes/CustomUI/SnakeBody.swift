//
//  SnakeBody.swift
//  DevChallenge12
//
//  Created by " " on 5/7/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit

protocol SnakeDelegate: NSObjectProtocol {
    func gameOver()
}

class SnakeBody: UIView {
    var delegate: SnakeDelegate?

    static let snake: UIView = UIView()
    let actions: SnakeActions = SnakeActions()
    let heightOfSnake: CGFloat = 10.0
    var bodyDirection: Direction = .right
    var withBorder: Bool = false
    var headPositionAfterLastRotate: CGPoint = CGPoint(x: 15, y: 5)
    var bodyArray: [PartOfSnakeView] = [
                                        PartOfSnakeView(frame: CGRect(x: 15, y: 5, width: 10, height: 10), partColor: UIColor.red),
                                        PartOfSnakeView(frame: CGRect(x: 5, y: 5, width: 10, height: 10), partColor: UIColor.blue)
                                        ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSnake()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addPart() {
        guard bodyArray.count != 0 else { return }
        let part = PartOfSnakeView(frame: CGRect(x: (bodyArray.last?.frame.origin.x)!, y: (bodyArray.last?.frame.origin.y)!, width: heightOfSnake, height: heightOfSnake), partColor: UIColor.blue)
            bodyArray.last?.changeColor(bodyColor: .black)
            bodyArray.append(part)
            drawSnake()
            self.setNeedsDisplay()
    }

    func returnPositionX() -> CGFloat {
        let x = bodyArray[0].frame.origin.x + deltaPositionX()
        guard let sWidth = superview?.bounds.size.width else { return x }
        if withBorder {
            return x
        }
        if x > sWidth - 15 {
            return 5.0
        } else if x < 0 {
            return sWidth - 15
        }
        return x
    }

    func returnPositionY() -> CGFloat {
        let y = bodyArray[0].frame.origin.y + deltaPositionY()
        guard let sHeight = superview?.bounds.size.height else { return y }
        if withBorder {
            return y
        }
        if y > sHeight - 15 {
            return 5.0
        } else if y < 0 {
            return sHeight - 15
        }
        return y
    }

    func drawSnake() {
        guard bodyArray.count != 0 else { return }
        let endIndex = bodyArray.count - 1
        for index in stride(from: endIndex, through: 0, by: -1) {
            self.addSubview(bodyArray[index])
        }
    }

    func deltaPositionX() -> CGFloat {
        if bodyDirection == .right {
            return 10.0
        } else if bodyDirection == .left {
            return -10.0
        } else {
            return 0.0
        }
    }

    func deltaPositionY() -> CGFloat {
        if bodyDirection == .down {
            return 10.0
        } else if bodyDirection == .up {
            return -10.0
        } else {
            return 0.0
        }
    }

    func isBitBorder(_ head: CGRect) -> Bool {
        let x = head.origin.x
        let y = head.origin.y
        guard let xMarge = superview?.bounds.size.width else { return false }
        guard let yMarge = superview?.bounds.size.height else { return false }
        guard x > 4.0, y > 4.0, x < xMarge - 15, y < yMarge - 15  else { return true }
        return false
    }

    func removeSnakeFromSuperView() {
        for i in bodyArray {
            i.removeFromSuperview()
        }
    }

    func restartSnake() {
        bodyArray.forEach { $0.removeFromSuperview() }
        bodyArray = [
                    PartOfSnakeView(frame: CGRect(x: 15, y: 5, width: 10, height: 10), partColor: UIColor.red),
                    PartOfSnakeView(frame: CGRect(x: 5, y: 5, width: 10, height: 10), partColor: UIColor.blue)
                    ]
        bodyDirection = .right
        drawSnake()
    }
}

extension SnakeBody {
    enum Direction {
        case up
        case down
        case left
        case right
    }
}
