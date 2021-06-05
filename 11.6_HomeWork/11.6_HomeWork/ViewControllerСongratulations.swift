//
//  ViewControllerСongratulations.swift
//  11.6_HomeWork
//
//  Created by Вадим Зинатуллин on 04.06.2021.
//

import UIKit

class ViewControllerCongratulations: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var message = " "//: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = message

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
