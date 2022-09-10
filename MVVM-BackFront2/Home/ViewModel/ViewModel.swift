//
//  ViewModel.swift
//  MVVM-BackFront2
//
//  Created by Edgar Arlindo on 08/09/22.
//

import UIKit

protocol ViewModelDelegate: AnyObject {
    func sucessRequest()
    func errorRequest()
}

class ViewModel {
    private let service = Service()
    private var listUser: [User] = []
    private weak var delegate: ViewModelDelegate?
    
    public func delegate(delegate: ViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func fetchAllRequestMock() {
        service.getUserFromJson(fromFileNamed: "user") { [weak self] (success, error) in
            if let _success = success {
                self?.listUser = _success.group
                self?.delegate?.sucessRequest()
            } else {
                self?.delegate?.errorRequest()
            }
        }
    }
    
    public func fetchAllRequest() {
        service.getUser() { [weak self] (success, error) in
            if let _success = success {
                self?.listUser = _success.group
                self?.delegate?.sucessRequest()
            } else {
                self?.delegate?.errorRequest()
            }
        }
    }
    
    
    public var numberOfRows: Int {
        return self.listUser.count
    }
    
    public func loadCurrentUser(indexPath: IndexPath) -> User {
        return  self.listUser[indexPath.row]
    }
            
    public func getName(indexPath: IndexPath) -> String {
        return  self.listUser[indexPath.row].name
    }
    
    public func updateHeartState(user: User) {
        if let row = listUser.firstIndex(where: { user.identifier == $0.identifier }) {
            self.listUser[row] = user
        }
    }
}


