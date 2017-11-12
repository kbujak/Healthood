//
//  FoodListTableViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 02/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit
import FoldingCell

class FoodListTableViewController: UITableViewController {
    /************* structs ***************/
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 107 // equal or greater foregroundView height
            static let open: CGFloat = 390 // equal or greater containerView height
        }
    }
    /************* Outlets ***************/
    let addButton = UIButton.init(type: .custom)
    var selectedRowIndexPath: IndexPath?
    /************* Variables *************/
    var foodArray = [Food()]
    var cellHeights: [CGFloat] = []
    let kCloseCellHeight: CGFloat = 107
    let kOpenCellHeight: CGFloat = 390
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func showBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "singleFoodSegue", sender: self)
    }
    
    @IBAction func unwindToDishesListViewController(for segue: UIStoryboardSegue){
        if segue.identifier == "correctAddFoodSegue"{
            if let addFoodVC = segue.source as? AddFoodViewController{
                if let food = addFoodVC.food{
                    foodArray.append(food)
                    cellHeights.append(kCloseCellHeight)
                    tableView.reloadData()
                }
            }
        }
    }
    
    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: foodArray.count)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "foodListTheme2"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let selectedRow = self.selectedRowIndexPath{
//            self.tableView(self.tableView, didDeselectRowAt: selectedRow)
//            self.selectedRowIndexPath = nil
//        }
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            selectedRowIndexPath = indexPath
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.6
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.6
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        if case let foldingCell as FoldingCell = cell {
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.unfold(false, animated: true, completion: nil)
            } else {
                foldingCell.unfold(true, animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemId", for: indexPath) as! FoodTableViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        foodArray[indexPath.row].owner.profileImage = #imageLiteral(resourceName: "profile_example")
        cell.food = foodArray[indexPath.row]
        cell.setup()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "singleFoodSegue"{
            if let singleDishVC = segue.destination as? SingleDishViewController{
                singleDishVC.food = self.foodArray[(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
}
