//
//  ContentView.swift
//  PlayTime
//
//  Created by Kusakabe Koki on 2023/03/16.
//

import SwiftUI

struct Player:Identifiable{
    var id = UUID()
    var number: Int
    var name: String
    var flags: Bool
    
    init(number:Int , name:String , flags:Bool){
        self.number = number
        self.name = name
        self.flags = flags
    }
}

class PlayerModel:ObservableObject{
    @Published var people:[Player]
    init(){
        self.people = [
            Player(number: 1, name: "石井 洸一", flags: false),
            Player(number: 5, name: " 小川 大介", flags: true),
            Player(number: 9, name: "松尾 昴太郎", flags: false),
            Player(number: 12, name: "松川 隆太", flags: false),
            Player(number: 13, name: "坂本 飛鳥", flags: false),
            Player(number: 17, name: "日下部 洸希", flags: false)]
        
    }
}



struct PlayerListView: View {
    @ObservedObject var playerModel:PlayerModel = PlayerModel()
    @State var flg : Bool = false
    var body: some View {
        VStack{
            List{
                Section(header: Text("北海道大学").font(.title)){
                    ForEach(playerModel.people.indices, id: \.self){ num in
                        HStack{
                            Text("#"+String(playerModel.people[num].number))
                            Text(playerModel.people[num].name)
                            Spacer()
                            Button(String(playerModel.people[num].flags)){
                                playerModel.people[num].flags.toggle()
                            }.buttonStyle(BorderlessButtonStyle())
                            
                        }
                    }.listStyle(SidebarListStyle())
                }
                //                Section(header: Text("出場中").font(.title)){
                //                    ForEach(onPlayMenbers, id:\.self){player in
                //                        HStack{
                //                            Text("#"+String(player.number))
                //                            Text(player.name)
                //                        }
                //
                //                    }
                //                }
                
            }
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
