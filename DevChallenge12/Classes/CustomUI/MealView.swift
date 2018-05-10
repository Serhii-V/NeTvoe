//
//  MealView.swift
//  DevChallenge12
//
//  Created by Serhii on 5/9/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class MealView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, superviewSize: CGSize) {
        self.init(frame: frame)
        setupFrame(superviewSize: superviewSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupFrame(superviewSize: CGSize) {
        let borderWidth: Int = 5
        let bothBorderWidth: Int = borderWidth * 2
        let mealSize: Int = 10
        let superViewWidth: Int = Int(superviewSize.width)
        let superViewHeight: Int = Int(superviewSize.height)
        let maxCountOfPartsXline = (superViewWidth - bothBorderWidth - (superViewWidth % mealSize)) / mealSize
        let maxCountOfPartsYline = (superViewHeight - bothBorderWidth - (superViewHeight % mealSize)) / mealSize
        let xPosition = Int(arc4random_uniform(UInt32(maxCountOfPartsXline))) * mealSize + borderWidth
        let yPosition = Int(arc4random_uniform(UInt32(maxCountOfPartsYline))) * mealSize + borderWidth
        self.layer.backgroundColor = UIColor.black.cgColor
        self.frame = CGRect(x: xPosition, y: yPosition, width: mealSize, height: mealSize)
        self.setNeedsDisplay()
    }
}
