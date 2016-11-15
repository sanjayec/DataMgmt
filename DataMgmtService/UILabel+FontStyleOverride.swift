//
//  UILabel+FontStyleOverride.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/13/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit


extension UILabel {
    var substituteFontNameLight : String {
        get { return self.font.fontName }
        set {
           // print(self.font.fontName)
            if self.font.fontName.range(of: "Light") != nil {
                
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName == ".SFUIText" {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    var substituteFontNameSemibold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName == ".SFUIText-Semibold" {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "Bold") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
        

}
