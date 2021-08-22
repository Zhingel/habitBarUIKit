//
//  createNewTask.swift
//  habitBarUIKit
//
//  Created by Стас Жингель on 22.08.2021.
//

import UIKit
import CoreData

class createNewTask: UIViewController {

    var tasks : [Task] = []
    @IBOutlet weak var toDoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func saveTasks(_ sender: UIBarButtonItem) {
        if  toDoTextField.text != "" {
            self.saveTask(withTitle: toDoTextField.text!)
        } else {return}
    }
   
    private func saveTask(withTitle toDo: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        else {return}
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.toDo = toDo
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    }
    

