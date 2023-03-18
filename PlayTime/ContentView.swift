//
//  ContentView.swift
//  PlayTime
//
//  Created by Kusakabe Koki on 2023/03/16.
//

import SwiftUI


struct Player: Hashable {
    var id = UUID()
    var number: Int
    var name: String
    var flags: Bool = false 
}

let players = [
    Player(number: 1, name: "石井 洸一"),
    Player(number: 5, name: " 小川 大介"),
    Player(number: 9, name: "松尾 昴太郎"),
    Player(number: 12, name: "松川 隆太"),
    Player(number: 13, name: "坂本 飛鳥"),
    Player(number: 17, name: "日下部 洸希")]

var onPlayMenbers: [Player] = [players[0]]

struct OnPlayerView: View {
    
    var body: some View{
        List{
            Section(header: Text("出場中").font(.title)){
                ForEach(onPlayMenbers, id:\.self){player in
                    HStack{
                        Text("#"+String(player.number))
                        Text(player.name)
                    }
                    
                }
            }
        }
    }
}

struct PlayerListView: View {
    @State var flags = [false,false,false,false,false,false]
    
    
    var body: some View {
        VStack{
            List{
                
                Section(header: Text("北海道大学").font(.title)){
                    ForEach(players.indices, id:\.self){ num in
                        HStack{
                            Text("#"+String(players[num].number))
                            Text(players[num].name)
                            Spacer()
                            Button(action: {
                                flags[num].toggle()
                                if flags[num] {
                                    onPlayMenbers.append(players[num])
                                    
                                }else{
                                    
                                }
                                
                            }, label: {
                                Text("出場中")
                            })
                            .buttonStyle(BorderlessButtonStyle())
                            
                        }
                    }.listStyle(SidebarListStyle())
                }
                
            }
            OnPlayerView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        PlayerListView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
