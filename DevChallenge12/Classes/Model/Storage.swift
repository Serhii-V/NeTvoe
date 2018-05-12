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

    private init() {

    }



}
