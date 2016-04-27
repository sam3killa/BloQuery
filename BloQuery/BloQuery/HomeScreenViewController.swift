//
//  HomeScreenViewController.swift
//  BloQuery
//
//  Created by Samuel Shih on 4/24/16.
//  Copyright © 2016 Samuel Shih. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return tableView .dequeueReusableCellWithIdentifier("QuestionsCell", forIndexPath: indexPath)
        
    }
}
