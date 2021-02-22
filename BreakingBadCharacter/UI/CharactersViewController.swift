//
//  CharactersViewController.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit
import Kingfisher
class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var characters: [MovieCharacter] = []
    private var didSelectModelHandler: (MovieCharacter)->Void = {_ in}
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    convenience init(_ characters: [MovieCharacter], didSelectModelHandler: @escaping (MovieCharacter)->Void = {_ in}) {
        self.init(nibName: "CharactersViewController", bundle: nil)
        self.characters = characters
        self.didSelectModelHandler = didSelectModelHandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.register(CharacterCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupUI() {
        title = "List of Breaking Bad characters"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CharacterCell.self)!
        let character = characters[indexPath.row]
        cell.nameLabel.text = character.name
        if let url = URL(string: character.img) {
            cell.photoView.kf.setImage(with: url, options: [
                .transition(.fade(0.2)),
                .backgroundDecode
            ], completionHandler: { (result) in
                switch result {
                case let .failure(error):
                    print(error)
                default:
                    break
                }
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        didSelectModelHandler(character)
    }
}
