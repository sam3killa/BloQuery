//
//  Questions.swift
//  BloQuery
//
//  Created by Samuel Shih on 4/27/16.
//  Copyright © 2016 Samuel Shih. All rights reserved.
//

import Foundation
import UIKit

// When user creates a question, it gets added to the questionsArray and then questionsArray is what is displayed in the cells

class Question {

    var question: String
        
    init?(question: String) {
        
        // Initialize Stored Properties
        self.question = question
        
        // If Initialization fails
        if question.isEmpty {
            return nil
        }
        
        
    }

}

