//
//  WriteAnswerViewController.swift
//  BloQuery
//
//  Created by Samuel Shih on 5/5/16.
//  Copyright © 2016 Samuel Shih. All rights reserved.
//

import UIKit

class WriteAnswerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func submitAnswerPressed(sender: AnyObject) {
        
        // Adds whatever is in the textbox, as a child of question?
        let questionRef = myRootRef.childByAppendingPath("questions")
        let newQuestionsRef = questionRef.childByAutoId()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
