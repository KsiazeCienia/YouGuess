
//
//  QuestionViewController.swift
//  YouGuess
//
//  Created by Marcin on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class QuestionViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet private weak var questionCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var nextButton: HelpButton!
    @IBOutlet private weak var questionImage: UIImageView!
    @IBOutlet private weak var answerCollectionView: UICollectionView!
    @IBOutlet private weak var questionCollectionView: UICollectionView!
    @IBOutlet private weak var adView: AdView!
    
    //MARK:- Variables
    
    var quiz: Quiz!
    var question: Question!
    var quizService: QuizCooridnator!
    var isNextButtonEnabled: Bool = false
    
    //MARK:- VC's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        prepareQuiz()
        setupCollectionsViews()
        setupAdView()
        nextButton.alpha = isNextButtonEnabled == true ? 1 : 0
    }
    
    //MARK:- IBActions
    
    @IBAction private func hintButtonTapped(_ sender: Any) {
        showHintAlert()
    }
    
    @IBAction private  func answerButtonTapped(_ sender: Any) {
        showAnswerAlert()
    }
    
    @IBAction private  func nextButtonTapped(_ sender: Any) {
        changeToNextQuestion()
    }
    
    //MARK:- Main
    
    private func registerCells() {
        questionCollectionView.register(LetterCollectionViewCell.self)
        answerCollectionView.register(LetterCollectionViewCell.self)
        questionCollectionView.register(EmptySlotCollectionViewCell.self)
        answerCollectionView.register(EmptySlotCollectionViewCell.self)
        questionCollectionView.register(InvisibleCollectionViewCell.self)
        answerCollectionView.register(InvisibleCollectionViewCell.self)
    }
    
    private func prepareQuiz() {
        quiz = Quiz(question: question, delegate: self)
        quiz.initQuestionCharacters()
        questionImage.image = question.image
        questionImage.layer.borderWidth = 4
        questionImage.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupCollectionsViews() {
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        let multiplayer = CGFloat(quiz.nameCharacters.numberOfElements() <= QuizKeys.numberOfCharactersInQuestion ? 1 : 1.25)
        let screenHeight = UIScreen.main.bounds.height
        questionCollectionViewHeight.constant = CGFloat(0.14*screenHeight*multiplayer)
    }
    
    private func setupAdView() {
        adView.hookViewController(self)
    }
    
    @objc private func changeToNextQuestion() {
        guard let nc = navigationController as? MainNavigationController else { return }
        quizService.prepareNextYouTuber(delegate: nc)
    }
}

//MARK:- QuizDelegate
extension QuestionViewController: QuizDelegate {
    
    func userAnswerdIncorrect() {
        questionImage.shake()
    }
    
    func userAnswerdCorrect() {
        ScoreManager.addUserScore(withLevel: question.level, challengeName: question.name)
        PointsManager.addUserPoints(points: QuestionKeys.numberOfPointsForAnsweringQuestion)
        delegate?.refreshPointsStatus()
        questionImage.layer.borderColor = UIColor(red: 251/255, green: 190/255, blue: 5/255, alpha: 1).cgColor
        let _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeToNextQuestion), userInfo: nil, repeats: false)
        log(message: "User anserd correct for question with youtuber \(question.name) on level \(question.level)", event: .log)
    }
}

//MARK:- HelpGamesAlerts
extension QuestionViewController: HelpGamesAlerts {
    
    func handleAnswerAction() {        
        userAnswerdCorrect()
        answerCollectionView.reloadData()
        questionCollectionView.reloadData()
    }
    
    func handleHelpAction() {        
        quiz.removeUnnecessaryLetters()
        questionCollectionView.reloadData()
        answerCollectionView.reloadData()
        delegate?.refreshPointsStatus()
    }
}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView == answerCollectionView ? quiz.nameCharacters.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let range = quiz.nameCharacters.numberOfElements() < QuizKeys.numberOfCharactersInQuestion ? QuizKeys.numberOfCharactersInQuestion : QuizKeys.numberOfCharactersInBiggerQuestion
        return collectionView == answerCollectionView ? quiz.nameCharacters[section].count : range
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == answerCollectionView) {
            // Setting cells for answerCollectionView
            if quiz.isAnswerCharacter(section: indexPath.section, index: indexPath.row) {
                let letterCell: LetterCollectionViewCell = answerCollectionView.dequeueReusableCell(for: indexPath)
                letterCell.setUpCell(letter: String(quiz.getAnswerCharacterAt(section: indexPath.section, index: indexPath.row)))
                return letterCell
            } else {
                let emptyCell: EmptySlotCollectionViewCell = answerCollectionView.dequeueReusableCell(for: indexPath)
                return emptyCell
            }
            
        } else {
            // Setting cells for questionCollectionView
            if quiz.isQuestionCharacter(index: indexPath.row) {
                let letterCell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: LetterCollectionViewCell.identifier, for: indexPath) as! LetterCollectionViewCell
                letterCell.setUpCell(letter: String(quiz.getQuestionCharacterAt(index: indexPath.row)))
                return letterCell
                
            } else {
                let invisibleCell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: InvisibleCollectionViewCell.identifier, for: indexPath) as! InvisibleCollectionViewCell
                return invisibleCell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == answerCollectionView) {
            quiz.answerCollectionViewTappedAt(indexPath: indexPath)
        } else {
            quiz.questionCollectionViewTappedAt(indexPath: indexPath)
        }
        questionCollectionView.isUserInteractionEnabled = !quiz.isAnswerComplete()
        questionCollectionView.reloadData()
        answerCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let words =  collectionView == answerCollectionView ? quiz.nameCharacters[section] : []
        guard !words.isEmpty else { return UIEdgeInsets.zero }
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let totalCellWidth = cellWidth * CGFloat(words.count) + 0 * (CGFloat(words.count)-1)
        let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
        if totalCellWidth < contentWidth {
            let padding = (contentWidth - totalCellWidth) / 2.0
            return UIEdgeInsetsMake(0, padding, 0, padding)
        }else {
            return UIEdgeInsets.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == answerCollectionView {
            let words = quiz.nameCharacters[indexPath.section]
            if collectionView.frame.size.width <= CGFloat(words.count * Int(LetterCollectionViewCell.side)) {
                let width = (collectionView.frame.size.width / CGFloat(words.count)) - CGFloat(5)
                return CGSize(width: width, height: width)
            }
            return CGSize(width: LetterCollectionViewCell.side, height: LetterCollectionViewCell.side)
        } else {
            let rows = quiz.nameCharacters.numberOfElements() <= QuizKeys.numberOfCharactersInQuestion ? 2 : 2.5
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom + (flowLayout.minimumLineSpacing * CGFloat(rows))
            let size = Int((collectionView.bounds.height - totalSpace) / CGFloat(rows))
            return CGSize(width: size, height: size)
        }
    }
}

//MARK:- Loggable
extension QuestionViewController: Loggable { }
