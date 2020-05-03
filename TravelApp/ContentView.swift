//
//  ContentView.swift
//  TravelApp
//
//  Created by Athena Raya on 4/28/20.
//  Copyright © 2020 Emmanuel Castillo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Home : View {
    
    var body : some View{
        VStack(spacing:15){
            HStack{
                VStack(alignment: .leading, spacing: 15){
                    Text("Restaurants Near you").font(.largeTitle)
                    
                    Button(action:{
                        
                    }){
                        HStack(spacing: 8){
                            Image(systemName: "cheron.down").font(.body)
                        }
                    }.foregroundColor(.green)
                     
                }
                Spacer()
                
                Button(action: {
                    
                }){
                    Image("Restaurants").renderingMode(.original)
                }
            }
        }
    }
}
