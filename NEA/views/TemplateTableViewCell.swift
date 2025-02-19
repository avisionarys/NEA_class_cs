//
//  TemplateTableViewCell.swift
//  NEA
//
//  Created by CHETAN VISROLIA on 02/02/2025.
//

import UIKit


protocol customCellDelegate{
    
    func didUpdateText(_ cell: TemplateTableViewCell, weight: String, reps:String)
}



class TemplateTableViewCell: UITableViewCell {
    
    var delegate: customCellDelegate?
    
 
    
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var previousReps: UILabel!
    @IBOutlet weak var previousWeight: UILabel!
    @IBOutlet weak var recordWeight: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
   
        
    @IBAction func weightfieldEdited(_ sender: Any) {
        
        guard let weight = weightTextField.text else { return }
        guard let reps = repsTextField.text else {return}
        delegate?.didUpdateText(self, weight: weight, reps: reps)
    }
    
    
    
}
