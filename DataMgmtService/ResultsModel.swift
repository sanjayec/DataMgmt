//
//  ResultsModel.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/10/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class ResultsModel{
    
    static func fetchTableDataDifference() -> [TableData]{
        var tableDataDif = [TableData]()
        
        var tableName = "customer_product_holdings"
        var tableData = TableData(name: tableName,recordsInBackup1: 272451, recordsInBackup2: 285205 )
        tableDataDif.append(tableData)
        
        tableName = "special_offers"
        tableData = TableData(name: tableName, recordsInBackup1: 310, recordsInBackup2: 892)
        tableDataDif.append(tableData)
        
        tableName = "customer_assets"
        tableData = TableData(name: tableName, recordsInBackup1: 523820, recordsInBackup2: 589782)
        tableDataDif.append(tableData)
        
        tableName = "service_and_products"
        tableData = TableData(name: tableName, recordsInBackup1: 12987, recordsInBackup2: 15221)
       tableDataDif.append(tableData)
        
        tableName = "contacts"
        tableData = TableData(name: tableName, recordsInBackup1: 25897, recordsInBackup2: 27981)
        tableDataDif.append(tableData)
        
        tableName = "accounts"
        tableData = TableData(name: tableName, recordsInBackup1: 4526829, recordsInBackup2: 5123879 )
        tableDataDif.append(tableData)
        
        tableName = "contracts"
        tableData = TableData(name: tableName, recordsInBackup1: 30628, recordsInBackup2: 32765)
        tableDataDif.append(tableData)
        
        tableName = "orders"
        tableData = TableData(name: tableName, recordsInBackup1: 9261, recordsInBackup2: 12135)
        tableDataDif.append(tableData)
        
        tableName = "opportunities"
        tableData = TableData(name: tableName, recordsInBackup1: 6082, recordsInBackup2: 13928)
        tableDataDif.append(tableData)
        
        tableName = "forecasts"
        tableData = TableData(name: tableName, recordsInBackup1: 211, recordsInBackup2: 763)
        tableDataDif.append(tableData)
        
      return tableDataDif
    }
    
    static func fetchSchemaDifference() -> [SchemaChangeTableRowData]{
        var schemaDif = [SchemaChangeTableRowData]()
        
       
        var schemaRow = SchemaChangeTableRowData(objectName: "ref_asset_types", objectType: "Table", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        
        schemaRow = SchemaChangeTableRowData(objectName: "cust_perf_orders", objectType: "Table", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        schemaRow = SchemaChangeTableRowData(objectName: "product_del_data", objectType: "Table", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        schemaRow = SchemaChangeTableRowData(objectName: "user_contact_info", objectType: "Table", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        schemaRow = SchemaChangeTableRowData(objectName: "mark_comp_delears", objectType: "Table", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        schemaRow = SchemaChangeTableRowData(objectName: "exchange_data_id_seq", objectType: "Sequence", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        schemaRow = SchemaChangeTableRowData(objectName: "exchange_data_id_view", objectType: "View", change: "Added in 2nd Backup (B2)" )
        schemaDif.append(schemaRow)
        
        
        return schemaDif
    }
}
