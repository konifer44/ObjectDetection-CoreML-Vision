//
//  ContentView.swift
//  MLObjectDetection
//
//  Created by Jan Konieczny on 06/10/2020.
//

import SwiftUI
import CoreML
import Vision
import AVKit

extension Color {
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(RoundedRectangle(cornerRadius: 25))
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.offWhite)
                            .frame(width: 200, height: 200, alignment: .center)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 2.5, y: 2.5)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -2.5, y: -2.5)
                    } else {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.offWhite)
                            .frame(width: 200, height: 200, alignment: .center)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                })
    }
}

enum ActiveSheet: Identifiable {
    case liveCaptureSheet, photoGallerySheet, resultSheet
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @StateObject var coreML  = ImageClassification()
    @State private var inputImage: UIImage?
    @State var activeSheet: ActiveSheet?
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        coreML.classifyImage(inputImage)
        activeSheet = .resultSheet
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    Text("Live capture:")
                        .font(.title)
                        .font(.system(size: 15)).bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                    
                    Button(action: {
                        activeSheet = .liveCaptureSheet
                    }){
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Spacer()
                    
                    Text("Photo gallery:")
                        .font(.title)
                        .font(.system(size: 15)).bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                    
                    Button(action: {
                        activeSheet = .photoGallerySheet
                    }){
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Spacer()
                }
                .navigationBarTitle("Recognize object from:")
                .sheet(item: $activeSheet) { item in
                    switch item {
                    case .liveCaptureSheet:
                        CameraViewController()
                    case .photoGallerySheet:
                        ImagePicker(image: self.$inputImage).onDisappear(perform: loadImage)
                    case .resultSheet:
                        RecognizedPhotoView().environmentObject(coreML)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
