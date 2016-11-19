//
//  UISplitViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/16/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = self.displayModeButtonItem
        UIApplication.shared.sendAction(barButtonItem.action!, to: barButtonItem.target, from: nil, for: nil)
    }
}
