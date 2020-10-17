//
//  RecognizedPhotoView.swift
//  MLObjectDetection
//
//  Created by Jan Konieczny on 10/10/2020.
//

import SwiftUI

struct RecognizedPhotoView: View {
   // @State var image: Image?
    // @State var topIdentifier = ""
    @EnvironmentObject var coreML:  ImageClassification
    
    var body: some View {
        VStack {
            if coreML.classifiedImage == nil {
                ProgressView("Proccesing…")
            } else {
                coreML.classifiedImage?
                    .resizable()
                    .scaledToFit()
                    .padding()
                    
                
                Text("I think this is: \(coreML.topIdentifier)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 20))
                    .padding(.horizontal)
            }

        }
    }
}

