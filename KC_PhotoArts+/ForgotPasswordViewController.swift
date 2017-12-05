//
//  ForgotPasswordViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 12/5/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var continueButtonLabel: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordButtonLabel: UIButton!
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
    }
    @IBAction func resetPasswordButtonPressed(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
