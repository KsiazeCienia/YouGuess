//
//  QuizService .swift
//  YouGuess
//
//  Created by Marcin Włoczko on 06.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol YouTuberControllerProtocol {
    var question: Question { get }
    var isNextButtonEnabled: Bool { get }
    var quizService: QuizCooridnator { get }
}

final class QuizCooridnator {
    
    private var questions = [Question]()
    private var currentQuestion: Question
    private var shouldNextButtonBeEnabled: Bool
    
    init(questions: [Question], questionTapped: Question) {
        self.currentQuestion = questionTapped
        self.questions = questions
        let indexOfCurrentQuestion = questions.index(of: currentQuestion)
        if let actualIndex = indexOfCurrentQuestion {
            shouldNextButtonBeEnabled = actualIndex + 1 < questions.count ? true : false
        } else {
            shouldNextButtonBeEnabled = false
        }
    }
    
    func decideWhichYouTuberDisplay(delegate: MainNavigationController, replaceCurrentVC: Bool) {
        if currentQuestion.isDone {
            displayResolvedYouTuber(delegate: delegate, replaceCurrentVC: replaceCurrentVC)
        } else {
            displayYouTuberToResolve(delegate: delegate, replaceCurrentVC: replaceCurrentVC)
        }
    }
    
    private func displayYouTuberToResolve(delegate: MainNavigationController, replaceCurrentVC: Bool) {
        guard let questionVC = Storyboard.YouTuberToResolve.instantiateViewController(withIdentifier: QuestionViewController.identifier) as? QuestionViewController else { return }
        questionVC.question = currentQuestion
        questionVC.quizService = self
        questionVC.isNextButtonEnabled = shouldNextButtonBeEnabled
        if replaceCurrentVC {
            delegate.replaceCurrentViewControllerWith(viewController: questionVC, animated: true)
        } else {
            delegate.pushViewController(questionVC, animated: true)
        }
    }
    
    private func displayResolvedYouTuber(delegate: MainNavigationController, replaceCurrentVC: Bool) {
        guard let resolvedVC = Storyboard.ResolvedYouTuber.instantiateViewController(withIdentifier: ResolvedYouTuberViewController.identifier) as? ResolvedYouTuberViewController else { return }
        resolvedVC.question = currentQuestion
        resolvedVC.quizService = self
        resolvedVC.isNextButtonEnabled = shouldNextButtonBeEnabled
        if replaceCurrentVC {
            delegate.replaceCurrentViewControllerWith(viewController: resolvedVC, animated: true)
        } else {
            delegate.pushViewController(resolvedVC, animated: true)
        }
    }
    
    func prepareNextYouTuber(delegate: MainNavigationController) {
        let indexOfCurrentQuestion = questions.index(of: currentQuestion)
        if let actualIndex = indexOfCurrentQuestion {
            let nextIndex = actualIndex + 1
            // change to nextQuestion and display it
            if nextIndex < questions.count {
                currentQuestion = questions[nextIndex]
                decideWhichYouTuberDisplay(delegate: delegate, replaceCurrentVC: true)
                shouldNextButtonBeEnabled = true
            } else {
                shouldNextButtonBeEnabled = false
            }
        }
    }
}
