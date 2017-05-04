//
//  CategoryViewController.swift
//  CheckListApp
//
//  Created by KARIM on 5/4/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController, AddCategoryViewControllerDelegate {

    var categoryItems: [CategoryListItem]
    
    required init?(coder aDecoder: NSCoder) {
        categoryItems = [CategoryListItem]()
        
        super.init(coder: aDecoder)
        
        loadChecklistItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveChecklistItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCatViewControllerDidCancel(
        _ controller: AddCategoryViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCatViewController(_ controller: AddCategoryViewController,
                               didFinishAdding item: CategoryListItem) {
        addCategory(item)
        dismiss(animated: true, completion: nil)
    }
    
    func editCatViewController(_ controller: AddCategoryViewController, didFinishEditing item: CategoryListItem) {
        let newRowIndex = categoryItems.index(of: item)!
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell", for: indexPath) as! CategoryListItemsCell
        
        let categoryListItem = categoryItems[indexPath.row]
        cell.categoryName.text = categoryListItem.text
        cell.categoryImage.image = categoryListItem.image.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryItem = categoryItems[indexPath.row]
        performSegue(withIdentifier: "showCheckList", sender: categoryItem)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // commit editing style (swipe to delete)
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        categoryItems.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckList" {
            let controller = segue.destination as! ChecklistViewController
            controller.categoryListItem = sender as! CategoryListItem
        }else if segue.identifier == "addItem" {
                
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! AddCategoryViewController
                
                controller.delegate = self
                
        } else if segue.identifier == "editItem" {
                
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! AddCategoryViewController
                
                controller.delegate = self
                
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    controller.itemToEdit = categoryItems[indexPath.row]
                }
        }
    }

    func addCategory(_ item: CategoryListItem) {
        item.image.image = #imageLiteral(resourceName: "Birthdays")
        item.checkList = [CheckListItem]()
        
        let newRowIndex = categoryItems.count
        
        categoryItems.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        saveChecklistItems()
    }
    
    // get the dir on phone
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // add .plist file to this dir
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("CategoryLists.plist")
    }
    
    // save the check list items
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(categoryItems, forKey: "CategorylistItems")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    // load the check list items
    func loadChecklistItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            if unarchiver.decodeObject(forKey: "CategorylistItems") != nil{
                categoryItems = unarchiver.decodeObject(forKey: "CategorylistItems") as! [CategoryListItem]
            }
            unarchiver.finishDecoding()
        }
    }
}
