//
//  ViewController.swift
//  YouGuess
//
//  Created by Marcin Włoczko on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class LevelsViewController:  BaseViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var levelsTableView: UITableView!
    @IBOutlet private  weak var adView: AdView!
    
    //MARK:- Constants
    
    var levelsList = [Level]()
    
    //MARK:- Variables
    
    var selectedLevel: Level?
    //var unlockedLevels = [Int]()
    
    //MARK:- References
    
    let levelService = LevelService()
    
    //MARK:- VC'c Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAdView()
        //MARK:- TODO zrobić lepiej 
        //unlockedLevels = LevelsManager.getUnlockedLevels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //MARK:- TODO pokombinować żeby sekcje
        levelsTableView.reloadData()
    }
    
    private func setupAdView() {
        adView.hookViewController(self)
    }

    //MARK:- Main
    
    private func setupTableView() {
        levelsTableView.delegate = self
        levelsTableView.dataSource = self
        levelsTableView.register(LevelTableViewCell.self)
    }
    
    fileprivate func setupLevelInfoLabel(label: UILabel, level: Level){
        let height = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        let width = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width)
        label.addConstraints([height,width])
        
        let numberOfResolvedQuestions = ScoreManager.getNumberOfResolvedQuestions(inLevel: level.number)
        label.textAlignment = .center
        label.text = "\(numberOfResolvedQuestions)\\\(level.youtubers.count)"
        label.font = UIFont(name: AppDefaults.mainFont, size: 25)
        label.textColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let singleLevelVC = segue.destination as! SingleLevelViewController
        singleLevelVC.levelToDisplay = selectedLevel
    }
    
    private func showSingleLevelView() {
        guard let singleLevelVC = Storyboard.Main.instantiateViewController(withIdentifier: SingleLevelViewController.identifier) as? SingleLevelViewController else { return }
        singleLevelVC.levelToDisplay = selectedLevel
        navigationController?.pushViewController(singleLevelVC, animated: true)
    }
    
    //MARK:- Czy mają też być weak self
    fileprivate func showBuyLevelAlert(level: Level) -> UIAlertController {
        let alert = UIAlertController(title: "Poziom \(level.number)", message: "Odblokuj poziom cena \(level.price) punktów", preferredStyle: UIAlertControllerStyle.alert)
        
        let confrimAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (confirmAlert) in
            if PointsManager.hasUserEnoughPoints(points: level.price) {
                PointsManager.removeUserPoints(points: level.price)
                self.delegate?.refreshPointsStatus()
                LevelsManager.addUnlockedLevel(level: level.number - 1)
                //self.unlockedLevels = LevelsManager.getUnlockedLevels()
                //MARK:- TODO pomyśleć nad relodem jednej komórki
                self.levelsTableView.reloadData()
                self.showAlert(withTitle: "Gratualcje!", message: "Odblokowano nowy poziom")
            } else {
                self.showAlert(withTitle: "Błąd", message: "Brak wystarczających środków")
            }
        })
        alert.addAction(confrimAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(cancelAlert) in})
        alert.addAction(cancelAction)
        return alert
        }
    
    fileprivate func showAlert(withTitle title:String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension LevelsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return levelsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //MARK:- TODO zrobić lepiej
        return LevelListKeys.spacingBetweenCells + 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        if LevelsManager.contains(level: section) {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(label)
            setupLevelInfoLabel(label: label, level: levelsList[section])
        } else {
            //MARK:- TODO info o cenie?
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LevelTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        if LevelsManager.contains(level: indexPath.section) {
            cell.setUpWithUnlockedImage(level: indexPath.section)
        } else {
            cell.setUpWithLockedImage(level: indexPath.section)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if LevelsManager.contains(level: indexPath.section) {
            selectedLevel = levelsList[indexPath.section]
            showSingleLevelView()
        } else {
            let alert = showBuyLevelAlert(level: levelsList[indexPath.section])
            self.present(alert, animated: true, completion: nil)
        }
    }
}
