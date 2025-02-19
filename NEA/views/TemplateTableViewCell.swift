//
//  TemplateTableViewCell.swift
//  NEA
//
//  Created by CHETAN VISROLIA on 02/02/2025.
//

import UIKit

class TemplateTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var previousReps: UILabel!
    @IBOutlet weak var previousWeight: UILabel!
    @IBOutlet weak var recordWeight: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    
    
}
