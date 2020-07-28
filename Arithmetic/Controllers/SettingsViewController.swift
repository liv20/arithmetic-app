//
//  SettingsViewController.swift
//  Arithmetic
//
//  Created by Victor Li on 7/24/20.
//  Copyright © 2020 Victor Li. All rights reserved.
//

import UIKit
import CollectionViewWaterfallLayout

class SettingsViewController: ArithmeticViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCellIP : IndexPath? = IndexPath(row: UserDefaults.standard.integer(forKey: "GradientPosition"), section: 0)
    var originalCellIP : IndexPath = IndexPath(row: UserDefaults.standard.integer(forKey: "GradientPosition"), section: 0)

    var cellSize : CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GradientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reusableCell")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        collectionView.backgroundColor = .clear
        changeNavBarAppearance()
        //navigationController?.navigationBar.isHidden = false

        let waterfallLayout = CollectionViewWaterfallLayout()
        waterfallLayout.columnCount = 3
        waterfallLayout.minimumColumnSpacing = 10
        waterfallLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = waterfallLayout

    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }


    func changeNavBarAppearance() {
        if let navBar = navigationController?.navigationBar {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
            navBar.backgroundColor = .clear
        }

        let customFont = UIFont(name: "AvenirNext-Regular", size: 17.0)!
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count: \(gradients.count)")
        return gradients.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusableCell", for: indexPath) as! GradientCollectionViewCell
        cell.colors = gradients[indexPath.row]
        cell.layer.cornerRadius = cell.frame.height / 5

        if indexPath == originalCellIP {
            cell.layer.borderColor = UIColor(displayP3Red: 255, green: 215, blue: 0, alpha: 1).cgColor
            cell.isSelected = true
        }

        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaults.set(indexPath.row, forKey: "GradientPosition")

        if indexPath != originalCellIP {
            if let originalCell = self.collectionView.cellForItem(at: originalCellIP) as? GradientCollectionViewCell {
                originalCell.isSelected = false
                originalCell.layer.borderColor = UIColor.clear.cgColor
            }
        }

        if let cell = self.collectionView.cellForItem(at: indexPath) as? GradientCollectionViewCell {
            if indexPath != selectedCellIP {
                cell.layer.borderColor = UIColor(displayP3Red: 255, green: 215, blue: 0, alpha: 1).cgColor
                self.selectedCellIP = indexPath
                self.animateChange(duration: 2, indexPath: indexPath)
            }
        }

    }

    func animateChange(duration: Double, indexPath: IndexPath) {
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = duration
        gradientChangeAnimation.toValue = gradients[indexPath.row]
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.fillMode = .forwards
        self.view.layer.sublayers?[0].add(gradientChangeAnimation, forKey: "colorChange\(indexPath.row)")
    }


    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GradientCollectionViewCell {
            cell.layer.borderColor = UIColor.clear.cgColor

        }
    }

}

extension SettingsViewController : CollectionViewWaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSize(width: 120, height: 120)
    }


}
