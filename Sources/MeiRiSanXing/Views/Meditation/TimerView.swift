import SwiftUI
struct TimerView: View {
    @State private var elapsed = 0; @State private var running = false
    @State private var timer: Timer?; @State private var showSheet = false
    @State private var savedSec = 0
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text(String(format: "%02d:%02d", elapsed/60, elapsed%60))
                .font(.system(size: 72, weight: .thin, design: .monospaced))
                .contentTransition(.numericText())
            Text(running ? "冥想中..." : "准备好开始").font(.title3).foregroundColor(.secondary)
            Spacer()
            HStack(spacing: 40) {
                if running {
                    Button { running=false; timer?.invalidate(); timer=nil }
                        label: { Image(systemName: "pause.circle.fill").font(.system(size: 64)).foregroundColor(.orange) }
                    Button { stop() }
                        label: { Image(systemName: "stop.circle.fill").font(.system(size: 64)).foregroundColor(.red) }
                } else if elapsed > 0 {
                    Button { running=true; startTimer() }
                        label: { Image(systemName: "play.circle.fill").font(.system(size: 64)).foregroundColor(Color(red:0.29,green:0.56,blue:0.85)) }
                    Button { elapsed=0 }
                        label: { Image(systemName: "xmark.circle.fill").font(.system(size: 64)).foregroundColor(.gray) }
                } else {
                    Button { running=true; startTimer() }
                        label: { Image(systemName: "play.circle.fill").font(.system(size: 80)).foregroundColor(Color(red:0.29,green:0.56,blue:0.85)) }
                }
            }
            Spacer()
        }.padding()
        .sheet(isPresented: $showSheet) {
            MeditationResultSheet(duration: (savedSec+59)/60) { notes in
                NotificationCenter.default.post(name:.init("SaveMeditation"), object:nil, userInfo:["d":(savedSec+59)/60,"n":notes])
            }
        }
    }
    func startTimer() { timer = Timer.scheduledTimer(withTimeInterval:1, repeats:true) { _ in elapsed+=1 } }
    func stop() { running=false; timer?.invalidate(); timer=nil; savedSec=elapsed; elapsed=0; showSheet=true }
}
