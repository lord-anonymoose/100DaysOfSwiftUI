//
//  ContentView.swift
//  Instafilter
//
//  Created by Philipp on 13.02.2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var filterTitle = "Choose filter"
    @State private var showErrorMessage = false
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    let context = CIContext()
    
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            })
        
        return NavigationView {
            VStack {
                ZStack {
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color.secondary)
                            Text("Tap to select a picture")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button(self.filterTitle) {
                        self.showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save changes") {
                        guard let processedImage = self.processedImage else {showErrorMessage = true; return}
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                        
                        imageSaver.successHandler = { print("Success") }
                        imageSaver.errorHandler = { print("\($0.localizedDescription)")}
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()); self.filterTitle = "Crystallize" },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()); self.filterTitle = "Edges" },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()); self.filterTitle = "Gaussian Blur" },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()); self.filterTitle = "Pixellate" },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()); self.filterTitle = "Sepia Tone" },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()); self.filterTitle = "Unsharp Mask" },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()); self.filterTitle = "Vignette" },
                    .cancel()
                ])
            }
            .alert(isPresented: self.$showErrorMessage) {
                                Alert(title: Text("Error"), message: Text("No image provided to save!"), dismissButton: .default(Text("OK")))
                            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey:kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
