//
//  EntryViewController.swift
//  DataBaseCore
//
//  Created by iOS2 on 18/04/17.
//  Copyright © 2017 iOS2. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController
{
    let EditORAdd = Bool()
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var ContactTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(_ sender: Any)
    {
        let dicData = NSMutableDictionary()
        dicData.setObject(nameTextField.text!, forKey: "name" as NSCopying)
        dicData.setObject(EmailTextField.text!, forKey: "email" as NSCopying)
        dicData.setObject(ContactTextField.text!, forKey: "contact" as NSCopying)
        
        let coredataDeclare = CoreData()
        coredataDeclare.saveLoinData(dictionary: dicData)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
