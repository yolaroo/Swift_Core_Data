//
//  ViewController.swift
//  SwiftCoreData
//
//  Created by MGM on 6/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

import UIKit
import CoreData

enum CoreDataEntities {
    case MyObject
    func description() -> String {
        switch self {
        case .MyObject:
            return "MyObject"
        }
    }
}

class ViewController: UIViewController {
    
    var managedObjectContext : NSManagedObjectContext = NSManagedObjectContext()

    //
    //// Text Field
    //
    
    @IBOutlet var myTextField : UITextField
    
    //
    //// BUTTONS
    //
    
    @IBAction func saveButtonPress(sender : UIButton) {
        makeEntityAction()
    }
    
    @IBAction func fetchButtonPress(sender : UIButton) {
        fetchObjectAction()
    }
    
    //
    //// ACTIONS
    //
    
    func makeEntityAction () {
        println("-- Make action --")
        
        let value:String = self.myTextField.text
        var myObject : MyObject = MyObject.createMyObject(MyObjectPropertyList.name, value : value, context: self.managedObjectContext)!
        saveContext(self.managedObjectContext)
    }
    
    func fetchObjectAction () {
        println("-- Fetch action --")
        
        if let myTotalarray = myGeneralFetchRequest(CoreDataEntities.MyObject, MyObjectPropertyList.name, self.managedObjectContext) {
            printFetchedArrayList(myTotalarray)
        }
        if let mySinglearray: AnyObject[] = myNameFetchRequest(CoreDataEntities.MyObject, MyObjectPropertyList.name, "Bill", self.managedObjectContext) {
            println("(--  --)")
            printFetchedArrayList(mySinglearray)
        }

    }
    
    //
    //// LOAD & SAVE
    //
    
    func loadContext () {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        self.managedObjectContext = context
    }
    
    func saveContext (context: NSManagedObjectContext) {
        var error: NSError? = nil
        context.save(&error)
    }
    
    //
    //// LOAD
    //
    
    func myLoad () {
        loadContext ()
        println("Loaded Context")
    }
    
    //
    //// Life Cycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLoad ()
    }

}


//
//// DESCRIPTION & MAKER
//

/*
func getEntityDescriptionForName (entityName: String, context: NSManagedObjectContext) -> NSEntityDescription {
    let myEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
    return myEntityDescription
}

func makeEntityWithName (myEntityDescription:NSEntityDescription,context: NSManagedObjectContext) -> MyObject { // couldn't type cast
    var newObject = MyObject(entity: myEntityDescription, insertIntoManagedObjectContext: context)
    return newObject
}
*/

