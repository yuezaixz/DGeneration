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
        tableView.dequeueReusableCell(withIdentifier: DGHomeDailyItemCell.kReuseIdentifier, for: indexPath)
    }
    
    
}

extension DGHomeDailyListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: DGHomeDailyHabitCell.kReuseIdentifier, for: indexPath)
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
