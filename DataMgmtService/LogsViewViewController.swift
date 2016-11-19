//
//  LogsViewViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/3/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class LogsViewViewController: UIViewController {

    @IBOutlet weak var stepName: UILabel!
   // @IBOutlet weak var logs: UILabel!
    var step:OperationStep?
    var type: String?
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTIme: UILabel!
    @IBOutlet weak var statusIcon: UIButton!
    
    @IBOutlet weak var logs: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if step != nil {
            
            // Do any additional setup after loading the view.
            self.stepName.text = step?.name
            // self.logs.text = ""
//            self.logs.lineBreakMode = .byWordWrapping
//            self.logs.numberOfLines = 0

            
        self.startTime.text = dateFormatter.string(from: (step?.startTime)!) + " UTC"
        if let endTIme = step?.endTime{
            self.endTIme.text = dateFormatter.string(from: endTIme)  + " UTC"
        }
            
            if (step?.percentageComplete == "100%"){
                self.statusIcon.setBackgroundImage(UIImage(named: "green_tick"), for: UIControlState())
                
            }
            else if(step?.percentageComplete == "0%"){
                
                
            }
            else{
                self.statusIcon.setBackgroundImage(UIImage(named: "clock"), for: UIControlState())
                
               
                
            }

        }

        
        setLogs()
        
    }
    
    func setLogs(){
        if(step  == nil) {
            return
        }
        let key = (self.step?.name)!
        var fileName = ""
        if type == "Backup Database"{
           fileName = LogsMapper.backup[key]!
        }
        else{
            fileName = LogsMapper.restore[key]!
        }
        
        
        
        let bundle = Bundle.main
        let path =  bundle.path(forResource: fileName, ofType: "txt")
        if(path == nil ){
            return
        }
        let fileURL = URL(fileURLWithPath: path!)

        
        var inString = ""
        do {
            inString = try String(contentsOf: fileURL)
            logs.text = inString
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
       

    }
  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
