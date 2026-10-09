import SwiftUI

struct Settingsview: View {
    @Binding var player: playerinfo
    @State var darkmode:Bool = false
    var body: some View {
        VStack{
            Text("coming soon")
        }
    }
}

#Preview {
    Settingsview(player: .constant(playerinfo(hp: 100, coin: 0, x: 0, y: 0, uraniyums: 0,mapstate: false, glungusandcoinchance: 0,hammer: 0)))
}
