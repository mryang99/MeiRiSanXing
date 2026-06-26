import SwiftUI
struct ContentView: View {
    var body: some View {
        TabView {
            MeditationView()
                .tabItem { Label("冥想", systemImage: "sparkles") }
            TaskListView()
                .tabItem { Label("待办", systemImage: "checklist") }
            ReflectionView()
                .tabItem { Label("反思", systemImage: "pencil.and.outline") }
        }
        .tint(Color(red: 0.29, green: 0.56, blue: 0.85))
    }
}
