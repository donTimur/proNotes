//
//  CGSizeExtenstion.swift
//  Student
//
//  Created by Leo Thomas on 06/12/15.
//  Copyright © 2015 leonardthomas. All rights reserved.
//

import UIKit

extension CGSize {

    mutating func increaseSize(float: CGFloat) -> CGSize {
        self.width += float
        self.height += float
        return self
    }
    
    mutating func increaseSize(size: CGSize) -> CGSize {
        self.width += size.width
        self.height += size.height
        return self
    }
    
    mutating func multiplySize(factor: CGFloat) {
        self.width *= factor
        self.height *= factor
    }

    static func dinA4() -> CGSize {
        return CGSize(width: 2384, height: 3370)
    }
    
    static func dinA4LandScape() -> CGSize {
        let size = dinA4()
        return CGSize(width: size.height, height: size.width)
    }
    
    static func quadratic() -> CGSize {
        return CGSize(width: 2384, height: 2384)
    }
    
    static func paperSizes() -> [CGSize] {
        return [dinA4(), quadratic(), dinA4LandScape()]
    }
    
}