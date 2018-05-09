//
//  UIViewController + Extension.swift
//  DevChallenge12
//
//  Created by Serhii on 5/9/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func isUserDefaultsAlreadyExist(_ key: String) -> Bool {
        let userDefaults : UserDefaults = UserDefaults.standard

        if userDefaults.object(forKey: key) != nil {
            return true
        }
        return false
    }
}
