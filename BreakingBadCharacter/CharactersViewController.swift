//
//  CharactersViewController.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource {

    private var characters: [MovieCharacter] = []
    let tableView = UITableView()
    convenience init(_ characters: [MovieCharacter]) {
        self.init()
        self.characters = characters
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
