//
//  MainViewController.swift
//  DataBaseCore
//
//  Created by iOS2 on 18/04/17.
//  Copyright © 2017 iOS2. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController
{
    @IBOutlet var tableView: UITableView!
    
    var arrallData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
       
//        print(arrOfloginData)
        
//        if arrOfloginData.count > 0
//        {
//            let object = (arrOfloginData[0] as AnyObject) as! LoginData
//            print(object.email! as String)
//        }
        
      
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        let coredataDeclare = CoreData()
        let arrOfloginData = coredataDeclare.getProductDetails(entityName: "LoginData") as NSArray
        arrallData = arrOfloginData.mutableCopy() as! NSMutableArray
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension MainViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrallData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: DisplayTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DisplayTableViewCell") as! DisplayTableViewCell
        cell.selectionStyle = .none
        
        let object = (arrallData[indexPath.row] as AnyObject) as! LoginData
        cell.l1.text = object.name
        cell.l2.text = object.email
        cell.l3.text = object.contactnumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        if let delegate = delegate
//        {
//            delegate.didSelect(row:indexPath, inTableView: tableView)
//        }
    }
    
}
