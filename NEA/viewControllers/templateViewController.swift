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


protocol passingvaluesDelegate: AnyObject {
    func passValues(data: String)
}



class templateViewController: UIViewController, UITableViewDelegate , MyProtocol,  /*,customCellDelegate*/passingvaluesDelegate{
  
    
    var delegate:passingvaluesDelegate?
    
    private let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!

   
   
    var saving: String?
    
    func passValues(data: String) {
        saving = data
        print(saving ?? "no data")
    }
    
    
    
    
    /*var weightText: String?
    var repsText: String?*/
    
    
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
        let templateVC = templateViewController()
        templateVC.delegate = self
        
    }
    
    
    @IBOutlet weak var exerciseTableView: UITableView!
  
    func addExercise(workout: String){
        Workouts.append(workout)
        exerciseTableView.reloadData()
    }
    
    
    func savingDatabase(savedData: String){
        if let user = Auth.auth().currentUser {
            let userID = user.uid
            let workoutID  = UUID().uuidString
            let workoutData: [String: Any] = [
                "workout" : saving ?? "no text"
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
        
    }
    
    
   
    @IBAction func saveWorkoutData(_ sender: UIBarButtonItem) {
        print("test")
        savingDatabase(savedData: saving ?? "no text")
        print(saving ?? "no text")
        print("not worked ")
        

        
        
    }
    
    
    
    
    
    
    /* func didUpdateText(_ cell: TemplateTableViewCell, weight: String, reps: String) {
        weightText = weight
        repsText = reps
            
        
    }*/
    
   /* func saveWorkout(weight:String, reps: String){
        if let user = Auth.auth().currentUser {
            let userID = user.uid
            let workoutID  = UUID().uuidString
            let workoutData: [String: Any] = [
                "weight" : weight,
                "reps" : reps
            ]
                
                
            self.db.collection("userdata").document(userID).collection(workoutID).addDocument(data:workoutData){ error in
                if let error = error {
                    print("Error saving workout data: \(error)")
                } else {
                    print("Workout data saved successfully!")
                }
            }
        
        }else {
            print("No user is signed in.")
        }
    }
  
    @IBAction func finishedPressed(_ sender: UIBarButtonItem) {
        guard let weight = weightText else {return}
        guard let reps = repsText else {return}
        saveWorkout(weight: weight, reps: reps)
        dismiss(animated: true)
  
    }
    
        */

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
        
        delegate?.passValues(data:printing)
        return cell
    }
    
    
}



    

