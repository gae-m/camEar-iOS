//
//  DettaglioCategoria.swift
//  audio
//
//  Created by Gaetano Martedì on 01/07/18.
//  Copyright © 2018 iOS Foundation. All rights reserved.
//

import UIKit
var nvTitle: String? = nil
class DettaglioCategoria: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filmCategoria = [Film]()
    var filmUpdate = [Film]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = nvTitle
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.placeholder = "Search film"
        
        switch nvTitle{
        case "Great Classic":
            filmCategoria = filmClassici
        case "Now at cinema":
            filmCategoria = filmNowAtCinema
        case "Action":
            filmCategoria = filmAction
        case "Comedy":
            filmCategoria = filmComedy
        case "Horror":
            filmCategoria = filmHorror
        default:
            filmCategoria = filmDrama
        }
        filmUpdate = filmCategoria
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmUpdate.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DettaglioCategoriaCell
        cell.locandina.image = filmUpdate[indexPath.row].immagine
        cell.titolo.text = filmUpdate[indexPath.row].titolo
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            filmUpdate.removeAll()
            for i in filmCategoria{
                if i.titolo.lowercased().contains(searchText.lowercased()){
                    filmUpdate.append(i)
                }
            }
        }else{
            filmUpdate = filmCategoria
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first, let _ = segue.destination as? FilmDettaglio {
            filmDettaglio = filmUpdate[indexPath.item]
        }
        view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
