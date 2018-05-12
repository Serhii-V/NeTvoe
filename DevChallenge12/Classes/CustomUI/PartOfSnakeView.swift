//
//  partOfSnake.swift
//  DevChallenge12
//
//  Created by " " on 5/7/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit

class PartOfSnakeView: UIView {
    init(frame: CGRect, partColor: UIColor) {
        super.init(frame: frame)
        setupView(frame: frame, partColor: partColor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(frame: CGRect, partColor: UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.backgroundColor = partColor.cgColor
    }

    func changePosition(xPosition: CGFloat, yPosition: CGFloat) {
        self.frame.origin.x = xPosition
        self.frame.origin.y = yPosition
        self.setNeedsDisplay()
    }

    func changeColor(bodyColor: UIColor) {
        self.layer.backgroundColor = bodyColor.cgColor
        self.setNeedsDisplay()
    }
}
