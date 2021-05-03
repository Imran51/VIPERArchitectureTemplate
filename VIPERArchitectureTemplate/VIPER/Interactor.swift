//
//  Interactor.swift
//  VIPERArchitectureTemplate
//
//  Created by Imran Sayeed on 12/4/21.
//

import Foundation

// object
// protocol
// ref to presenter

// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFecthUsers(with: .failure(FetchError.failed))
                return
            }
            do{
                let getEntities = try JSONDecoder().decode([User].self, from: data)
                
                self?.presenter?.interactorDidFecthUsers(with: .success(getEntities))
            } catch {
                print(error.localizedDescription)
                self?.presenter?.interactorDidFecthUsers(with: .failure(FetchError.failed))
            }
        }
        
        task.resume()
    }
}
