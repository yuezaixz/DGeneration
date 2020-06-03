//
//  DGCoreAppInfo.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

public class SWAppInfo {
    /// Returns app's name
    public static var appDisplayName: String {
        let bundleDisplayName = self.bundleDisplayName
        if bundleDisplayName.count > 0 {
            return bundleDisplayName
        } else {
            return self.bundleName
        }
    }
    
    /// Return bundle display name
    public static var bundleDisplayName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }
    
    /// Return bundle name
    public static var bundleName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
    
    /// Returns app's version number
    public static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    /// Return app's build number
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? ""
    }
    
    /// Return app's bundle ID
    public static var appBundleID: String {
        return Bundle.main.bundleIdentifier  ?? ""
    }
    
    /// Return app's shceme, the scheme's Identifier must set main
    public static func scheme () -> String {
        if let infoDic = Bundle.main.infoDictionary, let bundleUrltypes = infoDic["CFBundleURLTypes"] as? [[String: Any]] {
            for item in bundleUrltypes {
                if let schemesName = item["CFBundleURLName"] as? String, schemesName == "main", let urlSchemes = item["CFBundleURLSchemes"] as? [String] {
                    return urlSchemes[0] + "://"
                }
            }
        }
        return ""
    }
    
    /// Returns true if its simulator and not a device //TODO: Add to readme
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
}
