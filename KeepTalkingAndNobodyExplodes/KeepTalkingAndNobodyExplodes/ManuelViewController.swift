//
//  ManuelViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by David Fournier on 14/12/2017.
//  Copyright © 2017 Salomé Russier. All rights reserved.
//

import UIKit

class ManuelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func newInstance() -> ManuelViewController{
        let controller = ManuelViewController()
        
        
        return controller
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
