//
//  ViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 07/05/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic {
    func displayLogin(viewObject: FetchLoginInfos.VO)
}
class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTableView: UITableView!
    
    var interactor: LoginBusinessLogic?
    var cells: [FetchLoginInfos.Response.CellType]?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        LoginConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTableView.delegate = self
        loginTableView.dataSource = self
        loginTableView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "textFieldCell")
        loginTableView.register(UINib(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "btCell")
        interactor?.handleLogin(request: FetchLoginInfos.Request())
    }

}

extension LoginViewController: UITableViewDelegate {
    
}

extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells![indexPath.row] {
            case .textField(let textField):
                let item = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextFieldTableViewCell
                item.setTextField(placeHolderText: textField)
                if textField == "Senha" {
                    item.textField.isSecureTextEntry = true
                }
                return item
            case .buttonAction(let actionText):
                let item = tableView.dequeueReusableCell(withIdentifier: "btCell", for: indexPath) as! ButtonTableViewCell
                item.setOption(optionText: actionText)
                return item
            case .buttonFinalization(let finalizationText):
                let item = tableView.dequeueReusableCell(withIdentifier: "btCell", for: indexPath) as! ButtonTableViewCell
                item.setFinalization(buttonText: finalizationText)
                return item
            }
        return UITableViewCell()
    }
}

extension LoginViewController: LoginDisplayLogic {
    func displayLogin(viewObject: FetchLoginInfos.VO) {
        loginLabel.text = viewObject.labelText
        cells = viewObject.cellType
    }
}
