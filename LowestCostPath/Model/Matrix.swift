//
//  Matrix.swift
//  LowestCostPath
//
//  Created by Roopa on 14/08/18.
//  Copyright © 2018 photon. All rights reserved.
//

import Foundation

 //Matrix Model
 public class Matrix {
    public var numberOfColumns = 0
    public var numberOfRows = 0
    public var matrix: [[Int]] = [[Int]]()
    
    init(listOfValues:[[Int]]) {
        matrix = listOfValues
        numberOfRows = matrix.count
        
        if numberOfRows > 0{
            numberOfColumns = (matrix.first?.count)!
        }
    }
    
    // Matrix cell index value
    func valueForIndex(index:(row:Int,column:Int)) -> Int? {
        guard index.row > -1 ,index.column > -1, index.row < numberOfRows , index.column < numberOfColumns else {
            return nil
        }
        return self.matrix[index.row][index.column]
    }
    
    //MARK: Adjacent Cells
    func getAdjacentCells(For cellIndex:(row:Int,column:Int)) -> ([(Int,Int)]?)  {
        
        print("row = \(cellIndex.row)   column = \(cellIndex.column)")
        guard self.matrix != nil , cellIndex.row > -1 ,cellIndex.column > 0, cellIndex.row < numberOfRows , cellIndex.column < numberOfColumns else {
            return nil
        }
        
        print("after guard = \(cellIndex.row)   column = \(cellIndex.column)")
        let straight = (cellIndex.row,cellIndex.column-1)
        
        var top = (cellIndex.row - 1,cellIndex.column - 1)
        if cellIndex.row == 0 {
            top = (numberOfRows-1,cellIndex.column - 1)
        }
        
        var bottom = (cellIndex.row+1,cellIndex.column-1)
        if cellIndex.row == numberOfRows - 1 {
            bottom = (0,cellIndex.column - 1)
        }
        print("straight = \(straight)")
        print("top = \(top)")
        print("bottom = \(bottom)")
        
        
        let adjacentCells = [top,straight,bottom]
        return adjacentCells
    }
    
}



