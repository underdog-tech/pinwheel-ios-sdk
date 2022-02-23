//
//  LinkConfigTableViewController.swift
//  PinwheelSDK_Example
//
//  Created by Robby Abaya on 11/19/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import PinwheelSDK

class ConfigField {
    var label: String
    var value: String
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
}

class LinkConfigTableViewController: UITableViewController, UINavigationControllerDelegate {
    var data = [
        ConfigField(label:"account_number", value:"304119574487"),
        ConfigField(label:"account_type", value:"checking"),
        ConfigField(label:"job", value:"direct_deposit_switch"),
        ConfigField(label:"mode", value:"sandbox"),
        ConfigField(label:"org_name", value:"Underdog Savings and Loan"),
        ConfigField(label:"routing_number", value:"091302966"),
        ConfigField(label:"skip_exit_survey", value:"false"),
        ConfigField(label:"skip_intro_screen", value:"false")
    ]
    let lt = LinkToken()
    var pinwheelVC: PinwheelViewController?
    var selected:Int = 0
    
    private var events = Array<EventData>()

    override func viewDidLoad() {
        super.viewDidLoad()
        lt.delegate = self
        navigationController?.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section >= data.count {
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "button", for: indexPath)
            return buttonCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)

        if let textLabel = cell.textLabel {
            textLabel.text = data[indexPath.section].value
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard section < data.count else {
            return nil
        }
        
        return data[section].label
    }

    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section < data.count {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ConfigEntryViewController") as? ConfigEntryViewController {
                vc.data = data[indexPath.section]
                    navigationController?.pushViewController(vc, animated: true)
                }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ConfigEntryViewController {
            vc.data = data[selected]
        }
    }
    
    @IBAction func handleFetchTap() {
        var linkTokenAttributes = LinkTokenAttributes()

        for cf in data {
            switch cf.label {
            case "account_number":
                linkTokenAttributes.account_number = cf.value
            case "account_type":
                linkTokenAttributes.account_type = cf.value
            case "job":
                linkTokenAttributes.job = cf.value
            case "mode":
                linkTokenAttributes.mode = cf.value
            case "org_name":
                linkTokenAttributes.org_name = cf.value
            case "routing_number":
                linkTokenAttributes.routing_number = cf.value
            case "skip_exit_survey":
                linkTokenAttributes.skip_exit_survey = cf.value.lowercased() == "true"
            case "skip_intro_screen":
                linkTokenAttributes.skip_intro_screen = cf.value.lowercased() == "true"
            case "employer_id":
                linkTokenAttributes.employer_id = cf.value
            default:
                print("Missing case for label: \(cf.label), value: \(cf.value)")
            }
        }
        
        lt.fetchTokenWithAttributes(linkTokenAttributes)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        self.tableView.reloadData()
    }
}

extension LinkConfigTableViewController: LinkTokenDelegate {
    func onComplete(linkToken: String) {
        pinwheelVC = PinwheelViewController(token: linkToken, delegate: self)
    }
}

extension LinkConfigTableViewController: PinwheelDelegate {
    
    func onEvent(name: PinwheelEventType, event: PinwheelEventPayload?) {
        events.append(EventData(name: name, event: event))
        
        switch name {
        case .open:
            self.present(pinwheelVC!, animated: true)
            print("onEvent(name: .open")
        case .selectEmployer:
            print("onEvent(name: .selectEmployer")
        case .selectPlatform:
            print("onEvent(name: .selectPlatform")
        case .incorrectPlatformGiven:
            print("onEvent(name: .incorrectPlatformGiven")
        case .login:
            print("onEvent(name: .login")
        case .loginAttempt:
            print("onEvent(name: .loginAttempt")
        case .inputAmount:
            print("onEvent(name: .inputAmount")
        case .inputRequired:
            print("onEvent(name: .inputRequired")
        case .exit:
            print("onEvent(name: .exit")
            self.dismiss(animated: true)
        case .success:
            print("onEvent(name: .success")
            self.dismiss(animated: true)
        case .error:
            print("onEvent(name: .error")
        }
    }
    
    func onExit(_ error: PinwheelError?) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsTableViewController") as? EventsTableViewController {
            
            vc.events = events
            self.navigationController?.pushViewController(vc, animated: true)
        }
        print("onExit")
    }
    
    func onError(_ error: PinwheelError) {
        print("onError")
    }
    
    func onSuccess(_ result: PinwheelSuccessPayload) {
        print("onSuccess")
    }
    
    func onLogin(_ result: PinwheelLoginPayload) {
        print("onLogin")
    }
    
    func onLoginAttempt(_ result: PinwheelLoginAttemptPayload) {
        print("onLoginAttempt")
    }
}
