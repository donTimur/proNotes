//
//  main.swift
//  proNotes
//
//  Created by Timur Khasanov on 10/28/18.
//  Copyright © 2018 leonardthomas. All rights reserved.
//

import Foundation
import UIKit

enum AppReset {
    static func resetKeychain() {
        let secClasses = [
            kSecClassGenericPassword as String,
            kSecClassInternetPassword as String,
            kSecClassCertificate as String,
            kSecClassKey as String,
            kSecClassIdentity as String
        ]
        for secClass in secClasses {
            let query = [kSecClass as String: secClass]
            SecItemDelete(query as CFDictionary)
        }
    }
}

_ = autoreleasepool {
    
    if ProcessInfo().arguments.contains("--Reset") {
        AppReset.resetKeychain()
    }
    
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to:
            UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
        nil,
        NSStringFromClass(AppDelegate.self)
    )

}

