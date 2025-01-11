//
//  ContentView.swift
//  SignitureDemo
//
//  Created by Eyüp on 2023-11-02.
//

import SwiftUI
import SwiftUIDigitalSignature

struct SignatureViewTest: View {
    @State private var image: UIImage? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                NavigationLink("DigitalSignature Package Demo", destination: SignatureView(availableTabs: [.draw, .image, .type],onSave: { image in
                    self.image = image
                }, onCancel: { }))

                NavigationLink("DrafGesture Native Demo", destination: DragGestureDemoView())
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        SignatureViewTest()
    }
}


#Preview {
    ContentView()
}
