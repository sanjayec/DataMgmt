//
//  StepTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/3/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    @IBOutlet weak var treeLabel: UILabel!
    @IBOutlet weak var treeButton: UIButton!
    var treeNode: TreeViewNode!
    
    @IBOutlet weak var statusIcon: UIButton!
    @IBOutlet weak var showLogsBtn: UIButton!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
   
    @IBOutlet weak var duration: UILabel!
    
    //MARK:  Draw Rectangle for Image
    
    override func draw(_ rect: CGRect) {
        var cellFrame: CGRect = self.treeLabel.frame
        var buttonFrame: CGRect = self.treeButton.frame
      //  var statusIconFrame: CGRect = self.statusIcon.frame
        let indentation: Int = self.treeNode.nodeLevel! * 25
        cellFrame.origin.x = buttonFrame.size.width + CGFloat(indentation) + 5
        buttonFrame.origin.x = 2 + CGFloat(indentation)
      //  statusIconFrame.origin.x = cellFrame.origin.x + cellFrame.size.width + 5
        self.treeLabel.frame = cellFrame
        self.treeButton.frame = buttonFrame
        //self.statusIcon.frame = statusIconFrame
        
        if self.treeNode.nodeChildren == nil
        {
            self.treeButton.isHidden = true
        }
        else{
            self.treeButton.isHidden = false
        }
//        if(self.endDate.text == nil || self.endDate.text == ""){
//            startRotating(button: self.statusIcon)
//        }
//        else{
//            stopRotating(button: self.statusIcon)
//        }
    }
    
   
    
    
    //MARK:  Set Background image
    
    func setTheButtonBackgroundImage(_ backgroundImage: UIImage)
    {
        self.treeButton.setBackgroundImage(backgroundImage, for: UIControlState())
    }
    
    func setTheStatusIcon(_ backgroundImage: UIImage)
    {
        self.statusIcon.setBackgroundImage(backgroundImage, for: UIControlState())
    }
    
    //MARK:  Expand Node
    @IBAction func expand(_ sender: Any) {
       expandTree()
    }
    
    func expandTree(){
        if (self.treeNode != nil)
        {
            if self.treeNode.nodeChildren != nil
            {
                if self.treeNode.isExpanded == GlobalVariables.TRUE
                {
                    self.treeNode.isExpanded = GlobalVariables.FALSE
                }
                else
                {
                    self.treeNode.isExpanded = GlobalVariables.TRUE
                }
            }
            else
            {
                self.treeNode.isExpanded = GlobalVariables.FALSE
            }
            
            self.isSelected = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TreeNodeButtonClicked"), object: self)
            //print("button clicked")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
