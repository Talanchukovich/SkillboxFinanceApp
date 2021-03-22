//
//  CategoriesVC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 20.03.2021.
//


import UIKit

extension CategoriesVC: ObserverProtocol {
    func loadNewData(incomes: [Income], expensCategories: [ExpensCategory], expenses: [Expens]) {
        categories = expensCategories
    }
}

class CategoriesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        CoreDataManager.coreDataManager.addObserver(self)
        CoreDataManager.coreDataManager.getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false
        CoreDataManager.coreDataManager.removeObserver(self)
    }

    // MARK: categories
    
    var categories: [ExpensCategory] = [] {
        didSet{
            DispatchQueue.main.async {
                self.categoriesTabelView.reloadData()

            }
        }
    }

    // MARK: Createeng MainView
            
    let mainView = UIView()
    let expensesLabel = UILabel()
    let categoriesTabelView = UITableView()
    let openButton = UIButton()
    let openButtonLabel = UILabel()
    private var alertTextfield = UITextField()
    private var category: ExpensCategory?
    
   
    func createMainView(){
        
        // MARK: navigationItem
        
        navigationItem.backButtonTitle = ""
       
        // MARK: mainView
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints{make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        // MARK: expensesLabel

        expensesLabel.attributedText = NSAttributedString(string: "Расходы", attributes: TextAttributes.shared.incomeLabelAttributes)
        mainView.addSubview(expensesLabel)
        expensesLabel.snp.makeConstraints {make in
            make.top.equalTo(mainView.snp.top).offset(34)
            make.centerX.equalToSuperview()
        }
        // MARK: openButton

        openButton.addAction(.init(){[weak self] _ in
                                guard let self = self else {return}
                                self.openMenuVC(menuMode: .adding)}
                             , for: .touchUpInside)
        openButton.tag = 1
        openButton.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        openButton.layer.cornerRadius = 24
        openButton.clipsToBounds = true
        mainView.addSubview(openButton)
        openButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-56)
            make.width.equalTo(344)
            make.height.equalTo(48)
        }
        
        // MARK: openButtonLabel

        openButtonLabel.attributedText = NSAttributedString(string: "Добавить категорию расходов", attributes: TextAttributes.shared.buttonTitleAttributes)
        openButton.addSubview(openButtonLabel)
        openButtonLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        // MARK: expensesTabelView
        
        categoriesTabelView.dataSource = self
        categoriesTabelView.delegate = self
        categoriesTabelView.register(CategoryCell.self, forCellReuseIdentifier: Keyes.shared.categoryCell)
        
            
        categoriesTabelView.rowHeight = 64
        categoriesTabelView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainView.addSubview(categoriesTabelView)
        categoriesTabelView.snp.makeConstraints{make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(expensesLabel.snp.bottom).offset(9)
            make.bottom.equalTo(openButton.snp.top).offset(-43)
            }
        }
    
    // MARK: func openMenuVC
    
    func openMenuVC(menuMode: MenuMode){
        let menuVC = UIStoryboard(name: Keyes.shared.storyBoardIdentifier, bundle: nil).instantiateViewController(withIdentifier: Keyes.shared.menuVCIdentifier) as! MenuVC
        menuVC.modalPresentationStyle = .custom
        menuVC.transitioningDelegate = self
        switch menuMode{
        case .adding:
            menuVC.createMenuViewes(menuType: .expensCategory, menuMode: menuMode, model: category as Any)
        case .editing:
            menuVC.createMenuViewes(menuType: .expensCategory, menuMode: menuMode, model: category as Any)
        }
        present(menuVC, animated: true, completion: nil)
        
    }
}

// MARK: TransitioningDelegate

extension CategoriesVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MenuPC(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: TableViewDataSource

extension CategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTabelView.dequeueReusableCell(withIdentifier: Keyes.shared.categoryCell) as! CategoryCell
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = UIImageView(image: UIImage(systemName: Keyes.shared.chevron_forward))
        let categoryCell = categories[indexPath.row]
        cell.categoryExpLabel.text = categoryCell.categoryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let identifier = "\(index)" as NSString
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _ in
            let deletAction = UIAction(title: "Удалить",
                                       image: UIImage(systemName: Keyes.shared.delete_left),
                                       identifier: nil,
                                       attributes: .destructive) { [weak self]_ in
                guard let self = self else {return}
                CoreDataManager.coreDataManager.deletData(model: self.categories[indexPath.row])
               
            }
            let editAction = UIAction(title: "Редактировать",
                                      image: UIImage(systemName: Keyes.shared.text_redaction),
                                      identifier: nil) {[weak self] _ in
                guard let self = self else {return}
                self.category = self.categories[indexPath.row]
                self.openMenuVC(menuMode: .editing)
            }
            return UIMenu(children: [deletAction, editAction])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoriesTabelView.deselectRow(at: indexPath, animated: true)
        let expensesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ExpensesVC") as ExpensesVC
        expensesVC.category = CoreDataManager.coreDataManager.coreDataExpensCategories[indexPath.row]
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.pushViewController(expensesVC, animated: true)
    }
    
}


