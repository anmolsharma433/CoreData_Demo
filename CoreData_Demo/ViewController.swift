//
//  ViewController.swift
//  CoreData_Demo
//
//  Created by Anmol Sharma on 2020-01-16.
//  Copyright © 2020 anmol. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createData()
        updateData()
        retrieveData()
        
        
    }
    func createData()
    {
        //First we create instance of app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        //now we will make the context from thgis container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //now we will create entity and new User records
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        //finally we will populate the data
        for data in 1...5{
            let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
            user.setValue("Anmol\(data)", forKeyPath: "name")
            user.setValue("anmol\(data)@gmail.com", forKey: "email")
        }
        
        //now we will save the data inside the core data
        do{
            try managedContext.save()
            print("Data Saved")
        }catch let error as NSError{
            print("Could not save.\(error),\(error.userInfo)")
        }
    }
    
    func retrieveData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //preparing the request of type NsFetchRequestfor the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            {
                print(data.value(forKey: "name") as! String)
                print(data.value(forKey: "email") as! String)
            }
        }
        catch{
            print("Failed")
        }
        
    }
    
    func updateData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //preparing the request of type NsFetchRequestfor the entity
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Anmol2")
        do{
            let test = try managedContext.fetch(fetchRequest)
           
            for user in (test as? [NSManagedObject])! {
                user.setValue("abc", forKey: "name")
            }
            do{
                try managedContext.save()
            }
            catch{
                print(error)
            }
        }
        catch{
            print(error)
        }
    }
}


