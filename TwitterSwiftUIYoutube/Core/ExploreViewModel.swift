//
//  ExploreViewModek.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 09.08.2022.
//

import Foundation

class ExploreViewModel: ObservableObject{
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers : [User]{
        if searchText.isEmpty{
            return users
        }else{
            let lowercasedWQuery = searchText.lowercased()
            
            return users.filter ({
                $0.username.contains(lowercasedWQuery) ||
                $0.fullname.contains(lowercasedWQuery)
            })
        }
    }
    
    let service = UserService()
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers(){
        service.fetchUsers { users in
            self.users=users
        }
    }
}
