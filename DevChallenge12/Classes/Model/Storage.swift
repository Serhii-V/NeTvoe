//
//  Storage.swift
//  DevChallenge12
//
//  Created by " " on 5/11/18.
//  Copyright © 2018 " ". All rights reserved.
//

import Foundation

class Storage {
    static let `default`: Storage = Storage()
    private let userDefaults = UserDefaults.standard
    private let isContainsBorderKey: String = "isWithBorder"
    private let sensitivityKey: String = "sensitivity"
    private let scoreKey: String = "score"
    private let speedKey: String = "speed"
    private let isNewUserKey: String = "isNewUser"
    private let amountOfBarrierKey: String = "amountOfBarrier"
    private let isDemoVersionKey: String = "isDemoVersionKey"

    var isContainsBorders: Bool {
        get {
            return userDefaults.bool(forKey: isContainsBorderKey)
        }

        set {
            userDefaults.set(newValue, forKey: isContainsBorderKey)
        }
    }

    var sensitivity: Double {
        get {
            return userDefaults.double(forKey: sensitivityKey)
        }

        set {
            userDefaults.set(newValue, forKey: sensitivityKey)
        }
    }

    var score: Int {
        get {
            return userDefaults.integer(forKey: scoreKey)
        }

        set {
            userDefaults.set(newValue, forKey: scoreKey)
        }
    }

    var speed: Double {
        get {
            return userDefaults.double(forKey: speedKey)
        }

        set {
            userDefaults.set(newValue, forKey: speedKey)
        }
    }

    var isNewUser: Bool {
        get {
            return userDefaults.bool(forKey: isNewUserKey)
        }
        set {
            userDefaults.set(newValue, forKey: isNewUserKey)
        }
    }

    var amountOfBarrier: Int {
        get {
            return userDefaults.integer(forKey: amountOfBarrierKey)
        }
        set {
            userDefaults.set(newValue, forKey: amountOfBarrierKey)
        }
    }

    var isDemoVersion: Bool {
        get {
            return userDefaults.bool(forKey: isDemoVersionKey)
        }

        set {
            userDefaults.set(newValue, forKey: isDemoVersionKey)
        }
    }

    private init() {

    }

    func isNewUserPresentInStorage() -> Bool {
        return userDefaults.object(forKey: isNewUserKey) != nil
    }

    func isSensitivityInStorage() -> Bool {
        return userDefaults.object(forKey: sensitivityKey) != nil
    }

    func isSpeedPresentInStorage() -> Bool {
        return userDefaults.object(forKey: speedKey) != nil
    }

    func isScorePresentInStorage() -> Bool {
        return userDefaults.object(forKey: scoreKey) != nil
    }

    func isAmountOfBarrierPresentInStorage() -> Bool {
        return userDefaults.object(forKey: amountOfBarrierKey) != nil
    }

    func isDemoVersionPresentInStorage() -> Bool {
        return userDefaults.object(forKey: isDemoVersionKey) != nil
    }

}
