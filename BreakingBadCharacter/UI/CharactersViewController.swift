//
//  CharactersViewController.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
final class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var viewModel: CharactersViewModel = CharactersViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var seasonSegmented: UISegmentedControl!
    
    convenience init(viewModel: CharactersViewModel) {
        self.init(nibName: "CharactersViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        rxBinding()
        tableView.register(CharacterCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        seasonSegmented.addTarget(self, action: #selector(segmentsChanges), for: .valueChanged)
    }
    
    @objc private func segmentsChanges(segmented: UISegmentedControl) {
        viewModel.seasionAppearance.accept(segmented.selectedSegmentIndex)
    }
    
    private func rxBinding() {
        
        searchBar.rx.text
            .map {
                if $0 == nil { return "" }
                else {return $0!}
            }
            .subscribe { [weak self] (query) in
            
            self?.viewModel.searchText.accept(query)
                
        }.disposed(by: disposeBag)

        viewModel.currCharacter.subscribe {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.disposed(by: disposeBag)

    }
    
    private func setupUI() {
        title = "List of Breaking Bad characters"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currCharacter.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CharacterCell.self)!
        let character = viewModel.currCharacter.value[indexPath.row]
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
        let character = viewModel.currCharacter.value[indexPath.row]
        viewModel.didSelectCharacter.accept(character)
    }
    
    
}
