//
//  ImageClassification.swift
//  
//
//  Created by Jan Konieczny on 06/10/2020.
//

import Foundation
import CoreML
import Vision
import UIKit

class ImageClassification: ObservableObject {
    @Published var topClassifications: [(confidence: VNConfidence, identifier: String)]
    @Published var topIdentifiers: [String]
    @Published var topIdentifier: String
    init() {
        topClassifications = [(confidence: 0.0, identifier: "")]
        topIdentifiers = [String]()
        topIdentifier = String()
    }
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: SqueezeNet().model)
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                guard let self = self else {
                    return
                }
                self.processClassifications(for: request, error: error)
            }
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    func classifyImage(_ image: UIImage) {
        guard let orientation = CGImagePropertyOrientation(
                rawValue: UInt32(image.imageOrientation.rawValue)) else {
            return
        }
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        DispatchQueue.global(qos: .userInitiated).async {
            let handler =
                VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            if let classifications = request.results as? [VNClassificationObservation] {
                self.topClassifications = classifications.prefix(3).map {(confidence: $0.confidence, identifier: $0.identifier)}
                self.topIdentifiers = self.topClassifications.map {$0.identifier.lowercased() }
                self.topIdentifier = self.topIdentifiers[0]
            }
        }
    }
}
