//
//  RecognizedPhotoView.swift
//  MLObjectDetection
//
//  Created by Jan Konieczny on 10/10/2020.
//

import SwiftUI

struct RecognizedPhotoView: View {
    @State var image: Image?
    @State var topIdentifier = ""
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                .padding()
            if topIdentifier.isEmpty {
                Text("Sorry I Cant recognize :(")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 20))
            } else {
                Text("I think this is: \(topIdentifier)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 20))
            }
           
        }
    }
}

