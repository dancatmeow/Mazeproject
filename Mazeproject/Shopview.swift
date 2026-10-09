
import SwiftUI

struct Shopview: View {
    @Binding var player: playerinfo
    @State var notenough: Bool = false
    @State var chanceoverflow: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView{
                    
                    //so you might be asking y didnt i do list here so uhhhh the dumb hitboxes would just overlap so holding anywhere on the list would open contextmenu and buy would press when anywhere
                    VStack {
                        Image("shop")
                            .resizable()
                            .frame(width: 368, height: 496)
                        
                        ZStack{
                            Capsule()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 400, height: 50)
                            HStack{
                                Image("uraniyum")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(10)
                                
                                Text("Uraniyums")
                                    .foregroundStyle(Color.green)
                                    .contextMenu {
                                        Text("So this is basically heals\n It heals 20hp\nI call it uraniyums cuz thats what greg loves")
                                        Text("in inventory: \(player.uraniyums)")
                                    }
                                Spacer()
                                Text("cost: 3 vanadium")
                                Button("Buy") {
                                    if player.coin < 3 {
                                        notenough = true
                                    } else {
                                        player.coin -= 3
                                        player.uraniyums += 1
                                    }
                                    
                                }
                                .padding(10)
                            }
                        }
                        ZStack{
                            Capsule()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 400, height: 50)
                            HStack{
                                Image(systemName: "gauge.with.dots.needle.0percent")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(10)
                                
                                Text("Glungus repelent")
                                    .foregroundStyle(Color.green)
                                    .contextMenu {
                                        Text("It makes glungus spawn less but decreases the amount of coins you obtain")
                                        Text("glungus encounter chance:  1/\(player.glungusandcoinchance+10)")
                                        Text("glungus coin chance:  1/\(player.glungusandcoinchance+4)")
                                    }
                                Spacer()
                                Text("cost: 5 vanadium")
                                Button("Buy") {
                                    if player.coin < 5 {
                                        notenough = true
                                    } else {
                                        player.coin -= 5
                                        player.glungusandcoinchance += 1
                                    }
                                    
                                }
                                .padding(10)
                            }
                        }
                        
                        ZStack{
                            Capsule()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 400, height: 50)
                            HStack{
                                Image(systemName: "gauge.with.dots.needle.100percent")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(10)
                                
                                Text("Coin luck increaser")
                                    .foregroundStyle(Color.red)
                                    .contextMenu {
                                        Text("It makes coins spawn more but increases the chance of encountering glungus")
                                        Text("glungus encounter chance:  1/\(player.glungusandcoinchance+10)")
                                        Text("glungus coin chance:  1/\(player.glungusandcoinchance+4)")
                                    }
                                Spacer()
                                Text("cost: 5 vanadium")
                                Button("Buy") {
                                    if player.coin < 5 {
                                        notenough = true
                                    } else if player.glungusandcoinchance + 4 <= 0 {
                                        chanceoverflow = true
                                    } else {
                                        player.coin -= 5
                                        player.glungusandcoinchance -= 1
                                    }
                                    
                                }
                                .padding(10)
                            }
                        }
                        if !player.mapstate{
                            ZStack{
                                Capsule()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 400, height: 50)
                                HStack{
                                    Image(systemName:"map.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(Color.blue)
                                        .padding(10)
                                    
                                    Text("unlock map")
                                        .foregroundStyle(Color.blue)
                                        .contextMenu {
                                            Text(" This is the map pass that will allow you to unlock the map tab")
                                            if player.mapstate{
                                                Text("unlocked")
                                            } else{
                                                Text("not unlocked yet")
                                            }
                                            
                                        }
                                    Spacer()
                                    Text("cost: 10 vanadium")
                                    Button("Buy") {
                                        if player.coin < 10 {
                                            notenough = true
                                        } else {
                                            player.coin -= 10
                                            player.mapstate = true
                                        }
                                        
                                    }
                                    .padding(10)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Coins: \(player.coin)") {
                            player.coin += 10
                        }
                    }
                }
                .alert("Not enough vanadium", isPresented: $notenough) {
                    Button("OK", role: .cancel) { }
                }
                .alert("Chance limit reached", isPresented: $chanceoverflow) {
                    Button("OK", role: .cancel) { }
                }
            }
        }
        
    }
}
       


#Preview {
    Shopview(player: .constant(playerinfo(hp: 100, coin: 0, x: 0, y: 0, uraniyums: 0,mapstate: false, glungusandcoinchance: 0,hammer: 0)))
}
