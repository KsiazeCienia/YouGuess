//
//  Quiz.swift
//  YouGuess
//
//  Created by Marcin on 29.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol QuizDelegate: class {
    func userAnswerdCorrect()
    func userAnswerdIncorrect()
}

final class Quiz: NSObject {
    
    //MARK:- Variables
    var nameCharacters = [[Character]]()
    private let question: Question
    private var questionCharacters = [Character]()
    private var userAnswer = [[Int]]()
    private var emptyQuestionSlots = Set<Int>()
    weak private var delegate: QuizDelegate?
    
    init(question: Question, delegate: QuizDelegate) {
        self.question = question
        self.delegate = delegate
    }
    
    func initQuestionCharacters() {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let nameCharactersArray = Array(question.name.characters)
        var questionCharacters = nameCharactersArray.filter({$0 != QuizKeys.spaceCharacter})
        nameCharacters = question.name.to2DCharactersArray(separetedBy: QuizKeys.spaceCharacter)
        let numberOfSpaces = nameCharacters.count - 1
        
        for i in 0 ..< nameCharacters.count {
            userAnswer.append(Array(repeating: QuizKeys.specialCharacter, count: nameCharacters[i].count))
        }
        
        let range = nameCharacters.numberOfElements() < QuizKeys.numberOfCharactersInQuestion ? QuizKeys.numberOfCharactersInQuestion : QuizKeys.numberOfCharactersInBiggerQuestion
        
        for _ in (question.name.characters.count - numberOfSpaces) ..< range {
            let randIndex = Int(arc4random_uniform(UInt32(letters.characters.count)))
            let char = letters.index(letters.startIndex, offsetBy: randIndex)
            questionCharacters.append(letters[char])
        }
        
        questionCharacters.randomize()
        self.questionCharacters = questionCharacters
    }
    
    func answerCollectionViewTappedAt(indexPath: IndexPath) {
        removeLetterFromAnswerCollectionView(section: indexPath.section, index: indexPath.row)
    }
    
    func questionCollectionViewTappedAt(indexPath: IndexPath) {
        if isQuestionCharacter(index: indexPath.row) {
            addLetterToAnswerCollectionView(index: indexPath.row)
            if isAnswerComplete() {
                if isAnswerCorrect() {
                   delegate?.userAnswerdCorrect()
                } else {
                   delegate?.userAnswerdIncorrect()
                }
            }
        }
    }
    
    func removeUnnecessaryLetters() {
        emptyQuestionSlots.removeAll()
        for i in 0 ..< userAnswer.count {
            for j in 0 ..< userAnswer[i].count {
                userAnswer[i][j] = QuizKeys.specialCharacter
            }
        }
        var tmp = [Int]()
        for i in 0 ..< nameCharacters.count {
            for j in 0 ..< nameCharacters[i].count {
                let indexes = findMatches(character: nameCharacters[i][j])
                for index in indexes {
                    if (!tmp.contains(index)) {
                        tmp.append(index)
                        break
                    }
                }
            }
        }
        
        for i in 0..<questionCharacters.count {
            if !tmp.contains(i) {
                emptyQuestionSlots.insert(i)
            }
        }
    }
    
    func getAnswerCharacterAt(section: Int, index: Int) -> Character {
        return questionCharacters[userAnswer[section][index]]
    }
    
    func getQuestionCharacterAt(index: Int) -> Character {
        return questionCharacters[index]
    }
    
    func isAnswerCharacter(section: Int, index:Int) -> Bool {
        return (userAnswer[section][index] != QuizKeys.specialCharacter)
    }
    
    func isQuestionCharacter(index: Int) -> Bool {
        return !emptyQuestionSlots.contains(index)
    }
    
    func isAnswerComplete() -> Bool {
        for i in 0 ..< userAnswer.count {
            if userAnswer[i].contains(QuizKeys.specialCharacter) {
                return false
            }
        }
        return true
    }
    
    private func removeLetterFromAnswerCollectionView(section: Int, index: Int) {
        emptyQuestionSlots.remove(userAnswer[section][index])
        userAnswer[section][index] = QuizKeys.specialCharacter
    }
    
    private func addLetterToAnswerCollectionView(index: Int) {
        emptyQuestionSlots.insert(index)
        for i in 0 ..< userAnswer.count {
            if let currentIndexToInsert = userAnswer[i].index(of: QuizKeys.specialCharacter) {
                userAnswer[i][currentIndexToInsert] = index
                break
            } else {
                continue
            }
        }
    }
    
    private func isAnswerCorrect() -> Bool {
        if isAnswerComplete() {
            let actualAnswer = answerToString()
            if (actualAnswer == question.name) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    private func answerToString() -> String{
        var answer = ""
        for i in 0..<userAnswer.count {
            for j in 0 ..< userAnswer[i].count {
                    answer.append(questionCharacters[userAnswer[i][j]])
            }
            if (i < userAnswer.count - 1) {
                answer.append(QuizKeys.spaceCharacter)
            }
        }
        return answer
    }
    
    private func findMatches(character: Character) -> [Int]{
        var indexes =  [Int]()
        for i in 0..<questionCharacters.count {
            if questionCharacters[i] == character {
                indexes.append(i)
            }
        }
        return indexes
    }
}
