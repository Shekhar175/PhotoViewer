//
//  ViewController.swift
//  SDPhotoViewerDemo
//
//  Created by Shekhar on 5/31/17.
//  Copyright © 2017 perennial. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrOfImageNames = [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in 1...13 {
            
            arrOfImageNames.append("\(item)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrOfImageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
        let imageName = arrOfImageNames[indexPath.row]
        cell.lblTitle.text = "Image \(imageName)"
        cell.imgView.image = UIImage(named: "\(imageName)")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected row : \(indexPath.row)")
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableCell
        SDPhotoViewer.showImageFrom(imageView: cell.imgView)
    }

}

