//
//  Style.swift
//  bo
//
//  Created by Tony O' Hare on 21/02/2017.
//  Copyright © 2017 Fusio. All rights reserved.
//

import UIKit

class Class:NSObject {
    // MARK: Vars
    var classData:[String:AnyObject] = [:]
    
    // MARK: - Public API
    public override init() {
        super.init()
        self.setDefaultStyling()
    }
    
    public func called(_ className:String) -> [String:AnyObject] {
        let path = Bundle.main.path(forResource: "Stylesheet", ofType: "plist")
        let plistData = NSDictionary(contentsOfFile: path!) as? [String: Any]
        
        if let classSettings = plistData?[className] as? [String:String] {
            self.setFont(to: classSettings)
            self.setLineHeightAlignmentAndOverflow(to: classSettings)
        }
        
        return classData
    }
    
    // MARK: - Private Getters
    private func getAlignment(from settings:[String:String]) -> NSTextAlignment {
        if let alignment:String = settings["align"] {
            switch alignment {
            case "left":
                return .left
            case "centre":
                return .center
            case "right":
                return .right
            case "justified":
                return .justified
            case "natural":
                return .natural
            default:
                return DefaultAlignment
            }
        }
        return DefaultAlignment
    }
    
    private func getFloat(called number:String, or defaultNumber:CGFloat, from settings:[String:String]) -> CGFloat{
        if let parsedNumber = NumberFormatter().number(from: settings[number] ?? "") {
            return CGFloat(parsedNumber)
        }
        
        return defaultNumber
    }
    
    private func getLineBreakMode(from settings:[String:String]) -> NSLineBreakMode {
        if let overflow:String = settings["overflow"] {
            switch overflow {
            case "wordWrap":
                return .byWordWrapping
            case "charWrap":
                return .byCharWrapping
            case "clip":
                return .byClipping
            case "truncateHead":
                return .byTruncatingHead
            case "truncateTail":
                return .byTruncatingTail
            case "truncateMiddle":
                return .byTruncatingMiddle
            default:
                return DefaultLineBreakMode
            }
        }
        
        return DefaultLineBreakMode
    }

    private func getLineHeight(from settings:[String:String]) -> CGFloat {
        return self.getFloat(called: "lineHeight", or: DefaultLineHeight, from: settings)
    }
    
    // MARK: - Private Setters
    private func setDefaultStyling() {
        let defaultRules = NSMutableParagraphStyle()
        defaultRules.maximumLineHeight = DefaultLineHeight
        defaultRules.minimumLineHeight = DefaultLineHeight
        defaultRules.lineBreakMode = DefaultLineBreakMode
        defaultRules.alignment = DefaultAlignment
        
        self.classData = [
            NSFontAttributeName:UIFont(name: DefaultFont, size: DefaultFontSize)!,
            NSParagraphStyleAttributeName: defaultRules
        ]
        
    }
    
    private func setFont(to fontSettings:[String:String]) {
        if fontSettings["font"] != nil {
            classData[NSFontAttributeName] = UIFont(
                name: fontSettings["font"] ?? DefaultFont,
                size: self.getFloat(called: "font-size", or: DefaultFontSize, from: fontSettings)
                )!
        }
    }
    
    private func setLineHeightAlignmentAndOverflow(to settings:[String:String]) {
        let rules = NSMutableParagraphStyle()
        rules.maximumLineHeight = self.getLineHeight(from: settings)
        rules.minimumLineHeight = self.getLineHeight(from: settings)
        rules.lineBreakMode = self.getLineBreakMode(from: settings)
        rules.alignment = self.getAlignment(from: settings)
        
        classData[NSParagraphStyleAttributeName] = rules
    }
}

extension Class {
    var DefaultFont:String {
        get { return "HelveticaNeue-Thin" }
    }
    
    var DefaultFontSize:CGFloat {
        get { return 16 }
    }
    
    var DefaultLineBreakMode:NSLineBreakMode {
        get { return .byWordWrapping }
    }
    
    var DefaultAlignment:NSTextAlignment {
        get { return .left }
    }
    
    var DefaultLineHeight:CGFloat {
        get { return 32 }
    }

}
