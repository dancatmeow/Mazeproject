import SwiftUI
struct wallinfo:Hashable {
    var northWstate: Bool
    var eastWstate: Bool
    var southWstate: Bool
    var westWstate : Bool
}
struct pos:Hashable{
    var x: Int
    var y: Int
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
func walkanim(_ frame: Int) -> Int{
    if frame == 1{
        return 2
    }else{
        return 1
    }
}
func cat( _ frame: Int,  _ x: Int, _ y: Int) -> some View {
    if frame == 1{
        Image("catwalk1")
            .resizable()
            .frame(width: 80, height: 70)
            .position(x: CGFloat(x), y: CGFloat(y))
    }else{
        Image("catwalk2")
            .resizable()
            .frame(width: 100, height: 70)
            .position(x: CGFloat(x), y: CGFloat(y))
    }
}
struct ContentView: View {
    @State var walls = randomwall()
    @State var player = playerinfo(hp: 100, coin: 0, inventory: [], x: 0, y: 0)
    @State var catFrame = 1
    @State var catX = 200
    @State var catY = 250
    @State var catwalking: Bool = true
    @State var savew: [pos: wallinfo] = [:]
    func reset(){
        savew.removeAll()
        player.x = 0
        player.y = 0
        walls = getwalls(x: 0, y: 0)
    }
    func getwalls(x: Int, y: Int) -> wallinfo{
        let pos = pos(x: x, y: y)
        if let savew = savew[pos] {
            return savew
        }else{
            let thisisatemporaryvariableforthenewwallifidontuseitswiftwillcrashout = randomwall()
            savew[pos] = thisisatemporaryvariableforthenewwallifidontuseitswiftwillcrashout
            return thisisatemporaryvariableforthenewwallifidontuseitswiftwillcrashout
        }
    }
    func catWalk(_ direction: String) async {
        for _ in 1...10 {
            catFrame = walkanim(catFrame)
            if direction == "north" {
                catY -= 15
            } else if direction == "south" {
                catY += 15
            } else if direction == "east" {
                catX += 15
            } else if direction == "west" {
                catX -= 15
            }
            try? await Task.sleep(nanoseconds: 50_000_000)
        }
    }
    func catWalktomid(_ direction: String) async {
        if direction == "north" {
            catY += 300
        } else if direction == "south" {
            catY -= 300
        } else if direction == "east" {
            catX -= 300
        } else if direction == "west" {
            catX += 300
        }
        for _ in 1...10 {
            catFrame = walkanim(catFrame)
            if direction == "north" {
                catY -= 15
            } else if direction == "south" {
                catY += 15
            } else if direction == "east" {
                catX += 15
            } else if direction == "west" {
                catX -= 15
            }
            try? await Task.sleep(nanoseconds: 50_000_000)
        }
    }
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button {
                    walls = getwalls(x:player.x,y:player.y)
                } label: {
                    Text("Coords: \(player.x), \(player.y), Coins: \(player.coin)")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                }
            }
        }
        ZStack {
            cat(catFrame,catX,catY)
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
            Button("reset") {
                Task{
                    reset()
                }
            }
            if walls.northWstate {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 150, height: 50)
                    .position(x: 200, y: 50)
                Button {
                    Task{
                        await catWalk("north")
                        walls = getwalls(x: player.x, y: player.y)
                        await catWalktomid("north")
                        player.y += 1
                    }
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
                    Task{
                        await catWalk("west")
                        walls = getwalls(x: player.x, y: player.y)
                        await catWalktomid("west")
                    }
                    player.x -= 1
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
                    Task{
                        await catWalk("east")
                        walls = getwalls(x: player.x, y: player.y)
                        await catWalktomid("east")
                    }
                    player.x += 1
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
                    Task{
                        await catWalk("south")
                        walls = getwalls(x: player.x, y: player.y)
                        await catWalktomid("south")
                    }
                    player.y -= 1
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
#Preview {
    ContentView()
}
