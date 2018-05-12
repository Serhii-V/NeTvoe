//
//  GameHistory.swift
//  DevChallenge12
//
//  Created by " " on 5/10/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit


class GameHistory {
    var addPart: Bool = false
    var headPosition: CGPoint = CGPoint(x: 15, y: 5)
    var meelFrame: CGPoint = CGPoint(x: 0, y: 0)

    init(addPart: Bool = false, headPosition: CGPoint, meal: CGPoint) {
        self.addPart = addPart
        self.headPosition = headPosition
        self.meelFrame = meal
    }
}


