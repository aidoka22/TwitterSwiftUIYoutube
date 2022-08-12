//
//  TweetService.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 10.08.2022.
//

import Firebase

struct TweetService{
    
    func uploadTweet(caption:String, completion: @escaping(Bool)-> Void){
        guard let uid=Auth.auth().currentUser?.uid else {return}
        
        let data = ["uid": uid ,
                    "caption" : caption ,
                    "likes" : 0 ,
                    "timestamps": Timestamp(date: Date())   ] as [String : Any]
        Firestore.firestore().collection("tweets").document()
            .setData(data){ error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet with error \(error)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func fetchTweets(completion: @escaping([Tweet])-> Void){
        Firestore.firestore().collection("tweets")
            .order(by: "timestamps", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let tweets = documents.compactMap { try?
                $0.data(as: Tweet.self)
            }
            completion(tweets)
        }
    }
    
    func fetchTweets(forUid  uid : String , completion: @escaping([Tweet])-> Void){
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let tweets = documents.compactMap { try?
                $0.data(as: Tweet.self)
            }
                completion(tweets.sorted(by: {
                    $0.timestamps.dateValue() > $1.timestamps.dateValue()
                }))
        }
    }
    
   
}

//MARK: -LIKES
extension TweetService{
    func likeTweet(_ tweet : Tweet , completion : @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes" : tweet.likes+1]) { _ in
                userLikesRef.document(tweetId).setData([:]) { _ in
                   completion()
                }
            }
    }
    
    
    func unlikeTweet(_ tweet : Tweet , completion : @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        guard tweet.likes > 0 else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")

        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes" : tweet.likes-1]) { _ in
                userLikesRef.document(tweetId).delete{ _ in
                   completion()
                }
            }
    }
    
    func checkIfUserLikedTweet(_ tweet : Tweet , completion : @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes")
            .document(tweetId).getDocument { snapchot, _ in
                guard let snapchot = snapchot else {return}
                completion(snapchot.exists)
            }
    }
    
    func fetchLikedTweets( forUid uid : String , completion: @escaping([Tweet]) -> Void){
        
        var tweets = [Tweet]()
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes")
            .getDocuments { snapchot, _ in
                guard let documents = snapchot?.documents else {return}
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapchot, _ in
                            guard let tweet = try? snapchot?.data(as: Tweet.self) else {return}
                            tweets.append(tweet)
                            
                            completion(tweets)
                            
                        }
                }
            }
    }
}
