//
//  LowestCostPath.swift
//  LowestCostPath
//
//  Created by Roopa on 13/08/18.
//  Copyright © 2018 photon. All rights reserved.
//

import UIKit

class LowestTotalCostViewController: UIViewController {
    
    @IBOutlet weak var leastCostPath: UILabel!
    @IBOutlet weak var leastCost: UILabel!
    @IBOutlet weak var pathOfLeastCostExists: UILabel!
    @IBOutlet weak var costTextView: UITextView!
    @IBOutlet weak var outPutLabel: UILabel!
    var userInput = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.costTextView.text = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
    }
    
    @IBAction func submit(_ sender: Any) {
        self.costTextView .resignFirstResponder()
        getLeastCostPath(input: self.costTextView.text)
    }
    
    func getLeastCostPath(input:String)
    {
        outPutLabel.isHidden = false
        do {
            let processor = try MatrixProcessor(with: input)
            if let result = processor.processMatrix() {
                self.pathOfLeastCostExists.textColor = UIColor.black
                self.pathOfLeastCostExists.text = result.pathCompleted ? "Yes":"No"
                self.leastCost.text = "\(result.cost)"
                self.leastCostPath.text = "\(result.path)"
            }
        }
        catch let error {
            self.pathOfLeastCostExists.textColor = UIColor.red
            self.pathOfLeastCostExists.text = error.localizedDescription
            self.leastCost.text = ""
            self.leastCostPath.text = ""
            
        }
    }
    
}

