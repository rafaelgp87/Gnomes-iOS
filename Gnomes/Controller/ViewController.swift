//
//  ViewController.swift
//  Gnomes
//
//  Created by Rafael Gutiérrez on 03/07/20.
//  Copyright © 2020 Rafael Gutiérrez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    var gnomes = [Gnome]()
    var gnomesData = [Gnome]()
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        activity.startAnimating()
        activity.hidesWhenStopped = true
        
        self.navigationController?.isNavigationBarHidden = true
        
        let url = URL(string: "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //Brastlewark
            if error == nil {
                
                //guard let data = data else { return }
                
                do {
                    /*
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        var gnomeArray = [Any]()
                        gnomeArray = [jsonObj.value(forKey: "Brastlewark")!]
                    }*/
                
                    //print(gnomeArray[0])
                    let test = try JSONDecoder().decode(StructGnomes.self, from: data!)
                
                    //print(test.Brastlewark)
                    
                    for g in test.Brastlewark {
                        self.gnomes.append(g)
                    }
                    
                    self.gnomesData = self.gnomes
                    
                } catch {
                    print("Error")
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }.resume()
        
        self.collectionView.isUserInteractionEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gnomes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CollectionViewCell
        
        cell.nameLbl.text = gnomes[indexPath.row].name.capitalized
        
        let imageUrlString = gnomes[indexPath.row].thumbnail
        
        if let url = URL(string: imageUrlString) {
            do {
                let data = try Data(contentsOf: url)
                cell.imageView.image = UIImage(data: data)
            } catch let error {
                print("Error al cargar la imágen: \(error)")
            }
        }
        
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
        cell.imageView.contentMode = .scaleAspectFill
        activity.stopAnimating()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.nameD = self.gnomes[indexPath.row].name
        vc?.thumbnailD = self.gnomes[indexPath.row].thumbnail
        vc?.ageD = self.gnomes[indexPath.row].age
        vc?.weightD = self.gnomes[indexPath.row].weight
        vc?.heightD = self.gnomes[indexPath.row].height
        vc?.hair_colorD = self.gnomes[indexPath.row].hair_color
        
        var professions = ""
        
        for p in self.gnomes[indexPath.row].professions {
            professions = professions + p + ", "
        }
        
        vc?.professionsD = String(professions.dropLast(2))
        
        var friends = ""
        
        for f in self.gnomes[indexPath.row].friends {
            friends = friends + f + ", "
        }
        
        vc?.friendsD = String(friends.dropLast(2))
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.gnomes.removeAll()
        
        for g in self.gnomesData {
            if (g.name.lowercased().contains(searchBar.text!.lowercased())) {
                self.gnomes.append(g)
            }
        }
        
        if (searchBar.text!.isEmpty) {
            self.gnomes = self.gnomesData
        }
        
        self.collectionView.reloadData()
    }

}

