//
//  MatrixParser.swift
//  LowestCostPath
//
//  Created by Roopa on 13/08/18.
//  Copyright © 2018 photon. All rights reserved.
//

import Foundation
public enum Output {
    case success(Any?)
    case failure(Error)
}

//CustomError
public enum CustomError: LocalizedError {
    case valid
    case invalidFormat
    case noData
    case unknown
    
    //Localized description
    public var errorDescription: String? {
        switch self {
        case .valid:
            return "Valid matrix"
        case .invalidFormat:
            return "Invalid matrix"
        case .noData:
            return "No input"
        case .unknown:
            return "Unknown error"
        }
    }
}

public class MatrixParser {
    
    static func parseMatrix(_ input:String) -> Output {
        
        var inputMatrix = [[Int]]()
        
        let rows = input.components(separatedBy: "\n")
        
        print(rows)
        
        var columnCount = 0
        var rowCount = 0
        
        // Loop through the rows delimited by (\n) new line character
        for row in rows {
            let trimmedRow = row.trimmingCharacters(in: .whitespaces)
            
            // Check whether Input is there or not.
            if(rowCount == 0 && trimmedRow.isEmpty){
                return Output.failure(CustomError.noData)
            }
            
            rowCount = rowCount + 1
            // handling user inserting an empty row at the end of the matrix
            if(rowCount == rows.count && trimmedRow.isEmpty){
                return Output.success(inputMatrix)
            }
            
            // Parse  row for Columns delimited by space (" ")
            let columns = trimmedRow.components(separatedBy:.whitespaces)
            let currentRowColumnCount = columns.count;
            
            // Check for uneven columns except the first row
            if (columnCount > 0 && currentRowColumnCount > 0 && currentRowColumnCount != columnCount) {
                return Output.failure(CustomError.invalidFormat)
            }
            
            columnCount = currentRowColumnCount;
            
            // Proceed only if we have columns to process
            if columns.count > 0 {
                var columnMatrix = [Int]()
                for column in columns {
                    // Check for non-numeric characters
                    if let convertedInt = Int(column) {
                        // Group all the columns together
                        columnMatrix.append(convertedInt)
                    } else {
                        // non integer values
                        return Output.failure(CustomError.invalidFormat)
                    }
                }
                
                // Add grouped columns for rows
                inputMatrix.append(columnMatrix)
            }
        }
        
        //Validation success
        return Output.success(inputMatrix)
    }
}
