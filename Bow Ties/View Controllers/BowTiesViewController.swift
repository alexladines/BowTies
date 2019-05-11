//  BowTiesViewController.swift
//  Bow Ties
//
//  Created by Alex Ladines on 5/10/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit

class BowTiesViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var timesWornLabel: UILabel!
  @IBOutlet weak var lastWornLabel: UILabel!
  @IBOutlet weak var favoriteLabel: UILabel!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - IBActions
  @IBAction func segmentedControl(_ sender: Any) {

  }

  @IBAction func wear(_ sender: Any) {

  }
  
  @IBAction func rate(_ sender: Any) {

  }
}
