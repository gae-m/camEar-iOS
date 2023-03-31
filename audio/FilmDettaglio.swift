//
//  FilmDettaglio.swift
//  audio
//
//  Created by Gaetano Martedì on 30/06/18.
//  Copyright © 2018 iOS Foundation. All rights reserved.
//

import UIKit

var filmDettaglio: Film? = nil

class FilmDettaglio: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var segmentedController: UISegmentedControl!

    @IBOutlet weak var selectLanguage: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var plot: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var biglocandina: UIImageView!
    let infoTag = ["Title:","Genre:","Duration:","Director:","Year:","Cast:"]
    var info = [String?]()
    var nomeAudio = String()
    var language = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        info = [filmDettaglio?.titolo,filmDettaglio?.genre, filmDettaglio?.durata, filmDettaglio?.regista,filmDettaglio?.anno,filmDettaglio?.cast]
        navigationItem.title = filmDettaglio!.titolo
        biglocandina.image = filmDettaglio!.immagine
        tableView.delegate = self
        tableView.dataSource = self
        plot.text = filmDettaglio?.trama
        nomeAudio = filmDettaglio!.titolo.replacingOccurrences(of: " ", with: "")
        language = "eng"+nomeAudio
        if filmDettaglio?.titolo != "Night of the living dead" && filmDettaglio?.titolo != "The little shop of horrors" && filmDettaglio?.titolo != "Charade" {
            goButton.isHidden = true
            selectLanguage.isHidden = true
            segmentedController.isHidden = true
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "riga", for: indexPath) as! TableViewCell
        cell.titolo.text = infoTag[indexPath.row]
        cell.dettaglio.text = info[indexPath.row]
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectLanguage(_ sender: UISegmentedControl) {
        switch segmentedController.selectedSegmentIndex{
        case 0:
            language = "eng"+nomeAudio
        default:
            language = "ita"+nomeAudio
        }
    }
    
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        urlAudio = language
        titolo = filmDettaglio!.titolo
    }
}
