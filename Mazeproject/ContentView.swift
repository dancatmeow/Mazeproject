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
@ViewBuilder
func showcoin(coinstate: Bool) -> some View{
    if coinstate{
        Image("coin")
            .resizable()
            .frame(width: 64, height: 64)
            .position(x: 200, y: 250)
    } else {
        EmptyView()
    }
}
@ViewBuilder
func showglungus(glungusstate: Bool) -> some View{
    if glungusstate{
        Image("glungus")
            .resizable()
            .frame(width: 64, height: 64)
            .position(x: 200, y: 250)
    } else {
        EmptyView()
    }
}
func coinstate() -> Bool{
    if Int.random(in: 1...4) == 1{
        return true
    }else {
        return false
    }
}
func glungusstate() -> Bool{
    if Int.random(in: 1...5) == 1{
        return true
    }else {
        return false
    }
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
            .frame(width: 128, height: 128)
            .position(x: CGFloat(x), y: CGFloat(y))
            .zIndex(2)
    }else{
        Image("catwalk2")
            .resizable()
            .frame(width: 128, height: 128)
            .position(x: CGFloat(x), y: CGFloat(y))
            .zIndex(2)
    }
}
struct ContentView: View {
    @State var walls = randomwall()
   @Binding var player: playerinfo
    @State var catFrame = 1
    @State var catX = 200
    @State var catY = 250
    @State var catwalking: Bool = true
    @State var coinstate: Bool = false
    @State var glungusstate: Bool = false
    @State var savew: [pos: wallinfo] = [:]
    @State var savec: [pos: Bool] = [:]
    @State var saveg: [pos: Bool] = [:]
    @State var moving = false
    @State var showAlert = false
    func reset(){
        savew.removeAll()
        savec.removeAll()
        saveg.removeAll()
        player.hp = 100
        player.x = 0
        player.y = 0
        player.coin = 0
        walls = getwalls(x: 0, y: 0)
    }
    func getwalls(x: Int, y: Int) -> wallinfo {
        let position = pos(x: x, y: y)
        if let saved = savew[position] {
            return saved
        }
        var newWalls = randomwall()
        if let north = savew[pos(x: x, y: y + 1)] {
            newWalls.northWstate = north.southWstate
        }
        if let south = savew[pos(x: x, y: y - 1)] {
            newWalls.southWstate = south.northWstate
        }
        if let east = savew[pos(x: x + 1, y: y)] {
            newWalls.eastWstate = east.westWstate
        }
        if let west = savew[pos(x: x - 1, y: y)] {
            newWalls.westWstate = west.eastWstate
        }
        savew[position] = newWalls
        return newWalls
    }
    func getcoin(x: Int, y: Int) -> Bool {
        let position = pos(x: x, y: y)
        if let saved = savec[position] {
            return saved
        }
        let coin = Mazeproject.coinstate()
        savec[position] = coin
        return coin
    }
    func getglungus(x: Int, y: Int) -> Bool {
        let position = pos(x: x, y: y)
        if let saved = saveg[position] {
            return saved
        }
        if getcoin(x: x, y: y) {
            saveg[position] = false
            return false
        }
        let glungus = Mazeproject.glungusstate()
        saveg[position] = glungus
        return glungus
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
            try? await Task.sleep(nanoseconds: 90_000_000)
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
            try? await Task.sleep(nanoseconds: 90_000_000)
        }
    }

    var body: some View {
        NavigationStack {
            
            
            VStack {
                HStack(spacing: 0) {
                    Button {
                        reset()
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
                showcoin(coinstate:coinstate)
                showglungus(glungusstate:glungusstate)
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
                        if moving {
                            return
                        }
                        moving = true
                        Task{
                            savew[pos(x: player.x, y: player.y)] = walls
                            await catWalk("north")
                            player.y += 1
                            walls = getwalls(x: player.x, y: player.y)
                            coinstate = getcoin(x: player.x, y: player.y)
                            glungusstate = getglungus(x: player.x, y: player.y)
                            await catWalktomid("north")
                            if coinstate == true {
                                player.coin += 1
                                savec[pos(x: player.x, y: player.y)] = false
                            }
                            if glungusstate == true {
                                player.hp -= 20
                                saveg[pos(x: player.x, y: player.y)] = false
                            }
                            glungusstate = false
                            coinstate = false
                            moving = false
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
                        if moving {
                            return
                        }
                        moving = true
                        Task{
                            savew[pos(x: player.x, y: player.y)] = walls
                            await catWalk("west")
                            player.x -= 1
                            walls = getwalls(x: player.x, y: player.y)
                            coinstate = getcoin(x: player.x, y: player.y)
                            glungusstate = getglungus(x: player.x, y: player.y)
                            await catWalktomid("west")
                            if coinstate == true {
                                player.coin += 1
                                savec[pos(x: player.x, y: player.y)] = false
                            }
                            if glungusstate == true {
                                player.hp -= 20
                                saveg[pos(x: player.x, y: player.y)] = false
                            }
                            glungusstate = false
                            coinstate = false
                            moving = false
                        }
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
                        if moving {
                            return
                        }
                        moving = true
                        Task{
                            savew[pos(x: player.x, y: player.y)] = walls
                            await catWalk("east")
                            player.x += 1
                            walls = getwalls(x: player.x, y: player.y)
                            coinstate = getcoin(x: player.x, y: player.y)
                            glungusstate = getglungus(x: player.x, y: player.y)
                            await catWalktomid("east")
                            if coinstate == true {
                                player.coin += 1
                                savec[pos(x: player.x, y: player.y)] = false
                            }
                            if glungusstate == true {
                                player.hp -= 20
                                saveg[pos(x: player.x, y: player.y)] = false
                            }
                            glungusstate = false
                            coinstate = false
                            moving = false
                        }
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
                }
                if !walls.northWstate && !walls.southWstate && !walls.eastWstate && !walls.westWstate{
                    Button {
                        reset()
                    } label: {
                        Text("oh no you are stuck! \n click here to reset")
                    }
                }
                if walls.southWstate {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 150, height: 50)
                        .position(x: 200, y: 450)
                    Button {
                        if moving {
                            return
                        }
                        moving = true
                        Task{
                            savew[pos(x: player.x, y: player.y)] = walls
                            await catWalk("south")
                            player.y -= 1
                            walls = getwalls(x: player.x, y: player.y)
                            coinstate = getcoin(x: player.x, y: player.y)
                            glungusstate = getglungus(x: player.x, y: player.y)
                            await catWalktomid("south")
                            if coinstate == true {
                                player.coin += 1
                                savec[pos(x: player.x, y: player.y)] = false
                            }
                            if glungusstate == true {
                                player.hp -= 20
                                saveg[pos(x: player.x, y: player.y)] = false
                            }
                            glungusstate = false
                            coinstate = false
                            moving = false
                        }
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
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 500, height: 300)
                    .position(x: 200, y: 700)
                    .zIndex(-1)
            }
            .onChange(of: player.hp) {
                if player.hp <= 0 {
                    showAlert = true
                }
            }
            .alert("you died", isPresented: $showAlert) {
                Button("restart") {
                    reset()
                }
            }
        }
    }
}

#Preview {
    ContentView(player: .constant(playerinfo(hp: 100, coin: 0, inventory: [], x: 0, y: 0)))
}
