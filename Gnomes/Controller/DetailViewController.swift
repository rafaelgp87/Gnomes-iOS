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
    
    var nameD:String = ""
    var thumbnailD:String = ""
    
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
    }
}
