//
//  TeamDetailsVC.swift
//  Football
//
//  Created by Amine  on 01/10/2022.
//

import UIKit

class TeamDetailsVC: UIViewController {
    
    
    @IBOutlet weak var banniereImage: UIImageView!
    @IBOutlet weak var paysLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var currentTeam : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = currentTeam?.strTeam
        
        let urlBanner : String = currentTeam?.strTeamBanner ?? ""
        if urlBanner != "" {
            banniereImage.load(url: URL(string: urlBanner)!)
        }else{
            banniereImage.image = UIImage(named: "thumbnail")

        }
        leagueLabel.text = currentTeam?.strLeague ?? ""
        descriptionLabel.text = currentTeam?.strDescriptionEN ?? ""
        paysLabel.text = currentTeam?.strCountry ?? ""
        
    }
    
}
