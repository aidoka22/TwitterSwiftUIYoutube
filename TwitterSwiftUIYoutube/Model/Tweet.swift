//
//  Tweet.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 10.08.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet : Identifiable ,  Decodable{
    @DocumentID var id: String?
    let caption : String
    let timestamps : Timestamp
    let uid : String
    var likes : Int
    
    var user: User?
    var didLike: Bool? = false
}
