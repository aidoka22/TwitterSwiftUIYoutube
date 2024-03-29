//
//  FeedView.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 10.06.2022.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false
    @ObservedObject  var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.tweets) { tweet in
                        TweetRowView(tweet: tweet).padding()
                    }
                }
            }
            Button{
                showNewTweetView.toggle()
            }label:{
                Image("tweet")
                    .resizable()
                    .frame(width:80,height:80)
            }
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView){
                NewTweetView()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
