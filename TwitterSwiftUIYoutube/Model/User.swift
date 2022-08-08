//
//  User.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 08.08.2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable , Decodable{
    @DocumentID var id : String?
    let username : String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
}
