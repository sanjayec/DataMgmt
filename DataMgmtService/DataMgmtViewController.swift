//
//  DataMgmtViewController
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class DataMgmtViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{

    
    let stepReuseIdentifier = "Cell"
    let restoreOpReuseId = "RestoreOpCell"
    let dataSourceCellReuseId = "datasourceCell"
    let backupCellReuseId = "datasourceBackupCell"
    // MARK : Properties
  
   
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var progressStepsCollection: UICollectionView!
    @IBOutlet weak var restoreOpsCollection: UICollectionView!
    
    @IBOutlet weak var logsView: UIView!
    
    @IBOutlet weak var showOps: UIButton!
    var lastCellSelected: OperationCollectionViewCell?
    var lastDatasourceCellSelected: DatasourceCollectionViewCell?

    var datasources = [Datasource]()
    var selectedDatasource : Datasource?
    var associatedDatasource: Datasource?
    
    var selectedBackup : Backup?
    
    @IBOutlet weak var datasourcesCollectionView: UICollectionView!
    
    @IBOutlet weak var dataSourceTopView: UIView!
    
    @IBOutlet weak var backupsCollectionView: UICollectionView!
    @IBOutlet weak var associateMsg: UILabel!
    
    @IBOutlet weak var instructMsg: UILabel!
    var selectedDatasourceIndexPath:IndexPath?
    var associatedBackupIndexPath:IndexPath?
    
    func configureView() {
        // Update the user interface for the detail item.
        if self.detailItem != nil {
           loadDatasources()
            setSelectedDatasourceCell()
                   }
        
        navigationItem.title = self.detailItem?.name
    }
    override func viewWillAppear(_ animated: Bool) {
        // navigationItem.title = "One"
        navigationItem.title = self.detailItem?.name
        
        if(selectedDatasourceIndexPath != nil){
//          self.datasourcesCollectionView.selectItem(at: selectedDatasourceIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
//            self.datasourcesCollectionView.delegate!.collectionView!(datasourcesCollectionView, didSelectItemAt: selectedDatasourceIndexPath!)
        }

    }

    @IBAction func showOps(_ sender: AnyObject) {
        self.restoreOpsCollection.isHidden = !self.restoreOpsCollection.isHidden
        if(self.restoreOpsCollection.isHidden){
            showOps.setTitle("Show All", for: .normal)
        }
        else{
            showOps.setTitle("Hide All", for: .normal)
        }
    }
    
    func loadDatasources(){
        
        DatabaseModel.fetchDatasources(){ datasources in
            self.datasources = datasources
            DispatchQueue.main.async {
                self.view.setNeedsDisplay()
                self.datasourcesCollectionView.reloadData()
                self.setSelectedDatasourceCell()
                _ = self.datasourcesCollectionView.numberOfItems(inSection: 0)
                
            }
            
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Title
       // title = "Data Management"
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        if( self.navigationItem != nil && self.navigationController != nil ){
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
        }
        self.activityIndicatorView = ActivityIndicatorView(title: "Submitting Job...", center: self.view.center)
       
        
        progressStepsCollection.dataSource = self
        progressStepsCollection.delegate = self
        progressStepsCollection.backgroundColor = UIColor.white

        
        restoreOpsCollection.dataSource = self
        restoreOpsCollection.delegate = self
        var colors = [UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        addBackground(collectionView: restoreOpsCollection, colors: colors)
        
        datasourcesCollectionView.dataSource = self
        datasourcesCollectionView.delegate = self
       //  colors = [UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        colors = [UIColor(red:200.0/255, green:216.0/255, blue:200.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        addBackground(collectionView: datasourcesCollectionView, colors: colors)
        
        
        backupsCollectionView.dataSource = self
        backupsCollectionView.delegate = self
        colors = [UIColor(red:200.0/255, green:216.0/255, blue:200.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        addBackground(collectionView: backupsCollectionView, colors: colors)
        
        
        if let restoreProgressStr = self.detailItem?.latestRestoreOperation?.percentageComplete {
        let endIndex = restoreProgressStr.index((restoreProgressStr.startIndex), offsetBy: ((restoreProgressStr.characters.count)-1))

          
        let fractionalProgress = Float(restoreProgressStr.substring(to: endIndex))! / 100.0
        progressView.setProgress(fractionalProgress, animated: true)
        progressLabel.text = restoreProgressStr
            
            
        }
        
       initiateViews()
        loadDatasources()
        initializeInstructMsg()
      //  setSelectedDatasourceCell()

    }
    func setSelectedDatasourceCell(){
        for (index,ds) in datasources.enumerated() {
            if(ds.name == self.detailItem?.datasource){
                selectedDatasource = ds
                selectedDatasourceIndexPath = IndexPath(row:index, section:0)
                
                associatedDatasource = ds
                
//                self.datasourcesCollectionView.selectItem(at: selectedDatasourceIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
                
                for (index,backup) in ds.backups.enumerated() {
                    if(backup.id == self.detailItem?.datasource){
                        
                        selectedDatasourceIndexPath = IndexPath(row:index, section:0)
                    }
                }
                
            }
        }
    }
    func initializeInstructMsg(){
        if (self.detailItem?.datasource) == nil {
           instructMsg.text = "Database is not connected to any data source. Choose datasource below to associate."
        }
        else{
            instructMsg.text = "Database is associated with "+(self.detailItem?.datasource)!+". Refresh to latest backups if required."
        }
        instructMsg.lineBreakMode = .byWordWrapping
        instructMsg.numberOfLines = 0
        instructMsg.setNeedsDisplay()
    }
    func initiateViews(){
        dataSourceTopView.isHidden = false
        logsView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            
            progressView.setProgress(fractionalProgress, animated: animated)
            progressLabel.text = ("\(counter)%")
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == progressStepsCollection {
        if let count =  (self.detailItem?.latestRestoreOperation?.operationSteps.count){
            return count
        }
        }
        else if collectionView == datasourcesCollectionView {
            return  self.datasources.count
        }
        else if collectionView == backupsCollectionView {
             if let count =  (self.selectedDatasource?.backups.count){
            return  count
            }
        }
        else {
            if let count =  (self.detailItem?.restoreOperations.count){
                return count
            }
        }
        return 0
    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if let indexPath = collectionView.indexPathsForSelectedItems{
            let selectedCell = collectionView.cellForItem(at: indexPath[0])
            _ = collectionView.visibleCells
            _ = self.datasourcesCollectionView.numberOfItems(inSection: 0)

            _ = selectedCell?.bounds
        // handle tap events
        if collectionView == datasourcesCollectionView{
          
            selectedDatasource =  self.datasources[indexPath[0].row]
            
            let colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
            addGradient(cell: selectedCell!, colors: colors)
            
            lastDatasourceCellSelected?.layer.sublayers?[0].removeFromSuperlayer()
            lastDatasourceCellSelected = selectedCell as! DatasourceCollectionViewCell?
            
            self.view.setNeedsDisplay()
            self.backupsCollectionView.reloadData()
            
        }
        else if collectionView == backupsCollectionView{
            self.selectedBackup =  self.selectedDatasource?.backups[indexPath[0].row]
            
        }
       else if collectionView == restoreOpsCollection {
             let restoreOp =  self.detailItem?.restoreOperations[indexPath[0].row]
            
            
            let colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
            addGradient(cell: selectedCell!, colors: colors)
            
            lastCellSelected?.layer.sublayers?[0].removeFromSuperlayer()
            lastCellSelected = selectedCell as! OperationCollectionViewCell?
            
            self.detailItem?.latestRestoreOperation = restoreOp
           self.view.setNeedsDisplay()
            self.progressStepsCollection.reloadData()
            self.progressStepsCollection.setNeedsDisplay()
            self.progressStepsCollection.setNeedsLayout()
            self.viewDidLoad()
            self.viewWillAppear(true)
        
        }
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == backupsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: backupCellReuseId, for: indexPath as IndexPath) as! DatasourceBackupCollectionViewCell
            let backup = self.selectedDatasource?.backups[indexPath.item]
            
//            let colors = [UIColor(red:76.0/255, green:162.0/255, blue:205.0/255, alpha:1).cgColor, UIColor(red:103.0/255, green:178.0/255, blue:111.0/255, alpha:1).cgColor]
            var colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
            if indexPath.row == 1 {
                colors = [UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1).cgColor, UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1).cgColor]
               // colors = [self.view.tintColor.cgColor, self.view.tintColor.cgColor]
                cell.assocOrRefresh.isEnabled = false
                cell.assocOrRefresh.setTitleColor(UIColor.clear, for: .normal)
                cell.name.textColor = UIColor.white
                cell.createdOn.textColor = UIColor.white
                cell.storageType.textColor = UIColor.white
                 cell.image.image = #imageLiteral(resourceName: "cloudbackup_blue")
              // cell.backgroundColor = self.view.tintColor
                

            }
            else{
                cell.assocOrRefresh.isEnabled = true
                
                cell.assocOrRefresh.setTitleColor(UIColor.black, for: .normal)
                cell.name.textColor = UIColor.black
                cell.createdOn.textColor = UIColor.black
                cell.storageType.textColor = UIColor.black
                cell.image.image = #imageLiteral(resourceName: "cloudbackup")
                
                
            }
addGradient(cell: cell, colors: colors)
            
            
            
            cell.name.text = backup?.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            cell.createdOn.text = "Created On: " + dateFormatter.string(from: (backup?.dateCreated)!)
            cell.storageType.text = "Storage Type: " + (backup?.storageType)!
            
            if (self.detailItem?.datasource) == nil {
                cell.assocOrRefresh.setTitle("Associate", for: .normal)
            }
            else{
                cell.assocOrRefresh.setTitle("Refresh", for: .normal)

            }
            
            cell.layer.cornerRadius = 10
            
            return cell

        }
        else if collectionView == datasourcesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dataSourceCellReuseId, for: indexPath as IndexPath) as! DatasourceCollectionViewCell
            let datasource = self.datasources[indexPath.item]
            
         //  let colors = [UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:58.0/255, green:123.0/255, blue:213.0/255, alpha:1).cgColor]
            
         //   addGradient(cell: cell, colors: colors)
            
            cell.name.text = datasource.name
            cell.name.lineBreakMode = .byWordWrapping
            cell.name.numberOfLines = 0
            cell.owner.text = "Created by "+datasource.owner!
            
            cell.layer.cornerRadius = 5
            
//            //if selected
//            if let dsName = self.detailItem?.datasource {
//                if dsName == datasource.name {
//                    self.datasourcesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
//                    selectedDatasourceIndexPath = indexPath
//                }
//            }
            
            if datasource.name == selectedDatasource?.name{
                
                self.datasourcesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
               // self.datasourcesCollectionView.delegate!.collectionView!(collectionView, didSelectItemAt: indexPath)
                
            }
            return cell
            
        }
        else if collectionView == progressStepsCollection {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepReuseIdentifier, for: indexPath as IndexPath) as! RestoreProgressCollectionViewCell
        let opStep = self.detailItem!.latestRestoreOperation?.operationSteps[indexPath.item]
        
            var colors:[Any]
        if (opStep?.percentageComplete == "100%"){
            
            colors = [UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:58.0/255, green:123.0/255, blue:213.0/255, alpha:1).cgColor]
            
        }
        else if(opStep?.percentageComplete == "0%"){
            
            colors = [UIColor(red:240.0/255, green:240.0/255, blue:240.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]

        }
        else{
            
          colors = [UIColor(red:255.0/255, green:209.0/255, blue:148.0/255, alpha:1).cgColor, UIColor(red:112.0/255, green:225.0/255, blue:245.0/255, alpha:1).cgColor]
           
        }
       addGradient(cell: cell, colors: colors)
        cell.stepName.text = opStep?.name
        cell.stepName.lineBreakMode = .byWordWrapping
        cell.stepName.numberOfLines = 0
        return cell
            
        }
        
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restoreOpReuseId, for: indexPath as IndexPath) as! OperationCollectionViewCell
            let restoreOp = self.detailItem!.restoreOperations[indexPath.item]
            
            cell.name.text = restoreOp.name
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
            cell.startTime.text = dateFormatter.string(from: restoreOp.startTime)
            
            if restoreOp.startTime == self.detailItem?.latestRestoreOperation?.startTime{
                //override lastcellSelected
                lastCellSelected = cell
                       let colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
                
             addGradient(cell: cell, colors: colors)
            }
            return cell
            
        }
        
    }
    
    @IBAction func goToLogsView(_ sender: Any) {
        associateMsg.text = "Association of " + (self.selectedDatasource?.name)! + " is in progress ..."
        
        self.logsView.isHidden = false
        self.dataSourceTopView.isHidden = true
        
       // self.performSegue(withIdentifier: "showOpDetails", sender: self)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if selectedDatasourceIndexPath != nil {
        self.datasourcesCollectionView.delegate!.collectionView!(datasourcesCollectionView, didSelectItemAt: selectedDatasourceIndexPath!)
        }
    }
    
    func addBackground(collectionView: UICollectionView, colors: [Any] ){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = colors
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        let vv = UIView()
        collectionView.backgroundView = vv;
        collectionView.backgroundView?.layer.insertSublayer(gradient, at: 0)
    }
    func addGradient(cell: UICollectionViewCell, colors: [Any]){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        
        
        gradient.colors = colors
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        gradient.name = "gradient"
        let sublayer = cell.layer.sublayers?[0]
        
        if sublayer?.name == "gradient"{
            cell.layer.replaceSublayer(sublayer!, with: gradient)
        }
        
        cell.layer.insertSublayer(gradient, at: 0)
    }
    
    

    @IBAction func landBackfromOperationsPage(segue:UIStoryboardSegue) {
    }
