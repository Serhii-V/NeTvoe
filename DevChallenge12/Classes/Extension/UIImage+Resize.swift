//
//  UIImage+Resize.swift
//  DevChallenge12
//
//  Created by Serhii on 5/10/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

extension UIImage {
    func imageResize (sizeChange:CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}


