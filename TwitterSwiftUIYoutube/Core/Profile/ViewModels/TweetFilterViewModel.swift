//
//  TweetFilterViewModel.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 20.06.2022.
//

import Foundation

enum TweetFilterViewModel: Int,CaseIterable {
    case tweets
    case replies
    case likes
    
    var title:String{
        switch self{
        case .tweets: return "Tweets"
        case .likes:return "Likes"
        case .replies:return "Replies"
        }
    }
}

