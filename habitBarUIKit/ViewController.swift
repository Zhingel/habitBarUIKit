//
//  ViewController.swift
//  habitBarUIKit
//
//  Created by Стас Жингель on 19.08.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var tasks : [Task] = []
    weak var collectionView: UICollectionView!
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        let alertcontroller = UIAlertController(title: "New Task", message: "add new Task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            action in
            let tf = alertcontroller.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.collectionView.reloadData()
            } else {return}
        }
        alertcontroller.addTextField(configurationHandler: { _ in})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) 
        alertcontroller.addAction(saveAction)
        alertcontroller.addAction(cancelAction)
        present(alertcontroller, animated: false)
    }
    override func loadView() {
        super.loadView()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.collectionView = collectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "toDo", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CellClass.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: "firstcell")
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellClass
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20

        
        if indexPath.row == 0 {
        let firstcell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstcell", for: indexPath)
        firstcell.backgroundColor = .green
        firstcell.layer.cornerRadius = 20
            return firstcell
        } else {
            cell.textLabel?.text = tasks[indexPath.row - 1].toDo
            return cell
        }
        
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 30, height: indexPath.row == 0 ? 80 : 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 50)
    }
}
