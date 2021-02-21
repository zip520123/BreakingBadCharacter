//
//  DetailViewController.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit
import Kingfisher
class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    private var character: MovieCharacter?
    
    convenience init(_ character: MovieCharacter) {
        self.init(nibName: "DetailViewController", bundle: nil)
        self.character = character
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        guard let character = character else {return}
        title = character.name
        photoView.kf.setImage(with: URL(string: character.img))
        var s = "Name: " + character.name
        s.append("\n")
        s.append("Occupation: " + character.occupation.joined(separator: ", "))
        s.append("\n")
        s.append("Status: " + character.status.rawValue)
        s.append("\n")
        s.append("Nickname: " + character.nickname)
        s.append("\n")
        s.append("Season appearance: " + character.appearance.map {String($0)}.joined(separator: ", "))
        
        label.text = s
        
    }
}
