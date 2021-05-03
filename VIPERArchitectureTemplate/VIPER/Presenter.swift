//
//  Presenter.swift
//  VIPERArchitectureTemplate
//
//  Created by Imran Sayeed on 12/4/21.
//

import Foundation

// Object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    
    var interactor: AnyInteractor? { get set }
    
    var view: AnyView? { get set }
    
    func interactorDidFecthUsers(with result: Result<[User], FetchError>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFecthUsers(with result: Result<[User], FetchError>){
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Somethings went wrong..")
        }
    }
}
