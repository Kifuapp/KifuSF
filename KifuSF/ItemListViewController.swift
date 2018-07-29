//
//  ItemListViewController.swift
//  KifuSF
//
//  Created by Shutaro Aoyama on 2018/07/28.
//  Copyright © 2018年 Alexandru Turcanu. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var postTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //return number of posts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = postTable.dequeueReusableCell(withIdentifier: "postCell") as! ItemPostCell
        postCell.itemName.text = "DummyText"
        postCell.distance.text = "\(1.0) miles from here"
        postCell.postInfo.text = "@\("USERNAME") - \("00:00 AM")"
        
        postCell.delegate = self
        return postCell
    }
}

extension ItemListViewController: UITableViewDelegate {
    
}

extension ItemListViewController: ItemPostCellDelegate {
    func requestButtonTapped(cell: ItemPostCell) {
        
    }
}
