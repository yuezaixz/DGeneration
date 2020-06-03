//
//  DGCoreDocumentPath.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

public class DGCoreDocumentPath: NSObject {
    
    public class func homePath() -> String? {
        let path = NSHomeDirectory()
        return path
    }
    
    public class func documentPath() -> String? {
        var documentPath: String?
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            documentPath = paths[0]
        }
        return documentPath
    }
    
    public class func tmpPath() -> String? {
        let path = NSTemporaryDirectory()
        return path
    }
    
    public class func cachePath() -> String? {
        var cachesPath: String?
        if SWAppInfo.isSimulator {
            cachesPath = "/tmp"
        } else {
            let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
            if paths.count > 0 {
                cachesPath = paths[0]
            }
        }
        return cachesPath
    }
    
    public class func homePath(withFileName fileName: String?) -> String? {
        let filePath = self.rootPath(self.homePath(), withFileName: fileName)
        return filePath
    }
    
    public class func documentPath(withFileName fileName: String?) -> String? {
        let filePath = self.rootPath(self.documentPath(), withFileName: fileName)
        return filePath
    }
    
    public class func tmpPath(withFileName fileName: String?) -> String? {
        let filePath = self.rootPath(self.tmpPath(), withFileName: fileName)
        return filePath
    }
    
    public class func cachePath(withFileName fileName: String?) -> String? {
        let filePath = self.rootPath(self.cachePath(), withFileName: fileName)
        return filePath
    }
    
    public class func rootPath(_ rootPath: String?, withFileName fileName: String?) -> String? {
        var filePath = ""
        if let root = rootPath, let name = fileName {
            filePath = root + "/" + "\(name)"
        }
        
        return filePath
    }

}

