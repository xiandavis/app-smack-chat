//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Christian Davis on 3/30/19.
//  Copyright © 2019 xianapps. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { // STEP 51.
    
    // STEP 50. Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self // STEP 52.
        collectionView.dataSource = self

        // Jonny deletes boilerplate code
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // Jonny types 'cellForItemAt' to autocomplete entire func
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell { // STEP 54. If we are able to get a cell dequeued and the reuse identifier for it is avatarCell, return cell. we must cast as AvatarCell.
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
    }
    

}
