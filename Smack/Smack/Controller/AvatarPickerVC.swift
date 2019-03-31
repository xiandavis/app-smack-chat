//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Christian Davis on 3/30/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { // STEP 51. Jonny tip: can type UICollflow for last protocol to autocomplete!
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView! // STEP 50.
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Variables
    var avatarType = AvatarType.dark // STEP 57.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self // STEP 52. the delegate is THIS VC, hence self
        collectionView.dataSource = self // click .property for quick help at right ->

        // Jonny deletes boilerplate code
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // Jonny types 'cellForItemAt' to autocomplete entire func
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell { // STEP 54. If we are able to get a cell dequeued and the reuse identifier for it is avatarCell, return cell. we must cast as AvatarCell.
            cell.configureCell(index: indexPath.item, type: avatarType) // STEP 58. item for specific number that we want, type for light/ dark
            return cell
        }
        return AvatarCell() // otherwise return an empty AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { // Jonny types 'number' to autocomplete entire func
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // Jonny types 'number' again, perhaps autocomplete knows he's already implemented numberOfSections() and autocompletes entire func collectionView(numberOfItemsInSection) instead?
        return 28
    }

    // Jonny deletes boilerplate code
    @IBAction func backPressed(_ sender: Any) { // STEP 49
        dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentControlChanged(_ sender: Any) {
        // STEP 59. Quiz: A. Need a check to see which segment is selected, B. Need to change avatarType, C. Need to do *something* to reload the data.
        if segmentControl.selectedSegmentIndex == 0 { // A. I tried segmentControl.isEnabledForSegment(at: 1)
            avatarType = .dark // this is default so I thought I didn't need; would need if light was already active tho, couldn't change back to dark
        } else {
            avatarType = .light // B. I tried self.avatarType = AvatarType.light, why don't you need self?
        }
        collectionView.reloadData() // C. simpler than I thought, had no guess
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 { // for larger screens (like iPhone X) show more icons across:
            numOfColumns = 4
        }
        
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns // subtracts padding & space between columns, leaving space left over for just the cells themselves
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
