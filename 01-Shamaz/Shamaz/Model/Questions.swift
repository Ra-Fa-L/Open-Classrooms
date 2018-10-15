//
//  Questions.swift
//  Shamaz
//
//  Created by Rafal Padberg on 08.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

// Class to hold all questions -> initilize once and use all of its variables
class Questions
{
    private let pastSingular =
    [
        "What have you eaten yesterday for a breakfast?",
        "Did you leave your town yesterday?",
        "How long were you watching movies yesterday?",
        "Did you workout yesterday?",
        "What is the funiest thing that happened to you yesterday?",
        "Did you sleep well yesterday?",
    ]
    
    private let pastPlural =
    [
        "What ist the best meal you have eaten in you last ",
        "Did you leave your town in the last ",
        "How many movies did you watch in the last ",
        "Did you workout in last ",
        "What is the funiest thing that happened to you in last ",
        "How long did you sleep in your last ",
    ]
    
    private let pastPlural2 =
    [
        "What did you eat ",
        "Where were you besides home ",
        "What did you watch on the TV ",
        "Did you meet some friends or family ",
        "Can you recall something funny from ",
        "Did you go to work ",
    ]
    
    private let futureSingular =
    [
        "What will you eat tomorrow for a dinner?",
        "Will you go somewhere tomorrow?",
        "Have something planned for tommorow?",
        "Tommorow is a great day to exercise don't you think?",
        "Do you intend to do something crazy tomorrow?",
        "When will you wake up tommorow?",
    ]
    
    private let futurePlural =
    [
        "What restaurant are going to visit in the next ",
        "Will you leave your town in the next ",
        "What movies are are looking forward to see in the next ",
        "Will you work out in the next ",
        "What is the craziest thing you will be doing in your next ",
        "Will you see any of your family members in the next ",
        "Do you have some special plans for the next ",
        "Will you drive you car in  ",
        "Will you attend any concert or something simmilar within the next ",
        "Does anyone from your family or friends have a birthday in the next ",
        "Will you have a vacation in the next ",
        "What will you buy in ",
    ]
    
    // Return the number of questions pro PAST or FUTURE -> needs to be manually adjusted
    private func getNumberOfQuestionsPerTime() -> Int
    {
        return 12
    }
    
    /*
     Return a message with either past or future question
     
     If inThePast == true -> fetch from past-Array | if false -> fetch from future
     If random number is 1 -> Singular question
     
     FUTURE: If random number is 2-13:
     Fetch a message from Plural but subtract 2 for the id
     num = 2-13 -> id = 0-11 from futurePlural | id = num - 2
     
     PAST: 2 different endings:
     num 2-7 -> id = 0-5 from pastPlural | id = num - 2
     num 8-13 -> id = 0-5 from pastPlural2 | id = num - 8
     
     Reason for this logic is different sentence endings | "X days ago?" & "X days?"
     */
    func createMessage(fromThePast: Bool) -> String
    {
        let number = Int.random(in: 1 ... (getNumberOfQuestionsPerTime() + 1))
        var message = ""
        
        if fromThePast
        {
            if number == 1
            {
                let secondNumber = Int.random(in: 0 ..< 6)
                message = pastSingular[secondNumber]
            }
            else
            {
                if number > 7
                {
                    message = pastPlural2[number - 8] + "\(number) days ago?"
                }
                else
                {
                    message = pastPlural[number - 2] + "\(number) days?"
                }
            }
        }
        else
        {
            if number == 1
            {
                let secondNumber = Int.random(in: 0 ..< 6)
                message = futureSingular[secondNumber]
            }
            else
            {
                message = futurePlural[number - 2] + "\(number) days?"
            }
        }
        return message
    }
}
