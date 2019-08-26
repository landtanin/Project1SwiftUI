//
//  ContentView.swift
//  Project1-2SwiftUI
//
//  Created by Tanin on 26/08/2019.
//  Copyright © 2019 landtanin. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State private var hidesNavBar = false
    var selectedImage: String
    
    var body: some View {
        let img = UIImage(named: selectedImage)!
        return Image(uiImage: img)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarHidden(hidesNavBar)
            .navigationBarTitle(Text(selectedImage), displayMode: .inline)
            .onTapGesture {
                self.hidesNavBar.toggle()
            }
    }
}

struct ContentView: View {
    
    let images = ["nssl0033.jpg", "nssl0034.jpg", "nssl0041.jpg", "nssl0042.jpg"]
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(images, id: \.self) { image in
                    NavigationLink(
                        destination: DetailView(selectedImage: image)
                    ) {
                        Text(image)
                    }
                }
            
            }.navigationBarTitle(Text("Storm Viewer"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
