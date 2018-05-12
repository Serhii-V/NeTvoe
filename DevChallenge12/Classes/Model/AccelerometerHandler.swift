//
//  AccelerometerHandler.swift
//  DevChallenge12
//
//  Created by " " on 5/11/18.
//  Copyright © 2018 " ". All rights reserved.
//

import Foundation
import CoreMotion


class AccelerometerHandler {
    static var accelerometrManager = AccelerometerHandler()
    var motionManager = CMMotionManager()
    var lastRotation: Double = 0.0
    var deltaRotation: Double = 0.0
    let sensitivity: Double = UserDefaults.standard.double(forKey: "sensitivity")

    func runAccelerometer(_ snake: SnakeBody ) {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            guard let xRotation = data?.acceleration.x else { return }
            self.deltaRotation = xRotation - self.lastRotation
            if self.deltaRotation > self.sensitivity, xRotation > 0 {
                snake.actions.turnRight(snake: snake)
            } else if self.deltaRotation < -self.sensitivity, xRotation < 0 {
                snake.actions.turnLeft(snake: snake)
            }
            self.lastRotation = xRotation
        }
    }
}
