//
//  ISTimeline.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/7/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

open class ISTimeline: UIScrollView {
    
    fileprivate static let gap:CGFloat = 15.0
    var minimumValue : Float?
    var maximumValue : Float?
    var closestPoint: ISPoint?
    var sliderSelectAction:Optional<(_ point:ISPoint, _ sliderValue:Float) -> Void>
    var slider : UISlider?
    
    open var pointDiameter:CGFloat = 12.0 {
        didSet {
            if (pointDiameter < 0.0) {
                pointDiameter = 0.0
            } else if (pointDiameter > 100.0) {
                pointDiameter = 100.0
            }
        }
    }
    
    open var lineWidth:CGFloat = 4.0 {
        didSet {
            if (lineWidth < 0.0) {
                lineWidth = 0.0
            } else if(lineWidth > 20.0) {
                lineWidth = 20.0
            }
        }
    }
    
    open var bubbleRadius:CGFloat = 4.0 {
        didSet {
            if (bubbleRadius < 0.0) {
                bubbleRadius = 0.0
            } else if (bubbleRadius > 6.0) {
                bubbleRadius = 6.0
            }
        }
    }
    
    open var bubbleColor:UIColor = .init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    open var titleColor:UIColor = .white
    open var descriptionColor:UIColor = .gray
    
    open var points:[ISPoint] = [] {
        didSet {
            self.layer.sublayers?.forEach({ (layer:CALayer) in
                if layer.isKind(of: CAShapeLayer.self) {
                    layer.removeFromSuperlayer()
                }
            })
            self.subviews.forEach { (view:UIView) in
                view.removeFromSuperview()
            }
            
            self.contentSize = CGSize.zero
            
            sections.removeAll()
            buildSections()
            
            layer.setNeedsDisplay()
            layer.displayIfNeeded()
        }
    }
    
    open var bubbleArrows:Bool = true
    
