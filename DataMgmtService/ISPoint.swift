//
//  ISPoint.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/7/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

open class ISPoint {
    
    open var title:String
    open var description:String?
    open var pointColor:UIColor
    open var lineColor:UIColor
    open var touchUpInside:Optional<(_ point:ISPoint, _ sliderValue: Float) -> Void>
    open var fill:Bool
    open var pointValue:Float
    open var pointObject:Any
    open var objectType:String
    
    public init(title:String, description:String, pointColor:UIColor, lineColor:UIColor, touchUpInside:Optional<(_ point:ISPoint, _ sliderValue: Float) -> Void>, fill:Bool, pointValue: Float, pointObject: Any, type: String) {
        self.title = title
        self.description = description
        self.pointColor = pointColor
        self.lineColor = lineColor
        self.touchUpInside = touchUpInside
        self.fill = fill
        self.pointValue = pointValue
        self.pointObject = pointObject
        self.objectType = type
    }
    
    public convenience init(title:String, description:String, touchUpInside:Optional<(_ point:ISPoint, _ sliderValue: Float) -> Void>,  pointValue: Float, pointObject: Any, type: String) {
        let defaultColor = UIColor.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        self.init(title: title, description: description, pointColor: defaultColor, lineColor: defaultColor, touchUpInside: touchUpInside, fill: false,  pointValue:pointValue, pointObject: pointObject, type: type)
    }
    
    public convenience init(title:String, touchUpInside:Optional<(_ point:ISPoint, _ sliderValue: Float) -> Void>, pointValue: Float,pointObject: Any, type: String) {
        self.init(title: title, description: "", touchUpInside: touchUpInside,  pointValue: pointValue, pointObject: pointObject, type: type)
    }
    
    public convenience init(title:String, pointValue: Float, pointObject: Any, type: String) {
        self.init(title: title, touchUpInside: nil, pointValue: pointValue, pointObject: pointObject, type: type)
    }
}
