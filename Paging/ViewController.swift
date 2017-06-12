//
//  ViewController.swift
//  Paging
//
//  Created by vikram singh rajpoot on 12/06/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data = [String]()
    var count = 0

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       let _ = loadMore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  self.data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath)
        if indexPath.row < self.data.count { // Data
            cell.textLabel?.text = self.data[indexPath.row]
        }else{
            cell.textLabel?.text = "Loading.."
            self.insertMore()
        }
        
        return cell
    }
    
    func loadMore()->[IndexPath]{
        var paths = [IndexPath]()
        for _ in 0..<20 {
            count += 1
            self.data.append("itmes: \(count)")
            paths.append(IndexPath(row: self.data.count - 1, section: 0))
        }
        return paths
    }
    
    func insertMore(){
        
        DispatchQueue.global().async {
            let paths = self.loadMore()
            OperationQueue.main.addOperation {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: paths, with: .top)
                self.tableView.endUpdates()
            }

        }
       
    }
}

