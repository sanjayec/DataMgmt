//
//  LogsMapper.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/16/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class LogsMapper {
    
    static var restore : [String:String]  = [
        "Initialization":"initialization_rst",
        "Associate Instance to Datasource":"associate_instance_to_datasource_rst",
        "Download Backup Pieces from Cloud":"",
        "Prepare Dowbload Package":"prepare_dowbload_package_rst",
        "Dowbload Backup Pieces":"download_backup_pieces_rst",
        "Restore MySQL Database":"",
        "Prepare Restoration Scripts":"prepare_restoration_scripts_rst",
        "Data Restoration using Backup":"data_restoration_using_backup_rst",
        "Cleanup Backup Pieces":"cleanup_backup_pieces_rst",
        "Cleanup Intermediate Files":"cleanup_intermediate_files_rst"        
    ]
    
    static var backup : [String:String]  = [
        "Initialization":"initialization",
        "Backup MySQL Database":"initialization",
        "Prepare Backup Scripts":"prepare_backup_scripts",
        "Prepare Database for Backup":"prepare_database_for_backup",
        "Run MYSQL Backup":"run_mysql_backupp",
        "Upload Backup Pieces to Cloud":"",
        "Prepare Upload Package":"prepare_upload_package",
        "Prepare Cloud Storage":"prepare_cloud_storage",
        "Upload Backup Pieces":"upload_backup_pieces.txt",
        "Cleanup Intermediate Files":"cleanup_intermediate_files",
        "Collecting Schema Information for this Backup":""
    ]
    
}
