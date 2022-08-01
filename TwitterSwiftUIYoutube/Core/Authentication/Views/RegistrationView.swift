//
//  RegistrationView.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 13.07.2022.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email=""
    @State private var username=""
    @State private var fullname=""
    @State private var password=""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelecterView(),
                           isActive: $viewModel.didAuthenticateUser,
                           label: {})
            
            AuthHeaderView(title1: "Get Started.", title2: "Create your account")
            
            VStack(spacing:40){
                CustomInputField(imageName: "envelope",
                                 placeholderText: "Email",
                                 isSecureField: false,
                                 text: $email)
                
                CustomInputField(imageName: "person",
                                 placeholderText: "Username",
                                 isSecureField: false,
                                 text: $username)
                
                CustomInputField(imageName: "person",
                                 placeholderText: "Fullname",
                                 isSecureField: false,
                                 text: $fullname)
                
                CustomInputField(imageName: "lock",
                                 placeholderText: "Password",
                                 isSecureField: true,
                                 text: $password)
            }
            .padding(32)
            
            Button{
                viewModel.register(withEmail: email,
                                   password: password,
                                   fullname: fullname,
                                   username: username)
            }label: {
                Text("Sign up" )
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)

            
            Spacer()
            
            Button{
                presentationMode.wrappedValue.dismiss()
            }label: {
                HStack{
                    Text("Already have an account")
                        .font(.footnote)
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }.padding(.bottom)
                .foregroundColor(Color(.systemBlue))
            
        }.ignoresSafeArea()

    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