    fileprivate var sections:[(point:CGPoint, bubbleRect:CGRect, descriptionRect:CGRect?, titleLabel:UILabel, descriptionLabel:UILabel?, pointColor:CGColor, lineColor:CGColor, fill:Bool, objectType:String)] = []
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        self.clipsToBounds = true
    }
    
    override open func draw(_ rect: CGRect) {
        let ctx:CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        for i in 0 ..< sections.count {
            if (i < sections.count - 1) {
                var start = sections[i].point
                start.x += pointDiameter / 2
                start.y += pointDiameter
                
                var end = sections[i + 1].point
                end.x = start.x
                
                drawLine(start, end: end, color: sections[i].lineColor)
            }
            drawPoint(sections[i].point, color: sections[i].pointColor, fill: sections[i].fill)
            drawBubble(sections[i].bubbleRect, backgroundColor: bubbleColor, textColor:titleColor, titleLabel: sections[i].titleLabel, objectType: sections[i].objectType)
            
            let descriptionLabel = sections[i].descriptionLabel
            if (descriptionLabel != nil) {
                drawDescription(sections[i].descriptionRect!, textColor: descriptionColor, descriptionLabel: sections[i].descriptionLabel!)
            }
        }
        
        var timeLineheight = sections[sections.count-1].point.y - sections[0].point.y + CGFloat(sections.count)
        
         slider = UISlider(frame:CGRect(x:8, y:2, width:timeLineheight, height: 20))
        slider?.transform = (slider?.transform.rotated(by: CGFloat(-M_PI_2)))!
         slider?.transform = (slider?.transform.translatedBy(x: -timeLineheight/2, y:  -timeLineheight/2))!
        slider?.setThumbImage(UIImage(named: "thumb_slider"), for: .normal)
        //slider.layer.anchorPoint = CGPoint(x:0, y: 0)

        if let minValue = minimumValue{
        slider?.minimumValue = minValue
        }
        else{
            slider?.minimumValue = 0

        }
        if let maxValue = maximumValue{
        slider?.maximumValue = maxValue
        }
        else{
            slider?.maximumValue = 0

        }
        slider?.isContinuous = true
        slider?.maximumTrackTintColor = UIColor.clear
        slider?.minimumTrackTintColor = slider?.maximumTrackTintColor
        //slider.thumbTintColor = slider.maximumTrackTintColor

        if let maxValue = maximumValue{
        slider?.value = maxValue
            
        }
        else{
            slider?.value = 0
        }
        slider?.addTarget(self, action: #selector(valueChanged(sender: )), for: .valueChanged)
        self.addSubview(slider!)

        ctx.restoreGState()
    }
    func valueChanged(sender: UISlider) {
        
        print("slider value: " + String(sender.value))
        var minimum:Float = 2.47732e+10
        
        for point in points{
            let diff = abs(point.pointValue - sender.value)
            if (diff < minimum ){
                minimum = diff
                closestPoint = point
            }
        }
        if let index = points.index(where: {$0.pointValue == closestPoint?.pointValue}) {
            if(index > 5 ){
                sender.value = (closestPoint?.pointValue)!
            }
        }
        
        sliderSelectAction?(closestPoint!, sender.value)
    }
    
    fileprivate func buildSections() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        var y:CGFloat = self.bounds.origin.y + self.contentInset.top
        for i in 0 ..< points.count {
            let titleLabel = buildTitleLabel(i)
            let descriptionLabel = buildDescriptionLabel(i)
            
            let titleHeight = titleLabel.intrinsicContentSize.height
            var height:CGFloat = titleHeight
            if descriptionLabel != nil {
                height += descriptionLabel!.intrinsicContentSize.height
            }
            
            let point = CGPoint(x: self.bounds.origin.x + self.contentInset.left + lineWidth / 2, y: y + (titleHeight + ISTimeline.gap) / 2)
            
            let maxTitleWidth = calcWidth()
            var titleWidth = titleLabel.intrinsicContentSize.width + 20
            if (titleWidth > maxTitleWidth) {
                titleWidth = maxTitleWidth
            }
            
            let offset:CGFloat = bubbleArrows ? 13 : 5
            let bubbleRect = CGRect(
                x: point.x + pointDiameter + lineWidth / 2 + offset,
                y: y + pointDiameter / 2,
                width: titleWidth+20,
                height: titleHeight + ISTimeline.gap)
            
            var descriptionRect:CGRect?
            if descriptionLabel != nil {
                descriptionRect = CGRect(
                    x: bubbleRect.origin.x,
                    y: bubbleRect.origin.y + bubbleRect.height + 3,
                    width: calcWidth(),
                    height: descriptionLabel!.intrinsicContentSize.height)
            }
            
            sections.append((point, bubbleRect, descriptionRect, titleLabel, descriptionLabel, points[i].pointColor.cgColor, points[i].lineColor.cgColor, points[i].fill, points[i].objectType))
            
            y += height
            y += ISTimeline.gap * 2.2 // section gap
        }
        y += pointDiameter / 2
        self.contentSize = CGSize(width: self.bounds.width - (self.contentInset.left + self.contentInset.right), height: y)
    }
    
    fileprivate func buildTitleLabel(_ index:Int) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = points[index].title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = calcWidth()
        return titleLabel
    }
    
    fileprivate func buildDescriptionLabel(_ index:Int) -> UILabel? {
        let text = points[index].description
        if (text != nil) {
            let descriptionLabel = UILabel()
            descriptionLabel.text = text
            descriptionLabel.font = UIFont.systemFont(ofSize: 10.0)
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            descriptionLabel.preferredMaxLayoutWidth = calcWidth()
            return descriptionLabel
        }
        return nil
    }
    
    fileprivate func calcWidth() -> CGFloat {
        return self.bounds.width - (self.contentInset.left + self.contentInset.right) - pointDiameter - lineWidth - ISTimeline.gap * 1.5
    }
    
    fileprivate func drawLine(_ start:CGPoint, end:CGPoint, color:CGColor) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func drawPoint(_ point:CGPoint, color:CGColor, fill:Bool) {
        let path = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: pointDiameter, height: pointDiameter))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.fillColor = fill ? color : UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    fileprivate func drawBubble(_ rect:CGRect, backgroundColor:UIColor, textColor:UIColor, titleLabel:UILabel, objectType: String) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: bubbleRadius)
        
        if bubbleArrows {
            let startPoint = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height / 2 - 8)
            path.move(to: startPoint)
            path.addLine(to: startPoint)
            path.addLine(to: CGPoint(x: rect.origin.x - 8, y: rect.origin.y + rect.height / 2))
            path.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height / 2 + 8))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = backgroundColor.cgColor
        
        self.layer.addSublayer(shapeLayer)
        
        let titleRect = CGRect(x: rect.origin.x + 35, y: rect.origin.y, width: rect.size.width - 15, height: rect.size.height - 1)
        titleLabel.textColor = textColor
        titleLabel.frame = titleRect
        
        let button = UIButton(type: .custom) // let preferred over var here
        button.frame = CGRect(x: rect.origin.x + 5, y: rect.origin.y + 5, width: 23, height: rect.size.height - 10)
        button.backgroundColor = UIColor.clear
        if(objectType == "snap"){
         button.setImage(UIImage(named:"snapshot"), for: .normal)
        }
        else{
            button.setImage(UIImage(named:"cloudbackup"), for: .normal)
            
        }
        self.addSubview(button)
      

        self.addSubview(titleLabel)
    }
    
    fileprivate func drawDescription(_ rect:CGRect, textColor:UIColor, descriptionLabel:UILabel) {
        descriptionLabel.textColor = textColor
        descriptionLabel.frame = CGRect(x: rect.origin.x + 7, y: rect.origin.y, width: rect.width - 10, height: rect.height)
        self.addSubview(descriptionLabel)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        for (index, section) in sections.enumerated() {
            if (section.bubbleRect.contains(point)) {
                slider?.value = points[index].pointValue
                points[index].touchUpInside?(points[index], (slider?.value)!)
                break
            }
        }
    }
}
