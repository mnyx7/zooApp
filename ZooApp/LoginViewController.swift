//
//  LoginViewController.swift
//  BankAppTableView
//
//  Created by Minaya Yagubova on 31.01.23.
//

import UIKit


class LoginViewController: UIViewController, DelegateProtocol {
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    var user: Profile?
    var profiles = [Profile]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dummy user
        
        user = Profile(fullname: "Minaya", email: "test", birthdate: "12/15/99", password: "test123", phoneNumber: "12345")
        loginEmail.text = user?.email
        loginPassword.text = user?.password
    }
    
    func getFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectory = paths[0]
        let path = docDirectory.appendingPathComponent("Users.json")
        print(path)
        return path
    }
    
    func readDataFromFile() {
        if let data = try? Data(contentsOf: getFilePath()){
            do{
                profiles = try JSONDecoder().decode([Profile].self, from: data)
            } catch {
                print(error.localizedDescription)
                
            }
        } else {
                print("File does not exist")
        }
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
          let regController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(RegisterViewController.self)") as! RegisterViewController
          regController.delegate = self
          navigationController?.show(regController, sender: nil)
      }
    
    
    @IBAction func buttonLogin(_ sender: Any) {
        
        if let loginEmail = loginEmail.text,
           let loginPassword = loginPassword.text,
           !loginEmail.isEmpty, !loginPassword.isEmpty
        {
            if loginPassword.count >= 5 && loginPassword.count <= 10 {
//                let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(HomeTableViewController.self)") as! HomeTableViewController
//                homeController.user = user
//                navigationController?.show(homeController, sender: nil)
                
                readDataFromFile()
                
                for profile in profiles {
                    if loginEmail == profile.email && loginPassword == profile.password {
                        let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ZooListViewController.self)") as! ZooListViewController
                      //  homeController.user = user
                        navigationController?.show(homeController, sender: nil)
                    }
                }
                
            } else{
                print("Wrong Password")
            }
        } else{
                print("Sehv melumat daxil etdiniz, tekrar yoxlayin")

            }
        }
    
    func setText(nameS: String, email: String, bday: String, phoneN: String, passwordL: String) {
        user = Profile(fullname: nameS, email: email, birthdate: bday, password: passwordL, phoneNumber: phoneN)
        loginEmail.text = email
        loginPassword.text = passwordL
        
    }
}
    
