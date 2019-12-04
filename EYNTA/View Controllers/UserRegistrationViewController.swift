//
//  UserRegistrationViewController.swift
//  EYNTA
//
//  Created by James Slusser on 11/18/19.
//  Copyright © 2019 James Slusser. All rights reserved.
//

import UIKit

class UserRegistrationViewController: UIViewController {
    
    @IBAction func login(_ sender: Any) {
    }
    @IBAction func forgotPassword(_ sender: UIButton) {
    }
    @IBAction func createAccount(_ sender: Any) {
    }
    @IBAction func signInWithApple(_ sender: UIButton) {
    }
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SignInWithApple()
//        .frame(width: 280, height: 60)

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        do {
//            users = try context.fetch(users.fetchrequest())
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
