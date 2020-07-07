//
//  DetailViewController.swift
//  Gnomes
//
//  Created by Rafael Gutiérrez on 06/07/20.
//  Copyright © 2020 Rafael Gutiérrez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameDLbl: UILabel!
    @IBOutlet weak var imageViewD: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var professions: UITextView!
    
    @IBOutlet weak var friends: UITextView!
    
    var nameD:String = ""
    var thumbnailD:String = ""
    var ageD:Int = 0
    var weightD:Float = 0.0
    var heightD:Float = 0.0
    var hair_colorD:String = ""
    var professionsD:String = ""
    var friendsD:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        nameDLbl.text = nameD
        
        if let url = URL(string: thumbnailD) {
            do {
                let data = try Data(contentsOf: url)
                imageViewD.image = UIImage(data: data)
            } catch let error {
                print("Error al cargar la imágen: \(error)")
            }
        }
        
        age.text = String(ageD)
        weight.text = String(weightD)
        height.text = String(heightD)
        hairColor.text = hair_colorD
        professions.text = professionsD
        friends.text =  friendsD
    }
}
