//
//  CharacterCell.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit
import Kingfisher
class CharacterCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    override func prepareForReuse() {
        photoView.kf.cancelDownloadTask()
    }
}
