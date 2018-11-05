//
//  Document+UIViewExtension.swift
//  proNotesUITests
//
//  Created by Timur Khasanov on 11/5/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//
import UIKit

extension UIImage {
    
    var removingStatusBar: UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        let yOffset = 22 * scale
        let rect = CGRect(
            x: 0,
            y: Int(yOffset),
            width: cgImage.width,
            height: cgImage.height - Int(yOffset)
        )
        
        if let croppedCGImage = cgImage.cropping(to: rect) {
            return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
        }
        
        return nil
    }
}
