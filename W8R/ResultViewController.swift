//
//  ResultViewController.swift
//  W8R
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 04/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet private weak var resultLabel: UILabel!
    var resultText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = resultText ?? "Failed"
    }
    
}
