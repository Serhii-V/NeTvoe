//
//  UIAlertController+Image.swift
//  DevChallenge12
//
//  Created by Serhii on 5/10/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addImage(_ image: UIImage) {
        let maxSize = CGSize(width: 245, height: 300)
        let imageSize = image.size
        let ratio = imageSize.width > imageSize.height ? maxSize.width / imageSize.width : maxSize.height / imageSize.height
        let scaledSize = CGSize(width: imageSize.width * ratio, height: imageSize.height * ratio)
        let resizedImage = image.imageResize(sizeChange: scaledSize)


        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
}
