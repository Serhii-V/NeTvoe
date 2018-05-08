//
//  SnakeBody.swift
//  DevChallenge12
//
//  Created by Serhii on 5/7/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class SnakeBody: UIView {
    var delegate: SnakeDelegate?

    static let snake: UIView = UIView()
    let heightOfSnake: CGFloat = 10.0
    var bodyDirection: Direction = .right
    var withBorder: Bool = false
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
        bodyArray[0].changeColor(bodyColor: .black)
        let part = PartOfSnakeView(frame: CGRect(x: returnPositionX(), y: returnPositionY(), width: heightOfSnake, height: heightOfSnake), partColor: UIColor.red)
        if withBorder {
            guard !isBitBorder(part) else {delegate?.gameOver(); return}
        }
        bodyArray.insert(part, at: 0)
        drawSnake()
        self.setNeedsDisplay()
    }

    func returnPositionX() -> CGFloat {
        let x = bodyArray[0].frame.origin.x + deltaPositionX()
        guard let sWidth = superview?.bounds.size.width else {return x}
        if x > sWidth - 10 {
            return 0.0
        } else if x < 0 {
            return sWidth - 10
        }
        return x
    }

    func returnPositionY() -> CGFloat {
        let y = bodyArray[0].frame.origin.y + deltaPositionY()
        guard let sHeight = superview?.bounds.size.height else {return y}
        if y > sHeight - 10 {
            return 0.0
        } else if y < 0 {
            return sHeight - 10
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

    func isBitBorder(_ head: PartOfSnakeView) -> Bool {
        let x = frame.origin.x
        let y = frame.origin.y
        guard let xMarge = superview?.bounds.size.width else {return false}
        guard let yMarge = superview?.bounds.size.width else {return false}
        guard x > 5.0, y > 5.0, x < xMarge, y < yMarge else {return true}
        return false
    }

    func removeSnakeFromSuperView() {
        for i in bodyArray {
            i.removeFromSuperview()
        }
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
