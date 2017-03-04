//
//  PaymentViewController.swift
//  W8R
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 04/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit
import FirebaseInstanceID
import FirebaseMessaging
import SquareRegisterSDK

private let clientID = "sq0idp-t6FVRTrnY5UtE3JLU2wJJA"
private let callbackURL = URL(string: "waitr://com.joamafer.waitr")!
private let currency = "USD"

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    var price: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let price = price {
            self.priceLabel.text = "£\(CGFloat(price)/100.0)"
        }
    }
    
    @IBAction func pay(_ sender: UIButton) {
        guard let price = price else {
            return
        }
        
        SCCAPIRequest.setClientID(clientID)
        
        do {
            let amount = try SCCMoney(amountCents: price, currencyCode: currency)
            let apiRequest = try SCCAPIRequest(callbackURL: callbackURL,
                                               amount: amount,
                                               userInfoString: nil,
                                               merchantID: nil,
                                               notes: "We hope you loved it!",
                                               customerID: nil,
                                               supportedTenderTypes: .card,
                                               clearsDefaultFees: false,
                                               returnAutomaticallyAfterPayment: true)
            try SCCAPIConnection.perform(apiRequest)
        } catch {
            print("Error performing payment")
        }
    }

}
