//
//  OnboardingViewController.swift
//  CardinalKit_Example
//
//  Created by Surabhi Mundada on 1/12/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import UIKit
import ResearchKit

struct SurveyViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> SurveyViewCoordinator {
        SurveyViewCoordinator()
    }
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {}
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {

        let sampleSurveyTask: ORKOrderedTask = {
            var steps = [ORKStep]()
            
            // Instruction step
            let instructionStep = ORKInstructionStep(identifier: "IntroStep")
            instructionStep.title = "Patient Questionnaire"
            instructionStep.text = "This information will help your doctors keep track of how you feel and how well you are able to do your usual activities. If you are unsure about how to answer a question, please give the best answer you can and make a written comment beside your answer."
            
            steps += [instructionStep]
            
            //In general, would you say your health is:
            let healthScaleAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 5, minimumValue: 1, defaultValue: 3, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Poor")
            let healthScaleQuestionStep = ORKQuestionStep(identifier: "HealthScaleQuestionStep", title: "Question #1", question: "In general, would you say your health is:", answer: healthScaleAnswerFormat)
            
            steps += [healthScaleQuestionStep]
            
            let textChoices = [
                ORKTextChoice(text: "Yes, Limited A lot", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Yes, Limited A Little", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "No, Not Limited At All", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
            ]
            let textChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
            let textStep = ORKQuestionStep(identifier: "TextStep", title: "Daily Activities", question: "MODERATE ACTIVITIES, such as moving a table, pushing a vacuum cleaner, bowling, or playing golf:", answer: textChoiceAnswerFormat)
            
            steps += [textStep]
            
            
            let formItem = ORKFormItem(identifier: "FormItem1", text: "MODERATE ACTIVITIES, such as moving a table, pushing a vacuum cleaner, bowling, or playing golf:", answerFormat: textChoiceAnswerFormat)
            let formItem2 = ORKFormItem(identifier: "FormItem2", text: "Climbing SEVERAL flights of stairs:", answerFormat: textChoiceAnswerFormat)
            let formStep = ORKFormStep(identifier: "FormStep", title: "Daily Activities", text: "The following two questions are about activities you might do during a typical day. Does YOUR HEALTH NOW LIMIT YOU in these activities? If so, how much?")
            formStep.formItems = [formItem, formItem2]
            
            steps += [formStep]
            
            let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
            let booleanQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nil, question: "In the past four weeks, did you feel limited in the kind of work that you can accomplish?", answer: booleanAnswer)
            
            steps += [booleanQuestionStep]
            
            // answer value format
            let monthArray = [
                ORKTextChoice(text: "January", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "February", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "March", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
            ]
            let valuePickerFormat = ORKValuePickerAnswerFormat(textChoices: monthArray)
            let valuePickerFormatStep = ORKQuestionStep(identifier: "ValuePickerStep", title: nil, question: "Select a month in which these symptoms have been occuring in", answer: valuePickerFormat)
            
            steps += [valuePickerFormatStep]
            
            //SUMMARY
            let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
            summaryStep.title = "Thank you."
            summaryStep.text = "We appreciate your time."
            
            steps += [summaryStep]
            
            return ORKOrderedTask(identifier: "SurveyTask-Assessment", steps: steps)
        }()
        
        let taskViewController = ORKTaskViewController(task: sampleSurveyTask, taskRun: nil)
        taskViewController.delegate = context.coordinator
        
        // & present the VC!
        return taskViewController
    }
    
}
