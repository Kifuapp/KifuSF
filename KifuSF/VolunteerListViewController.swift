//
//  VolunteerListViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class VolunteerListViewController: UIViewController {

    @IBOutlet weak var volunteerTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension VolunteerListViewController: UITableViewDelegate {
    
}

extension VolunteerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //Change Later
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let volunteerCell = volunteerTable.dequeueReusableCell(withIdentifier: "volunteerCell") as! VolunteerCell
        volunteerCell.delegate = self
        return volunteerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
    }
}

extension VolunteerListViewController: VolunteerCellDelegate {
    func confirmButtonTapped(cell: VolunteerCell) {
        
    }
    
    
}
