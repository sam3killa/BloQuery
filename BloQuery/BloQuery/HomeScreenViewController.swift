//
//  HomeScreenViewController.swift
//  BloQuery
//
//  Created by Samuel Shih on 4/24/16.
//  Copyright © 2016 Samuel Shih. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class HomeScreenViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    // These will all need to be Question Objects later
    var newQuestions:[Firebase] = []
    var questionTitle = ""
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
                
        myRootRef.childByAppendingPath("questions").observeEventType(.Value, withBlock: { snapshot in
            
            // Clear array
            self.newQuestions = []

            for item in snapshot.children {
                
                // Add question from database to newQuestions array
                self.newQuestions.append(item as! Firebase)
                
            }
            
            self.tableView.reloadData()
            
            }, withCancelBlock: { error in
        })

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as! QuestionsCell
        
        questionTitle = currentCell.questionLabel.text!
        
        performSegueWithIdentifier("questionDetailSegue", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "questionDetailSegue" {
            
            var viewController = segue.destinationViewController as! QuestionDetailViewController
            viewController.passedQuestion = questionTitle
            print("Passing Question Information")
            
        
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.newQuestions.count)
        return self.newQuestions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("QuestionsCell", forIndexPath: indexPath) as! QuestionsCell
        
//        cell.questionLabel.text = self.newQuestions[indexPath.row] as! Firebase
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}
