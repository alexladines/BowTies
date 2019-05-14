//  BowTiesViewController.swift
//  Bow Ties
//
//  Created by Alex Ladines on 5/10/19.
//  Copyright © 2019 Alex Ladines. All rights reserved.
//

import UIKit
import CoreData

class BowTiesViewController: UIViewController {

  // MARK: - Properties
  var managedContext: NSManagedObjectContext!
  var currentBowTie: BowTie!
  
  // MARK: - IBOutlets
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var timesWornLabel: UILabel!
  @IBOutlet weak var lastWornLabel: UILabel!
  @IBOutlet weak var favoriteLabel: UILabel!

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    insertSampleData()
    
    
  }

  // MARK: - IBActions
  @IBAction func segmentedControl(_ sender: Any) {

  }

  @IBAction func wear(_ sender: Any) {
    let times = currentBowTie.timesWorn
    currentBowTie.timesWorn = times + 1
    currentBowTie.lastWorn = NSDate()
    do {
      try managedContext.save()
      populate(bowtie: currentBowTie)
    }
    catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
  }
  
  @IBAction func rate(_ sender: Any) {

  }
}
// MARK: - Core Data Stack
extension BowTiesViewController {
  func insertSampleData() {
    let fetch: NSFetchRequest<BowTie> = BowTie.fetchRequest()
    fetch.predicate = NSPredicate(format: "searchKey != nil")
    
    let count = try! managedContext.count(for: fetch)
    
    if count > 0 {
      // SampleData.plist data already in Core Data
      return
    }
    
    let path = Bundle.main.path(forResource: "SampleData",
                                ofType: "plist")
    
    let dataArray = NSArray(contentsOfFile: path!)!
    
    for dict in dataArray {
      let entity = NSEntityDescription.entity(
        forEntityName: "Bowtie",
        in: managedContext)!
      let bowtie = BowTie(entity: entity,
                          insertInto: managedContext)
      let btDict = dict as! [String: Any]
      bowtie.id = UUID(uuidString: btDict["id"] as! String)
      bowtie.name = btDict["name"] as? String
      bowtie.searchKey = btDict["searchKey"] as? String
      bowtie.rating = btDict["rating"] as! Double
      let colorDict = btDict["tintColor"] as! [String: Any]
      bowtie.tintColor = UIColor.color(dict: colorDict)
      
      let imageName = btDict["imageName"] as? String
      let image = UIImage(named: imageName!)
      let photoData = UIImagePNGRepresentation(image!)!
      bowtie.photoData = NSData(data: photoData)
      bowtie.lastWorn = btDict["lastWorn"] as? NSDate
      
      let timesNumber = btDict["timesWorn"] as! NSNumber
      bowtie.timesWorn = timesNumber.int32Value
      bowtie.isFavorite = btDict["isFavorite"] as! Bool
      bowtie.url = URL(string: btDict["url"] as! String)
    }
    
    try! managedContext.save()
  }
  
  func fetchItems() {
    
    // 1.
    let request: NSFetchRequest<BowTie> = BowTie.fetchRequest()
    let firstTitle = segmentedControl.titleForSegment(at: 0)!
    request.predicate = NSPredicate(format: "%K = %A", argumentArray: [#keyPath(BowTie.searchKey), firstTitle])
    
    
    do {
      // 2.
      let results = try managedContext.fetch(request)
      
      // 3.
      populate(bowtie: results.first!)
    }
    catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
  }
  
  func populate(bowtie: BowTie) {
    
    guard let imageData = bowtie.photoData as Data?,
      let lastWorn = bowtie.lastWorn as Date?,
      let tintColor = bowtie.tintColor as? UIColor else {
        return
    }
    imageView.image = UIImage(data: imageData)
    nameLabel.text = bowtie.name
    ratingLabel.text = "Rating: \(bowtie.rating)/5"
    
    timesWornLabel.text = "# times worn: \(bowtie.timesWorn)"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    
    lastWornLabel.text =
      "Last worn: " + dateFormatter.string(from: lastWorn)
    
    favoriteLabel.isHidden = !bowtie.isFavorite
    view.tintColor = tintColor
  }
}

private extension UIColor {
  static func color(dict: [String : Any]) -> UIColor? {
    
    guard let red = dict["red"] as? NSNumber,
      let green = dict["green"] as? NSNumber,
      let blue = dict["blue"] as? NSNumber else {
        return nil
    }
    return UIColor(red: CGFloat(truncating: red) / 255.0,
                   green: CGFloat(truncating: green) / 255.0,
                   blue: CGFloat(truncating: blue) / 255.0,
                   alpha: 1)
  }
}
