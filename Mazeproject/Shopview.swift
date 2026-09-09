
import SwiftUI

struct Shopview: View {
    @Binding var player: playerinfo
    var body: some View {
        NavigationStack {
            ZStack {
                List{
                    HStack{
                        Text("Uraniyums")
                            .contextMenu {
                            Text("So this is basically heals \n i call it uraniyums cuz thats what greg loves")
                            }
                        Spacer()
                        Button("Buy"){
                            print("uraniyum purchased")
                        }
                    }
                }
                }
            .toolbar {
                Text("Coins: \(player.coin)")
            }
        }
       
    }
}
#Preview {
    Shopview(player: .constant(playerinfo(hp: 100, coin: 0, inventory: [], x: 0, y: 0)))
}
