
import SwiftUI

struct wallinfo:Hashable {
    var northWstate: Bool
    var eastWstate: Bool
    var southWstate: Bool
    var westWstate : Bool
}
func randomwall() -> wallinfo{
    wallinfo(northWstate: Bool.random(), eastWstate: Bool.random(), southWstate: Bool.random(), westWstate: Bool.random())
    //wallinfo(northWstate: true, eastWstate: true, southWstate: true, westWstate: true)
}
struct playerinfo:Hashable {
    var hp: Int
    var coin: Int
    var inventory: [String]
    var x : Int
    var y : Int
}

struct ContentView: View {
    @State var walls = randomwall()
    @State var player = playerinfo(hp: 100, coin: 0, inventory: [], x: 0, y: 0)
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button {
                    walls = randomwall()
                } label: {
                    Text("Coords: \(player.x), \(player.y), Coins: \(player.coin)")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                       
                }
                
            }
            ZStack {
                Rectangle()
                    .frame(width: 404, height: 50)
                    .position(x: 200, y: 50)
                    .zIndex(0)
                Rectangle()
                    .frame(width: 50, height: 404)
                    .position(x: 00, y: 250)
                    .zIndex(0)
                Rectangle()
                    .frame(width: 404, height: 50)
                    .position(x: 200, y: 450)
                    .zIndex(0)
                Rectangle()
                    .frame(width: 50, height: 404)
                    .position(x: 400, y: 250)
                    .zIndex(0)
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 404, height: 90)
                        
                    Rectangle()
                        .fill(.green)
                        .frame(
                            width: 404 * CGFloat(player.hp) / 100,height: 90)
                }
                .frame(width: 400, height: 50)
                .position(x: 200, y: 520)

                if walls.northWstate {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 150, height: 50)
                        .position(x: 200, y: 50)
                    Button {
                        player.y += 1
                        walls = randomwall()
                    } label: {
                        Text("↑")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(-45))
                            .frame(width: 30, height: 30)
                            .background(.blue)
                    }
                    .rotationEffect(.degrees(45))
                    .position(x: 200, y: 600)
                }
                if walls.westWstate {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 50, height: 150)
                        .position(x: 0, y: 250)
                    Button {
                        player.x -= 1
                        walls = randomwall()
                    } label: {
                        Text("↑")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(-135))
                            .frame(width: 30, height: 30)
                            .background(.blue)
                    }
                    .rotationEffect(.degrees(45))
                    .position(x: 175, y: 325+300)
                }else {
                    
                }
                if walls.eastWstate {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 50, height: 150)
                        .position(x: 400, y: 250)
                    Button {
                        player.x += 1
                        walls = randomwall()
                    } label: {
                        Text("↑")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(45))
                            .frame(width: 30, height: 30)
                            .background(.blue)
                    }
                    .rotationEffect(.degrees(45))
                    .position(x: 225, y: 325+300)
                }else{
                    
                }
                if walls.southWstate {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 150, height: 50)
                        .position(x: 200, y: 450)
                    Button {
                        player.y -= 1
                        walls = randomwall()
                    } label: {
                        Text("↑")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(135))
                            .frame(width: 30, height: 30)
                            .background(.blue)
                    }
                    .rotationEffect(.degrees(45))
                    .position(x: 200, y: 350+300)
                }else{
                    
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 500, height: 300)
                    .position(x: 200, y: 700)
                    .zIndex(-1)
                
                    
            }
        }
    }
}

#Preview {
    ContentView()
}
