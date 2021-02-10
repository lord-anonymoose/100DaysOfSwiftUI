//
//  ContentView.swift
//  Instafilter
//
//  Created by Philipp on 08.02.2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins


class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ContentView: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    /*
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    */
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .onAppear(perform: loadImage)
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    
    /*
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
    
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        //let currentFilter = CIFilter.pixellate()
        //let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        //currentFilter.intensity = 1
        //currentFilter.scale = 10
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
 */
        /*
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
 
        
        Text("Hello, world \(blurAmount)!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .blur(radius: blurAmount)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"), message: Text("Choose color"), buttons: [
                    .default(Text("Red")) { self.backgroundColor = .red},
                    .default(Text("Green")) { self.backgroundColor = .green},
                    .default(Text("Blue")) { self.backgroundColor = .blue},
                    .cancel()
                ])
            }
        Slider(value: blur, in: 0...20)
            .padding()
 */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
