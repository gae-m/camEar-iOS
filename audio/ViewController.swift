//
//  ViewController.swift
//  audio
//
//  Created by Gaetano Martedì on 22/06/18.
//  Copyright © 2018 iOS Foundation. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    @IBOutlet weak var searchBar: UISearchBar!
    var filmUpdate = film
    var research = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.placeholder = "Search film"
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if research{
            return 1
        }else{
            return categorie.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if research{
            return filmUpdate.count
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: headerCell?
        if kind == UICollectionElementKindSectionHeader{
           header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? headerCell
            if research{
                header?.headerTitle.text = "Result:"
                header?.button.alpha = 0
            }else{
                header?.headerTitle.text = categorie[indexPath.section]
                header?.button.alpha = 1
            }
        }
        return header!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as! CollectionViewCell
        if research{
            cell.titolo.text = filmUpdate[indexPath.row].titolo
            cell.locandina.image = filmUpdate[indexPath.row].immagine
        }else{
            switch indexPath.section{
            case 0:
                cell.titolo.text = filmClassici[indexPath.row].titolo
                cell.locandina.image = filmClassici[indexPath.row].immagine
            case 1:
                cell.titolo.text = filmNowAtCinema[indexPath.row].titolo
                cell.locandina.image = filmNowAtCinema[indexPath.row].immagine
            case 2:
                cell.titolo.text = filmAction[indexPath.row].titolo
                cell.locandina.image = filmAction[indexPath.row].immagine
            case 3:
                cell.titolo.text = filmComedy[indexPath.row].titolo
                cell.locandina.image = filmComedy[indexPath.row].immagine
            case 4:
                cell.titolo.text = filmDrama[indexPath.row].titolo
                cell.locandina.image = filmDrama[indexPath.row].immagine
            default:
                cell.titolo.text = filmHorror[indexPath.row].titolo
                cell.locandina.image = filmHorror[indexPath.row].immagine
            }
        }
       return cell
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            filmUpdate.removeAll()
            for i in film{
                if i.titolo.lowercased().contains(searchText.lowercased()){
                    filmUpdate.append(i)
                }
                research = true
            }
        }else{
            research = false
        }
        collectionView.reloadData()
    }
    
//    @IBAction func endEdit(_ sender: Any) {
//        view.endEditing(true)
//    }
    
    /// cliccloooooo il cercaaaaaaa
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first, let _ = segue.destination as? FilmDettaglio {
            if research{
                filmDettaglio = filmUpdate[indexPath.item]
                }else{
                switch indexPath.section{
                case 0:
                    filmDettaglio = filmClassici[indexPath.item]
                case 1:
                    filmDettaglio = filmNowAtCinema[indexPath.item]
                case 2:
                    filmDettaglio = filmAction[indexPath.item]
                case 3:
                    filmDettaglio = filmComedy[indexPath.item]
                case 4:
                    filmDettaglio = filmDrama[indexPath.item]
                default:
                    filmDettaglio = filmHorror[indexPath.item]
                }
            }
            
            }
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

