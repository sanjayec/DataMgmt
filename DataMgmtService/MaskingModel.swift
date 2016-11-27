//
//  MaskingModel.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MaskingModel {
    
    static func fetchPolicies() -> [Policy]{
        
        var policies = [Policy]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var dateCreated = dateFormatter.date(from: "2016-11-20 09:20:00")
        var policy = Policy(name:"Backup Policy Full Protection v1.7",description:"Policy defined to run on regular basis, with storage destination to Cloud",dateModified: dateCreated! , customText: "Starts at 2 am daily", type: "backup")
        policies.append(policy)
        
        dateCreated = dateFormatter.date(from: "2016-11-20 06:46:50")
        policy = Policy(name:"PCI Compliance Masking policy",description:"Tables with personal info attributes will be anonymized",dateModified: dateCreated! , customText: "Masked Columns: 34", type: "masking")
        policies.append(policy)
        
        dateCreated = dateFormatter.date(from: "2016-11-18 11:23:54")
      //  policy = Policy(name:"HIPAA Compliance Masking Definition",description:"Tables with health and personal info will be anonymized",dateModified: dateCreated! , customText: "Starts at 2 am daily")
       // policies.append(policy)
        
 return policies
    }
    static func fetchMaskingDefs() -> [MaskingDefinition]{
        
        var maskingDefs = [MaskingDefinition]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var dateCreated = dateFormatter.date(from: "2016-11-20 09:20:00")
        var maskingDef = MaskingDefinition(name:"Backup Policy Full Protection v1.7",description:"Policy defined to run on regular basis, with storage dest to Cloud",dateCreated: dateCreated! , maskedColumns: 19)
        maskingDefs.append(maskingDef)
        
        dateCreated = dateFormatter.date(from: "2016-11-20 06:46:50")
        maskingDef = MaskingDefinition(name:"PCI Compliance Masking Definition",description:"Tables with personal info attributes will be anonymized",dateCreated: dateCreated! , maskedColumns: 28)
        maskingDefs.append(maskingDef)
        
        dateCreated = dateFormatter.date(from: "2016-11-18 11:23:54")
        maskingDef = MaskingDefinition(name:"HIPAA Compliance Masking Definition",description:"Tables with health and personal info will be anonymized",dateCreated: dateCreated! , maskedColumns: 31)
        maskingDefs.append(maskingDef)
        
//        dateCreated = dateFormatter.date(from: "2016-11-17 03:21:41")
//        maskingDef = MaskingDefinition(name:"Custom Masking Definition",description:"PCI and other info sensitive info will be anonymized",dateCreated: dateCreated! , maskedColumns: 23)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-16 07:52:19")
//        maskingDef = MaskingDefinition(name:"Masking for Telco Billing",description:"Tables with billing information will be anonymized",dateCreated: dateCreated! , maskedColumns: 18)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-16 12:30:05")
//        maskingDef = MaskingDefinition(name:"Netsuite 10.1.5 Data Masking Definition",description:"NetSuite 10.1.5 Data Masking Certified",dateCreated: dateCreated! , maskedColumns: 35)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-16 12:15:41")
//        maskingDef = MaskingDefinition(name:"DSS Compliance Masking Definition",description:"Tables with personal info attributes will be anonymized",dateCreated: dateCreated! , maskedColumns: 28)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-14 05:48:12")
//        maskingDef = MaskingDefinition(name:"FERPA Compliance Masking Definition",description:"Tables with educational and personal info will be anonymized",dateCreated: dateCreated! , maskedColumns: 50)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-13 03:19:55")
//        maskingDef = MaskingDefinition(name:"Bob Custom Masking Definition",description:"PCI and other info sensitive info will be anonymized",dateCreated: dateCreated! , maskedColumns: 23)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-12 06:02:59")
//         maskingDef = MaskingDefinition(name:"Masking for Transport Billing",description:"Tables with billing information will be anonymized",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-11 09:25:02")
//         maskingDef = MaskingDefinition(name:"PeopleSoft 11.1.0 Data Masking Definition",description:"PeopleSoft 11.1.0 Data Masking Certified",dateCreated: dateCreated! , maskedColumns: 40)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-10 11:31:44")
//        maskingDef = MaskingDefinition(name:"SOX Compliance Masking Definition",description:"Masking definition to make data federal law compliant",dateCreated: dateCreated! , maskedColumns: 28)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-10 02:54:35")
//maskingDef = MaskingDefinition(name:"GLBA Compliance Masking Definition",description:"Tables with finance numbers will be anonymized",dateCreated: dateCreated! , maskedColumns: 28)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-10 09:23:00")
//        maskingDef = MaskingDefinition(name:"Custom Masking PCI Def",description:"PCI and other info sensitive info will be anonymized",dateCreated: dateCreated! , maskedColumns: 23)
//       maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-09 10:14:26")
//        maskingDef = MaskingDefinition(name:"Masking for Infra Billing",description:"Tables with billing information will be anonymized",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
        
//        dateCreated = dateFormatter.date(from: "2016-11-08 02:25:30")
//        maskingDef = MaskingDefinition(name:"",description:"",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-08 03:45:31")
//        maskingDef = MaskingDefinition(name:"",description:"",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-08 02:20:00")
//        maskingDef = MaskingDefinition(name:"",description:"",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-08 08:20:37")
//        maskingDef = MaskingDefinition(name:"",description:"",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
//        
//        dateCreated = dateFormatter.date(from: "2016-11-07 06:21:48")
//        maskingDef = MaskingDefinition(name:"",description:"",dateCreated: dateCreated! , maskedColumns: 15)
//        maskingDefs.append(maskingDef)
        
        return maskingDefs
        
    }
    
    static func fetchMaskedColumns() -> [MaskedColumn]{
        
        var maskedColumns = [MaskedColumn]()
        
        var column = MaskedColumn(tableName: "Table Name", columnName:"Column Name", columnType:"Column Type", format:"Format")
        maskedColumns.append(column)
        
        column = MaskedColumn(tableName: "AP_CARDS_ALL#", columnName:"CARD_NUMBER", columnType:"Card Number", format:"/(\\rand:d{4})-(\\rand:d{4})-(\\rand:d{4})-(\\rand:d{4})/")
        maskedColumns.append(column)
        
        column = MaskedColumn(tableName: "AP_CHECKS_ALL#", columnName:"BANK_ACCOUNT_NUM", columnType:"Account Number", format:"/(\\rand:d{12})/")
        maskedColumns.append(column)

        
        column = MaskedColumn(tableName: "AP_EXPENSE_FEED_LINES_ALL#", columnName:"CARD_NUMNER", columnType:"Card Number", format:"^((\\()?[[:digit:]]{3}(\\))?-||?{{:digit}}")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "AP_INVOICE_PAYMENTS_ALL#  ", columnName:"BANK_ACCOUNT_NUM", columnType:"Account Number", format:"^((\\()?[[:digit:]]{4}(\\))?-||?{{:digit}}$")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "AP_SELECTED_INVOICES_ALL#", columnName:"BANK_ACCOUNT_NUM", columnType:"Account Number", format:"?(($\\()?[[:digit:]]{3}(\\))?-||?{{:digit}}")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "AP_SUPPLIERS#", columnName:"INDIVIDUAL_1099", columnType:"User Info", format:"/(\\[A-Z0-9]*rand:d{2})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "AP_SUPPLIERS#", columnName:"NUM_1099", columnType:"User Id", format:"/(\\rand:d{6})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"CUSTOMER_ID", columnType:"Customer Id", format:"\\rand:d{8})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"DESCRIPTION", columnType:"User Info", format:"/(\\[A-Z0-9]?\\[A-Z0-9]*rand:d{2})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"EMAIL_ADDRESS", columnType:"Email Address", format:"/(\\[A-Z0-9]?*rand:d{6})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"EMPLOYEE_ID", columnType:"Employee Id", format:"/(\\[A-Z0-9]?*rand:d{2})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"ENCRYPTED_FOUNDATION_PASSWORD", columnType:"Password", format:"/(d{5}?\\[A-Z0-9]*rand:d{2})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"ENCRYPTED_USER_PASSWORD", columnType:"Password", format:"/(d{5}?\\[A-Z0-9]*rand:d{2})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"FAX", columnType:"Fax Number", format:"/(\\[A-Z0-9]?*rand:d{2})/")
        maskedColumns.append(column)

        column = MaskedColumn(tableName: "FND_USER#", columnName:"SUPPLIER_ID", columnType:"Supplier ID", format:"/(\\[A-Z0-9]?*rand:d{2})/")
        maskedColumns.append(column)

        
        return maskedColumns

    }
    
}
