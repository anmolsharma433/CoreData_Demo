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
        // Do any additional setup after loading the view.
        //First we create instance of app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Second we need the context. - This context is the manager like location manager, audio manager etc.
        let context = appDelegate.persistentContainer.viewContext
        
        //        //write into context - 3rd step
        //        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        //        newUser.setValue("ritik", forKey: "name")
        //        newUser.setValue(6889979909, forKey: "phone")
        //        newUser.setValue("ritik@gmail.ca", forKey: "email")
        //        newUser.setValue(70, forKey: "age")
        //
        //        //4th step - save context
        //        do {
        //            try context.save()
        //            print(newUser,"is saved")
        //        }catch
        //        {
        //            print(error)
        //        }
        
        //fetch data and load it
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email contains %@", ".com")
        request.returnsObjectsAsFaults = false
        //we find our data and will enclose it in try and catch because it can also be null
        do{
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]{
                    
                    //                    if let name = result.value(forKey: "name"){
                    //                        print(name)
                    //                    }
                    if let email = result.value(forKey: "email")
                    {
                        print(email)
                        
                        //update email address top "email@gmail.ca"
                        let email = email as! String
                        //update core data
                        result.setValue(String(email.dropLast(2)) + ".com", forKey: "email")
                        do {
                            try context.save()
                        }catch{
                            print(error)
                        }
                        print(email)
                    }
                    
                    
                    
                    //                    if let phone = result.value(forKey: "phone"){
                    //                    print(result)
                    //                    }
                    //                    if let age = result.value(forKey: "age")
                    //                    {
                    //                        print(age)
                    //                    }
                }
                
            }
            
        }
        catch{
            print(error)
        }
    }
    
    
}