//     func goBackToParent()
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func submitAssoc(_ sender: Any) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = (view.superview)?.superview as! DatasourceBackupCollectionViewCell
         let indexPath = backupsCollectionView.indexPath(for: cell)
        
        selectedBackup = self.selectedDatasource?.backups[(indexPath?.item)!]

        showAssocConfirmPopup()
        
    }
    
    var activityIndicatorView: ActivityIndicatorView!
    
    func showAssocConfirmPopup() {
        var assocConfirmTitle = "Associate Datasource Confirmation"
        var assocConfirmMessage = "Are you sure you want to associate with the selected datasource?"
        if (self.detailItem?.datasource) != nil {
            assocConfirmTitle = "Refresh Confirmation"
            assocConfirmMessage = "Are you sure you want to refresh the databas to selected backup?"

        }
        
        let refreshAlert = UIAlertController(title: assocConfirmTitle, message: assocConfirmMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
            self.activityIndicatorView.startAnimating()
            
            if (self.detailItem?.datasource) == nil {
            DatabaseModel.submitAssociate(database: self.detailItem!,datasource: self.selectedDatasource!, backup: self.selectedBackup!){ message in
                self.removeIndicator()
                if message == "succeeded" {
                    self.showJobSubmittedAlert()
                }
                else {
                    self.showFailedJobAlert(message: message)
                }
                
            }
            }
            else{
                DatabaseModel.submitAssociate(database: self.detailItem!,datasource: self.selectedDatasource!, backup: self.selectedBackup!){ message in
                    self.removeIndicator()
                    if message == "succeeded" {
                        self.showJobSubmittedAlert()
                    }
                    else {
                        self.showFailedJobAlert(message: message)
                    }
                    
                }
            }
            print("Assoc Job Submitted")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancelled Job")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func showJobSubmittedAlert() {
        var jobSubmittedMsg = "Associate job submitted successfully"
        
        if (self.detailItem?.datasource) != nil {
            jobSubmittedMsg = "Refresh job submitted successfully"
        }
        
        let refreshAlert = UIAlertController(title: jobSubmittedMsg, message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Clicked on OK")
            self.performSegue(withIdentifier: "showOpDetails", sender: self)

        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    func showFailedJobAlert(message: String?) {
        var jobSubmitFailedMsg = "Unable to submit associate job"
        
        if (self.detailItem?.datasource) != nil {
            jobSubmitFailedMsg = "Unable to submit refresh job"
        }
        let refreshAlert = UIAlertController(title: jobSubmitFailedMsg, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Clicked on OK")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func removeIndicator(){
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
        self.activityIndicatorView.getViewActivityIndicator().isHidden = true
        self.view.setNeedsDisplay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOpDetails" {
            
            let selectedDB = self.detailItem
            //var operation:Operation?
            
            let opStepsviewController =  (segue.destination as! UINavigationController).topViewController  as! OpearationStepsViewController
            
            opStepsviewController.database = selectedDB
            opStepsviewController.navigationItem.leftBarButtonItem = self.tabBarController?.splitViewController?.displayModeButtonItem
            opStepsviewController.navigationItem.leftItemsSupplementBackButton = true
            //opStepsviewController.navigationItem.title = selectedDB.name
            
            
        }
    }

}

