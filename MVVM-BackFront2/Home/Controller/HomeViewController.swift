//
//  HomeViewController.swift
//  MVVM-BackFront2
//
//  Created by Edgar Arlindo on 08/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel = ViewModel()
    private var screen: HomeScreenView?
    
    override func loadView() {
        super.loadView()
        
        self.screen = HomeScreenView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate(delegate: self)
        viewModel.fetchAllRequest()
    }
}

//MARK: - ViewModelDelegate (Status request)
extension HomeViewController: ViewModelDelegate {
    func sucessRequest() {
        screen?.setupTableViewProtocols(delegate: self, dataSource: self)
        screen?.reloadTableView()
    }
    
    func errorRequest() {
        print("Error de request")
    }
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? CustomCellTableViewCell else { fatalError()}
        cell.setupCell(with: viewModel.loadCurrentUser(indexPath: indexPath))
        cell.delegate(delegate: self)
        return cell
    }
}


//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.getName(indexPath: indexPath))
    }
}

//MARK: - CustomCellTableViewCellDelegate
extension HomeViewController: CustomCellTableViewCellDelegate {
    func didButtonHeartTapped(user: User) {
        viewModel.updateHeartState(user: user)
    }
}
