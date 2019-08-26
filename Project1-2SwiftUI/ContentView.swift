//
//  ContentView.swift
//  Project1-2SwiftUI
//
//  Created by Tanin on 26/08/2019.
//  Copyright © 2019 landtanin. All rights reserved.
//

import SwiftUI
import Combine

class DataSource: ObservableObject {

    var willChange = PassthroughSubject<Void, Never>()
    var images = [String]()

    init() {

        let fm = FileManager.default

        guard let path = Bundle.main.resourcePath else { return }
        guard let items = try? fm.contentsOfDirectory(atPath: path) else { return }

        for item in items {
            if item.hasPrefix("nssl") {
                images.append(item)
            }
        }

        willChange.send(())

    }

}

extension String: Identifiable {
    public var id: String { self }
}

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
    
    // ObjectBinding should be used here to prevent reloading of DataSource every time this struct changes
    // But ObjectBidning is deprecated
    var dataSource = DataSource()
    
    var body: some View {
        NavigationView {

// Using ForEach
//            List {
//                ForEach(dataSource.images, id: \.self) { image in
//                    NavigationLink(
//                        destination: DetailView(selectedImage: image)
//                    ) {
//                        Text(image)
//                    }
//                }
//
//            }.navigationBarTitle(Text("Storm Viewer"))
            
// Make String Identifiable, don't use ForEach
            List(dataSource.images) { image in
                NavigationLink(
                    destination: DetailView(selectedImage: image)
                ) {
                    Text(image)
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
