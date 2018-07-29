//
//  StatusViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var donationContainer: GradientView!
    @IBOutlet weak var emptyDonationContainer: GradientView!
    
    @IBOutlet weak var deliveryContainer: GradientView!
    @IBOutlet weak var emptyDeliveryContainer: GradientView!
    
    
    @IBOutlet weak var donationItemName: UILabel!
    @IBOutlet weak var donationLabelOne: UILabel!
    @IBOutlet weak var donationLabelTwo: UILabel!
    @IBOutlet weak var donationTextView: UITextView!
    @IBOutlet weak var donationCancelButtonView: GradientView!
    @IBOutlet weak var donationGreenButtonView: GradientView!
    @IBOutlet weak var donationImage: UIImageView!
    
    @IBOutlet weak var deliveryItemName: UILabel!
    @IBOutlet weak var deliveryLabelOne: UILabel!
    @IBOutlet weak var deliveryLabelTwo: UILabel!
    @IBOutlet weak var deliveryTextView: UITextView!
    @IBOutlet weak var deliveryCancelButtonView: GradientView!
    @IBOutlet weak var deliveryGreenButtonView: GradientView!
    @IBOutlet weak var deliveryImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if true { //<- change later
            emptyDonationContainer.isHidden = true
        } else {
            donationContainer.isHidden = true
        }
        
        if true { //<- change later
            emptyDeliveryContainer.isHidden = true
        } else {
            deliveryContainer.isHidden = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Below: Delivery
    @IBAction func deliveryCancelButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deliveryGreenButtonTapped(_ sender: Any) {
    }
    
    //Below: Donation
    @IBAction func donationCancelButtonTapped(_ sender: Any) {
    }
    
    @IBAction func donationGreenButtonTapped(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
