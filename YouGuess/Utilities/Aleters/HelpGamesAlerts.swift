//
//  HelpAlertsProtocol.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 16.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol HelpGamesAlerts  {
    
    associatedtype T: QuestionViewController = Self
    func showHintAlert()
    func showAnswerAlert()
    func handleHelpAction()
    func handleAnswerAction()
}

extension HelpGamesAlerts {
    
    func showHintAlert()  {
        let alert = UIAlertController(title: "Podpowiedź", message: "Usuń zbędne litery, koszt \(QuestionKeys.hintCost) punkt", preferredStyle: UIAlertControllerStyle.alert)
        let confrimAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            if PointsManager.hasUserEnoughPoints(points: QuestionKeys.hintCost) {
                PointsManager.removeUserPoints(points: QuestionKeys.hintCost)
                self.handleHelpAction() 
            } else {
                UIAlertController.showAlert(withMessage: "Błąd", message: "Brak środków")
            }
        })
        alert.addAction(confrimAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(cancelAlert) in})
        alert.addAction(cancelAction)
        alert.show()        
    }
    
    func showAnswerAlert() {
        let alert = UIAlertController(title: "Odpowiedź", message: "Pokazuje prawidłową odpowiedź, koszt \(QuestionKeys.answerCost) punkty", preferredStyle: .alert)
        let confrimAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            if PointsManager.hasUserEnoughPoints(points: QuestionKeys.answerCost) {
                PointsManager.removeUserPoints(points: QuestionKeys.answerCost)
                self.handleAnswerAction()
            } else {
                UIAlertController.showAlert(withMessage: "Błąd", message: "Brak wystarczających środków")
            }                
        })
        alert.addAction(confrimAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(cancelAlert) in})
        alert.addAction(cancelAction)
        alert.show()
    }
}

