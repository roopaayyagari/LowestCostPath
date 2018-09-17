//
//  Matrix Processor.swift
//  LowestCostPath
//
//  Created by Roopa on 14/08/18.
//  Copyright © 2018 photon. All rights reserved.
//


import Foundation

// Processes the matrix for least cost.
public class MatrixProcessor {
    
    private var inputMatrix: Matrix  = Matrix(listOfValues: [[Int]]())
    private var numOfColumns = 0
    private var numOfRows = 0
    private var columnsProcessed = 0;
    private let thresholdLimit = 50
    
    init(with values:String) throws {
        
        let Output = MatrixParser.parseMatrix(values)
        switch Output {
        case .success(let costValues):
            inputMatrix = Matrix(listOfValues: costValues as! [[Int]])
            numOfColumns = inputMatrix.numberOfColumns
            numOfRows = inputMatrix.numberOfRows
            break
            
        case .failure(let error):
            throw error
        }
        
    }
    
    //Calculates Minimum cost
    func processMatrix()->(path:[Int],cost:Int,pathCompleted:Bool)?{
        
        for currentColumn in 0..<inputMatrix.numberOfColumns{
            let columnCosts = processColumn(column: currentColumn)
            if columnCosts.proceedNext == false {
                break
            }
        }
        
        //Traces the minimum path on the processed Matrix
        if let minimumCostDetails = traceShortestPath() {
            let paths = minimumCostDetails.path
            var rowDetails = [Int]()
            for path in paths {
                rowDetails.append(path.0+1)
            }
            return(rowDetails,minimumCostDetails.cost,minimumCostDetails.pathExists)
        }
        
        //nil matrix
        return([],0,false)
    }
    
    //MARK: Cost Calculation
    func processColumn(column:Int) -> ([Int],proceedNext:Bool){
        var columnCosts = [Int]()
        var proceedNext = true
        
        for currentRow in 0..<numOfRows {
            var currentIndexCost = self.inputMatrix.valueForIndex(index: (currentRow,column))!
            if let cellEdges = self.inputMatrix.getAdjacentCells(For: (currentRow,column)) {
                let minimumCellDetails = miniumumOfCellsFor(cellindices:cellEdges)
                let minimumEdgeCost = minimumCellDetails.value
                currentIndexCost = currentIndexCost + minimumEdgeCost!
            }
            columnCosts.append(currentIndexCost)
        }
        
        replaceColumnCosts(for: column, withcosts: columnCosts)
        
        let minimumColumnCost = minimumCostForColumn(column: column)
        if(minimumColumnCost.value! <= thresholdLimit) {
            columnsProcessed = columnsProcessed + 1
        } else {
            proceedNext = false
        }
        
        return (columnCosts, proceedNext)
    }
    
    
    
    // Check if matrix is traversed completly or not
    func processedTillEnd()->Bool {
        return columnsProcessed == numOfColumns
    }
    
    // Returns all the cell indicies (row,column) for given column.
    func cellIndiciesForColumn(column:Int) -> [(Int,Int)] {
        var columnIndex = [(Int,Int)]()
        for row in 0..<numOfRows {
            columnIndex.append((row,column))
        }
        return columnIndex
    }
    
    // Calculates the minimum costs for given cell Indicies
    func miniumumOfCellsFor(cellindices:([(Int,Int)])) -> (index:(row:Int,column:Int)? ,value:Int?){
        var cost:Int?
        var costIndex : (Int,Int)?
        var indicies = cellindices
        
        if(numOfRows==3){
            indicies = cellindices.reversed()
        }
        
        //Loop through the cell edges
        for cellIndex in indicies {
            if let cellCost = inputMatrix.valueForIndex(index: cellIndex){
                if let minimumCost = cost {
                    if cellCost < minimumCost {
                        cost = cellCost
                        costIndex = cellIndex
                    }
                }
                else{
                    cost = cellCost
                    costIndex = cellIndex
                }
            }
        }
        return (costIndex,cost)
    }
    
    
    
    // Internal function to replace costs in particular column
    private func replaceColumnCosts(for column:Int , withcosts costs:[Int]) {
        for row in 0..<numOfRows {
            inputMatrix.matrix[row][column] = costs[row]
        }
    }
    
    //MARK: Shortest Path
    func traceShortestPath() -> (path:[(Int,Int)],cost:Int,pathExists:Bool)? {
        
        guard inputMatrix.matrix != nil , columnsProcessed > 0 else{ // no columns processed is when there is no value that is below the threshold, so we exit tracing
            return nil
        }
        
        let lastColumnMinimumCostDetails = minimumCostForColumn(column: columnsProcessed-1)
        var currentIndex = lastColumnMinimumCostDetails.index!
        let minimumCost = lastColumnMinimumCostDetails.value
        
        var path = [(Int,Int)]()
        path.append(currentIndex)
        
        while currentIndex.column > 0 {
            let cells = self.inputMatrix.getAdjacentCells(For: currentIndex)
            let minimumCellDetails = miniumumOfCellsFor(cellindices: cells!)
            currentIndex = minimumCellDetails.index!
            path.append(currentIndex)
        }
        
        path = path.reversed()
        let pathExists = processedTillEnd()
        return (path,minimumCost!,pathExists)
    }
    
    
    // Calculates the minimum cost for given column by checking for its adjacent cell edges.
    func minimumCostForColumn(column:Int) -> (index:(row:Int,column:Int)? ,value:Int?) {
        let columnIndicies = cellIndiciesForColumn(column: column)
        let minimumCostDetails = miniumumOfCellsFor(cellindices: columnIndicies)
        return minimumCostDetails
    }
    
    
}


