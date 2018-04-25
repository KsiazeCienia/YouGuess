//
//  Constants.swift
//  YouGuess
//
//  Created by Marcin on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

struct QuizKeys {
    static let numberOfCharactersInQuestion = 16
    static let numberOfCharactersInBiggerQuestion = 24
    static let numberOfIterationInMixing = 20
    static let specialCharacter = 100
    static let space = 150
    static let spaceCharacter:Character = " "
}

struct QuestionKeys {
    static let hintCost = 1
    static let answerCost = 3
    static let numberOfPointsForAnsweringQuestion = 1
}

struct AppDefaults {
    static let mainFont = "PoiretOne-Regular"
}

struct LevelListKeys {
    static let spacingBetweenCells: CGFloat = 10
    static let numberOfQuestionsInLevel = 20
}

struct Storyboard {
    static let Info = UIStoryboard(name: "Info", bundle: nil)
    static let ResolvedYouTuber = UIStoryboard(name: "ResolvedYouTuber", bundle: nil)
    static let YouTuberToResolve = UIStoryboard(name: "YouTuberToResolve", bundle: nil)
    static let LoginRegister = UIStoryboard(name: "LoginRegister", bundle: nil)
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

enum HTTPMethods: String {
    case GET = "GET"
}

enum UserDefaultsKeys: String {
    case UserScore = "UserScore"
    case UserPoints = "UserPoints"
    case UnlockedLevels = "UnlockedLevels"
    case UserFacebookId = "UserFacebookId"
}

enum AdKeys: String {
    case adMobBannerId = "AdMob banner Id"
    case adMobVideoId = "Ad Mob Video Id"
    case testAdId = "ca-app-pub-0123456789012345/0123456789"
}


