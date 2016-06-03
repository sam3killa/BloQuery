    //
//  QuestionCreationViewController.swift
//  BloQuery
//
//  Created by Samuel Shih on 4/28/16.
//  Copyright © 2016 Samuel Shih. All rights reserved.
//

import UIKit

class QuestionCreationViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        let questionText = questionTextField.text
        let questionRef = myRootRef.childByAppendingPath("questions")
        let newQuestionsRef = questionRef.childByAutoId()
        
        let userid = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        
        // Return a UID of the user
        let payLoad = ["text": questionText! ,"user": userid!]
        
        // Create a Dictionary
        newQuestionsRef.setValue(payLoad)
        
        let alert = UIAlertController(title: "Question Submitted!", message: "You have asked a question to the world", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yay!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    @IBAction func doneButtonClicked(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
