//
//  CustomInputField.swift
//  TwitterSwiftUIYoutube
//
//  Created by Айдана Шарипбай on 13.07.2022.
//

import SwiftUI

struct CustomInputField: View {
    let imageName:String
    let placeholderText:String
    @Binding var text:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                TextField(placeholderText,text:$text)
                
            }
            
            Divider()
                .background(Color(.gray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "Email", text: .constant(""))
    }
}
