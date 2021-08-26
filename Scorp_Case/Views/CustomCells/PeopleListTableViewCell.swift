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
    
    func fillPerson(personData: Person?) {
        guard let id = personData?.id else { return }
        fullNameLabel.text = personData?.fullName
        idLabel.text = "\(id)"
    }
    
    private func setLayouts() {
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 10
        containerView.clipsToBounds = true
    }
    
}
