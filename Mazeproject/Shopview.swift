
import SwiftUI

struct Shopview: View {
    @Binding var player: playerinfo
    @State var notenough: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                    VStack {
                        //so you might be asking y didnt i do list here so uhhhh the dumb hitboxes would just overlap so holding anywhere on the list would open contextmenu and buy would press when anywhere
                        HStack {
                            Image(systemName: "cross.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.green)
                            Text("Uraniyums")
                                .padding(10)
                                .foregroundStyle(Color.green)
                                .contextMenu {
                                    Text("So this is basically heals\n It heals 20hp\nI call it uraniyums cuz thats what greg loves")
                                    Text("in inventory: \(player.uraniyums)")
                                }
                            Spacer()
                            Text("cost: 3 coins")
                            Button("Buy") {
                                player.uraniyums += 1
                                if player.coin < 3 {
                                    notenough = true
                                } else {
                                    player.coin -= 3
                                }
                               
                            }
                                .padding(10)
                            }
                        }
                    }
            .alert(isPresented: $notenough) {
                Alert(title: Text("Not enough coins"))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Coins: \(player.coin)")
                }
            }
            }
        }
       
    }

#Preview {
    Shopview(player: .constant(playerinfo(hp: 100, coin: 0, x: 0, y: 0, uraniyums: 0,mapstate: false, glungusandcoinchance: 0)))
}
