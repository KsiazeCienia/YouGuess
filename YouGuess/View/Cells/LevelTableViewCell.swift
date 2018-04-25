//
//  UnlockedTableViewCell.swift
//  YouGuess
//
//  Created by Marcin on 14.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class LevelTableViewCell: UITableViewCell {

   
    @IBOutlet weak var levelImage: UIImageView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: 0.05, animations: {
            self.layer.transform = CATransform3DMakeScale(highlighted ? 0.85 : 1, highlighted ? 0.85 : 1, 1)
            self.setNeedsLayout()
        })
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpWithUnlockedImage(level: Int) {
        levelImage.image = UIImage(named: "Poziom\(level + 1)")!
        self.backgroundColor = UIColor.clear
    }
    
    func setUpWithLockedImage(level: Int) {
        levelImage.image = UIImage(named: "Poziom\(level + 1)Lock")!
        self.backgroundColor = UIColor.clear
    }
    
    
}
