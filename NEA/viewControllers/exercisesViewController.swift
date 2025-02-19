//
//  exercisesViewController.swift
//  NEA
//
//  Created by CHETAN VISROLIA on 02/02/2025.
//

import UIKit


protocol MyProtocol{
    
    func addExercise(workout: String)
}


class exercisesViewController: UIViewController {

    /*var delegate: AddexerciseDelegate?*/
    var delegate: MyProtocol?
    var selectedWorkout: String?
    
    @IBOutlet weak var exerciseTableView: UITableView!

    
    var exercises: [exercise] = [
        exercise(name: "bench press"),
        exercise(name: "incline bench press"),
        exercise(name: "bicep curl"),
        exercise(name: "deadlift"),
        exercise(name: "lat pulldown"),
        exercise(name: "overhead press"),
        exercise(name: "squat"),
        exercise(name: "tricep pushdown")
        
        
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseTableView.dataSource = self
        exerciseTableView.delegate = self

        title = "Exercises"
    }
    
   
func senddata(){
        
        delegate?.addExercise(workout: selectedWorkout ?? "")
        self.navigationController?.popViewController(animated: true)
    }
        
    

}


extension exercisesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseableCell", for: indexPath) /*returns a reusable table-view cell object for the specified reuse identifier and adds it to the table*/
        
        cell.textLabel?.text = exercises[indexPath.row].name
        return cell
    }
}

extension exercisesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let templateViewController = storyboard?.instantiateViewController(withIdentifier: "templateViewController") as! templateViewController
       
        let exerciseName = exercises[indexPath.row].name
        delegate?.addExercise(workout: exerciseName)
       
        
        dismiss(animated: true)
        
        
        
        

    }
    
    
 }


