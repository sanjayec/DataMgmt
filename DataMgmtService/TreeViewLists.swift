//
//  TreeViewLists.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/3/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


class TreeViewLists
{
    //MARK:  Load Array With Initial Data
    
    static func LoadInitialData(operation: Operation) -> [TreeViewData]
    {
        var data: [TreeViewData] = []
        // find level 0 steps
        var levelzeroSteps = [OperationStep]()
        var count = 0
        for opInstance in  operation.operationSteps{
            
            if(opInstance.level == "0"){
                count += 1
                levelzeroSteps.append(opInstance)
                data.append(TreeViewData(level: 0, name: opInstance.name, id: String(count), parentId: "-1", object: opInstance)!)
            }
        }
        for opInstance in  operation.operationSteps{
            
            if(opInstance.level == "1"){
                for i in (0...levelzeroSteps.count-1){
                    if opInstance.parentId == levelzeroSteps[i].id{
                        count += 1
                        data.append(TreeViewData(level: 1, name: opInstance.name, id: String(count), parentId: String(i+1), object: opInstance)!)
                    }
                }
            }
        }
        
        
      
        return data
    }
    
    //MARK:  Load Nodes From Initial Data
    
    static func LoadInitialNodes(_ dataList: [TreeViewData]) -> [TreeViewNode]
    {
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == 0
        {
            print("\(data.name)")
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data.object as AnyObject?
            node.isExpanded = GlobalVariables.FALSE
            let newLevel = data.level + 1
            node.nodeChildren = LoadChildrenNodes(dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
            
        }
        
        return nodes
    }
    
    //MARK:  Recursive Method to Create the Children/Grandchildren....  node arrays
    
    static func LoadChildrenNodes(_ dataList: [TreeViewData], level: Int, parentId: String) -> [TreeViewNode]
    {
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == level && data.parentId == parentId
        {
            print("\(data.name)")
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data.object as AnyObject?
            node.isExpanded = GlobalVariables.FALSE
            let newLevel = level + 1
            node.nodeChildren = LoadChildrenNodes(dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0)
            {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
            
        }
        
        return nodes
    }
    
    
}

