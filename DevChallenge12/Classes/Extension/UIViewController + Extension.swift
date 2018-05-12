//
//  UIViewController + Extension.swift
//  DevChallenge12
//
//  Created by " " on 5/9/18.
//  Copyright © 2018 " ". All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // check user defaults data by key
    func isUserDefaultsAlreadyExist(_ key: String) -> Bool {
        let userDefaults : UserDefaults = UserDefaults.standard

        if userDefaults.object(forKey: key) != nil {
            return true
        }
        return false
    }
}
