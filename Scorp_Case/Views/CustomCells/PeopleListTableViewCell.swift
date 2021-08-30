//
//  PeopleListTableViewCell.swift
//  Scorp_Case
//
//  Created by İlkay Sever on 25.08.2021.
//

import UIKit

class PeopleListTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayouts()
        
    }
    
    // Fill Cell Function
    func fillPerson(personData: Person?) {
        guard let id = personData?.id else { return }
        fullNameLabel.text = personData?.fullName
        idLabel.text = "\(id)"
    }
    
    private func setLayouts() {
        containerView.layer.borderWidth = 0.2
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.cornerRadius = 5
    }
    
}
