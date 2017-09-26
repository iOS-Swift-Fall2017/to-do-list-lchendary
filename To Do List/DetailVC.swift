//
//  DetailVC.swift
//  To Do List
//
//  Created by Linda Chen on 9/25/17.
//  Copyright © 2017 Synestha. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var toDoField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            //If you were adding something, then dismiss it.
            dismiss(animated: true, completion: nil)
        } else {
            //If you were editing something, then pop it.
            navigationController?.popViewController(animated: true)
        }
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
