//
//  ContentView.swift
//  Weather
//
//  Created by Mohammad Azam on 4/13/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            
            TextField("Enter name",text: $name)
                .accessibility(identifier: "nameTextField")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
