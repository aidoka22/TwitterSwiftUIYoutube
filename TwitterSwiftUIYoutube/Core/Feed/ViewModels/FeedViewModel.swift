//
//  FeedViewModel.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 10.08.2022.
//

import Foundation

class FeedViewModel :ObservableObject{
    @Published var tweets = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    
    init(){
        fetchTweets()
    }
    
    func fetchTweets(){
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            tweets.forEach { tweet in
                let uid = tweet.uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    
                }
            }
        }
    }
}

