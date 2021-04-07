//
//  ContentView.swift
//  weather-API-SwiftUI
//
//  Created by Abdullah Alnutayfi on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    @State  var cityName = ""
    @StateObject var vm = WeatherViewModel()
    var body: some View {
        HStack{
          
        TextField("city name", text: $cityName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                    vm.fetchWeatherData(cityName: cityName)
            }, label: {
                Image(systemName: "magnifyingglass")
                  
                    .padding(8)
                    .background(Color.white)
                    .shadow(color:.black,radius: 10)
                    .cornerRadius(10)
            })
        }.padding(.horizontal)
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white,.gray,.blue, .gray,]), startPoint: .top, endPoint: .bottom).opacity(0.50)
            List{
                ForEach(vm.weather){ weather in
                    HStack(alignment: .firstTextBaseline){
                    Text(weather.name)
                        .frame(width: 100)
                        Spacer()
                        Text("\((weather.main.temp - 273.15), specifier: "%.0f")°")
                            .shadow(color: .yellow ,radius: 10)
                            .offset(x: -20)
                    ForEach(weather.weather){ w in
                  Spacer()
                        Image(systemName: w.icon)
                                .resizable()
                                .frame(width: 30, height: 30)
                            .foregroundColor(.secondary)
                            .shadow(color: .yellow,radius: 10)
                         
                    }
                    }
                   // Divider()
                }.onDelete(perform: { indexSet in
                    vm.weather.remove(atOffsets: indexSet)
                })
                .listRowBackground( LinearGradient(gradient: Gradient(colors: [.white,.gray,.blue, .gray,]), startPoint: .top, endPoint: .bottom).opacity(0.50))
                   
                
               
            //.foregroundColor(.white)
        }//.padding()
        .animation(.easeIn)
            
        
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 List{

     ForEach(vm.weather){ weather in
         HStack(alignment: .firstTextBaseline){
         Text(weather.name)
             .frame(width: 100)
             Spacer()
             Text("\((weather.main.temp - 273.15), specifier: "%.0f")°")
         ForEach(weather.weather){ w in
       Spacer()
             Image(systemName: w.icon)
                     .resizable()
                     .frame(width: 30, height: 30)
                 .foregroundColor(.secondary)
                 .shadow(color: .yellow,radius: 10)
              
         }
         }
        // Divider()
     }.onDelete(perform: { indexSet in
         vm.weather.remove(atOffsets: indexSet)
     })
     .listRowBackground( LinearGradient(gradient: Gradient(colors: [.white,.gray,.blue, .gray,]), startPoint: .top, endPoint: .bottom).opacity(0.50))
     Spacer()
 .foregroundColor(.white)
}//.padding()
.animation(.easeIn)*/
