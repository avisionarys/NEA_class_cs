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
    
        
    @IBOutlet weak var exerciseTableView: UITableView!
    
    struct WorkoutData: Codable, Identifiable {
        @DocumentID var id: String?
        let exerciseName: String
        let weight: String
        let reps: String
    }
    
    
    @IBAction func saveWorkoutData(_ sender: UIBarButtonItem) {
        
        var dataForExercise: [WorkoutData] = []
        
        
        
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            guard let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? TemplateTableViewCell else { continue }
            let exerciseName = cell.nameOfExercise.text ?? ""
            let weight = cell.weightTextField.text ?? ""
            let reps = cell.repsTextField.text ?? ""
            
            let workoutData = WorkoutData(exerciseName: exerciseName, weight: weight, reps: reps)
            dataForExercise.append(workoutData)
            
            
        }
        
        saveToFirestore(data: dataForExercise)
        
        
        func saveToFirestore(data: [WorkoutData]) {
            if let user = Auth.auth().currentUser {
                let userID = user.uid
                let workoutID  = UUID().uuidString
                let userDocRef = db.collection("userdataRerferance").document(userID)
                let username = Auth.auth().currentUser?.email ?? "No username"
                let userDocuemntData = userDocRef.collection(username).document(workoutID)
                
                for workoutData in data {
                    do{
                        try userDocuemntData.collection("exercises").addDocument(from: workoutData)
                        print("workout data saved successfully")
                        if let viewControllers = navigationController?.viewControllers {
                                for viewController in viewControllers {
                                    if viewController is homeViewController{
                                        navigationController?.popToViewController(viewController, animated: true)
                                        return
                                    }
                                }
                            }
                    }catch{
                        print("error saving workout data: \(error)")
                    }
                    
                }
            }else {
                print("No user signed in")
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
        
        let printing = String("Cell \(indexPath.row): nameOfExercise.text = \(cell.nameOfExercise.text ?? "No text"), weight = \(cell.weightTextField.text ?? "No text"). reps \(cell.repsTextField.text ?? "No text")")
        
        return cell
    }
    
    
}



    

