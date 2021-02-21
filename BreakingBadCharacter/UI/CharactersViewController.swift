//
//  CharactersViewController.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit
import Kingfisher
class CharactersViewController: UIViewController, UITableViewDataSource {

    private var characters: [MovieCharacter] = []
    let tableView = UITableView()
    convenience init(_ characters: [MovieCharacter]) {
        self.init()
        self.characters = characters
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.register(CharacterCell.self)
        tableView.dataSource = self
        
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
    
}
