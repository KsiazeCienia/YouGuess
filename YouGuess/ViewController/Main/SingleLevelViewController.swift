//
//  SingleLevelViewController.swift
//  YouGuess
//
//  Created by Marcin on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class SingleLevelViewController: BaseViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var questionsCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var adView: AdView!
    
    //MARK:- Variables
    
    var levelToDisplay: Level?
    private lazy var progress = 0
    fileprivate var questions = [Question]() { didSet { questionsCollectionView.reloadData() } }
    
    //MARK:- VC's Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initQuestions()
        initCollectionView()
        setupAdView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionsCollectionView.reloadData()
    }
    
    //MARK:- Main
    
    private func setupAdView() {
        adView.hookViewController(self)
    }
    
    private func initCollectionView() {
        questionsCollectionView.delegate = self
        questionsCollectionView.dataSource = self
        questionsCollectionView.register(QuestionCollectionViewCell.self)
    }
    
    private func initQuestions() {
        activityIndicator.startAnimating()
        guard let actualLevel = levelToDisplay?.number else { return  }
        guard let actaulYoutubers = (levelToDisplay?.youtubers.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }) else { return }
        actaulYoutubers.forEach{ downloadPhoto(withData: $0, level: actualLevel) }
    }
    
    private func checkProgressState() {
        progress += 1
        guard let count = levelToDisplay?.youtubers.count else { return }
        guard count == progress else { return }
        activityIndicator.stopAnimating()
        progress = 0
        
    }
    
    private func downloadPhoto(withData youtuber: YouTuber, level: Int) {
        ImageProvider.getImage(URLBuilder.fireBaseStorage(withLevel: level, path: youtuber.path)) { [weak self] (image, succes) in
            guard let actugalImage = image else { return }
            let question = Question(name: youtuber.name, image: actugalImage, level: level, path: youtuber.path)
            self?.questions.append(question)
            self?.checkProgressState()
        }
    }
}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension SingleLevelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let columns = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(columns - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(columns))
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questionsCollectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.identifier, for: indexPath) as! QuestionCollectionViewCell
        cell.setupCell(withQuestion: questions[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quizService = QuizCooridnator(questions: questions, questionTapped: questions[indexPath.row])
        guard let nc = navigationController as? MainNavigationController else { return  }
        quizService.decideWhichYouTuberDisplay(delegate: nc, replaceCurrentVC: false)
    }
}
