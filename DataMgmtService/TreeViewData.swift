//
//  TreeViewData.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/3/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


class TreeViewData
{
    var level: Int
    var name: String
    var id: String
    var parentId: String
    var object: Any
    
    init?(level: Int, name: String, id: String, parentId: String, object: Any)
    {
        self.level = level
        self.name = name
        self.id = id
        self.parentId = parentId
        self.object = object
    }
}
