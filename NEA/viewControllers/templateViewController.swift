//
//  templateViewController.swift
//  NEA
//
//  Created by CHETAN VISROLIA on 09/02/2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabase





class templateViewController: UIViewController, UITableViewDelegate , MyProtocol{
    
    
    
    
    private let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    
    var Workouts: [String] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segues" {
            if let secondVC = segue.destination as? exercisesViewController {
                secondVC.delegate = self
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTableView.dataSource = self
        exerciseTableView.delegate = self
        
        tableView.register(UINib(nibName: "TemplateTableViewCell" , bundle: nil), forCellReuseIdentifier: "cellReused")
        
        
        
    }
    
    
    
    
    func addExercise(workout: String){
        Workouts.append(workout)
        exerciseTableView.reloadData()
    }
    
    
    /*func savingDatabase(savedData: String){
     if let user = Auth.auth().currentUser {
     let userID = user.uid
     let workoutID  = UUID().uuidString
     let workoutData: [String: Any] = [
     "workout" : "stringsting"
     ]
     
     self.db.collection("userdata").document(userID).collection("userWorkouts\(workoutID)").document("exerciseers").setData(workoutData) { error in
     if let error = error {
     print("Error writing document: \(error)")
     } else {
     print("Document successfully written!")
     }
     }
     
     
     
     
     }else{
     print("no use signed in")
     }
     
     }*/
    
    @IBOutlet weak var exerciseTableView: UITableView!
    
    
    @IBAction func saveWorkoutData(_ sender: UIBarButtonItem) {
    
        var dataForExercise: [String: Any] = [:]
        
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else { return }
        
        for indexPath in visibleIndexPaths {
            if let cell = tableView.cellForRow(at: indexPath) as? TemplateTableViewCell{
                let exerciseNames = cell.nameOfExercise.text ?? ""
                let weight = cell.weightTextField.text ?? ""
                let reps = cell.repsTextField.text ?? ""
                
                
                
                let exerciseData: [String: Any] = [
                    "exerciseName": exerciseNames,
                    "weight": weight,
                    "reps": reps
                ]
                
                dataForExercise["exerciseName"] = exerciseNames
                dataForExercise["weight"] = weight
                dataForExercise["reps"] = reps
            
            }
            
            
        }
     
  
        saveToFirestore(data: dataForExercise)
        
        func saveToFirestore(data: [String: Any]) {
            if let user = Auth.auth().currentUser {
                let userID = user.uid
                let workoutID  = UUID().uuidString
                    
                self.db.collection("userdataSaved").document(userID).collection("userWorkouts\(workoutID)").document("exercise").setData(data) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }else{
                print("no use signed in")
            }
                
        }
            
            
            
    }
}
            
extension templateViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return Workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReused", for: indexPath) as!  TemplateTableViewCell
        cell.nameOfExercise.text = Workouts[indexPath.row]
        /*cell.delegate = self*/
        
        let printing = String("Cell \(indexPath.row): nameOfExercise.text = \(cell.nameOfExercise.text ?? "No text"), weight = \(cell.weightTextField.text ?? "No text"). reps \(cell.repsTextField.text ?? "No text")")
        
        return cell
    }
    
    
}



    

