
import SwiftUI

struct Mapview: View {
    @Binding var player: playerinfo

    var body: some View {
        ZStack{
            if player.mapstate{
                Text("Uhhhh bad news i havent implemented it yet")
            }else{
                Text("you havent bought map pass,pls buy first then use map")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Toggle("map", isOn: $player.mapstate)
            }
        }

    }
}
#Preview {
    Mapview(player: .constant(playerinfo(hp: 100, coin: 0, x: 0, y: 0, uraniyums: 0, mapstate: false, glungusandcoinchance: 0,hammer: 0)))
}
