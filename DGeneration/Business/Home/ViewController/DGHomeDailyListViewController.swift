//
//  DGHomeDailyListViewController.swift
//  DGeneration
//
//  Created by 吴迪玮 on 2020/6/7.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit
import EMTNeumorphicView

class DGHomeDailyListViewController: DGBaseSegmentViewController {
    @IBOutlet weak var dailyTableView: UITableView!
    @IBOutlet weak var habitCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            dailyTableView.contentInsetAdjustmentBehavior = .never
            habitCollectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

}

extension DGHomeDailyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DGHomeDailyItemCell.kReuseIdentifier, for: indexPath)
        
        if let cell = cell as? DGHomeDailyItemCell {
            cell.setupData([0, 0, 1, 4, 8, 0, 0, 0, 6, 4])
        }
        
        return cell
    }
    
    
}

extension DGHomeDailyListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DGHomeDailyHabitCell.kReuseIdentifier, for: indexPath)
        
        if let cell = cell as? DGHomeDailyHabitCell {
            cell.cellIndex = indexPath.row
            switch indexPath.row {
            case 0:
                cell.setUpData(amount: 10, title: "Leaning Skills", strs: ["LeetCode 3 question per day", "Study English 30 minutes per day", "Read Medium 30 minutes per day"])
            default:
                cell.setUpData(amount: 6, title: "Keep Fit", strs: ["Run 10 kilometers", "Table support 10 minutes per day", "Drink 1L Water"])
            }
        }
        
        return cell
    }
    
    
}

extension DGHomeDailyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 168)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }
}
