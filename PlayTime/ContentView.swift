//
//  ContentView.swift
//  PlayTime
//
//  Created by Kusakabe Koki on 2023/03/16.
//

import SwiftUI


struct Player: Identifiable {
    var id = UUID()
    var number: Int
    var name: String
}

let players = [
    Player(number: 1, name: "石井 洸一"),
    Player(number: 5, name: " 小川 大介"),
    Player(number: 9, name: "松尾 昴太郎"),
    Player(number: 12, name: "松川 隆太"),
    Player(number: 13, name: "坂本 飛鳥"),
    Player(number: 17, name: "日下部 洸希")]

//let playerInfomation:Dictionary<Int,String> = [ 1: "石井 洸一", 5:"小川 大介", 9:"松尾 昴太郎", 12:"松川 隆太", 13:"坂本 飛鳥", 17:"日下部 洸希" ]

struct ContentView: View {
    @State var flags = [false,false,false,false,false,false]
    
    var body: some View {
        List{
            Section(header: Text("北海道大学").font(.title)){
                ForEach(players.indices, id:\.self){ num in
                    Toggle(isOn: $flags[num]){
                        HStack{
                            Text("#"+String(players[num].number))
                            Text(players[num].name)
                        }
                        
                    }
                }
            }
        }.listStyle(SidebarListStyle())
        
    }
    
}

//gitコメントを追加する

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
