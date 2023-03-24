//
//  RegisterViewController.swift
//  BankAppTableView
//
//  Created by Minaya Yagubova on 31.01.23.
//

import UIKit
protocol DelegateProtocol {
    func setText(nameS: String,
                 email: String,
                 bday: String,
                 phoneN: String,
                 passwordL: String
    )
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var regEmail: UITextField!
    @IBOutlet weak var regName: UITextField!
    @IBOutlet weak var regBday: UITextField!
    @IBOutlet weak var regPhone: UITextField!
    @IBOutlet weak var regPassword: UITextField!
    //    @IBOutlet weak var regBday: UITextField!
        
    var delegate: DelegateProtocol?
    var profiles = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readDataFromFile()
        
    }
    func getFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectory = paths[0]
        let path = docDirectory.appendingPathComponent("Users.json")
        print(path)
        return path
    }
    
    func writeToJsonFile() {
        do{
            let data = try JSONEncoder().encode(profiles)
            try data.write(to: getFilePath())
        } catch{
            print(error.localizedDescription)
        }
    }
    func readDataFromFile(){
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
    
    @IBAction func registerButton(_ sender: Any) {
        if let regName = regName.text,
           let regBday = regBday.text,
           let regEmail = regEmail.text,
           let regPhone = regPhone.text,
           let regPassword = regPassword.text,
           !regName.isEmpty, !regBday.isEmpty, !regEmail.isEmpty, !regPhone.isEmpty, !regPassword.isEmpty {
            profiles.append(Profile(fullname: regName, email: regEmail, birthdate: regBday, password: regPassword, phoneNumber: regPhone))
            writeToJsonFile()
            
            delegate?.setText(nameS: regName, email: regEmail, bday: regBday, phoneN: regPhone, passwordL: regPassword)
            if regPhone.count > 0 && regPhone.count <= 10 {
                
            } else{
                print("Wrong Password")
            }
        } else {
            print("Sehv melumat daxil etdiniz, tekrar yoxlayin")
            
        }
        navigationController?.popViewController(animated: true)
    }
}
