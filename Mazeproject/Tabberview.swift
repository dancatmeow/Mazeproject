import SwiftUI

struct Tabberview: View {
    @State var player = playerinfo(hp: 100, coin: 0, x: 0, y: 0,uraniyums: 0, mapstate: false, glungusandcoinchance: 0)
    var body: some View {
            TabView {
                Tab("maze",systemImage: "gamecontroller.circle"){
                    NavigationStack {
                        ContentView(player: $player)
                    }
                }
                Tab("shop",systemImage: "cart"){
                    Shopview(player: $player)
                }
                Tab("map",systemImage: "map"){
                    NavigationStack {
                        Mapview()
                    }
                }
        }
    }
}
#Preview {
    Tabberview()
}
