//
//  ResolvedYouTuberViewController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 06.10.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class ResolvedYouTuberViewController: BaseViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var adView: AdView!
    
    var quizService: QuizCooridnator!
    var question: Question!
    var isNextButtonEnabled: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdView()
        label.text = question.name.uppercased()
        nextButton.alpha = isNextButtonEnabled == true ? 1 : 0
        image.image = question.image
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        print(question.name)
        guard let nc = navigationController as? MainNavigationController else { return }
        
        quizService.prepareNextYouTuber(delegate: nc)
    }
    
    private func setupAdView() {
        adView.hookViewController(self)
    }
}
