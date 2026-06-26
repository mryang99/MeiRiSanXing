import SwiftUI; import SwiftData
extension View {
    func card() -> some View {
        self.background(RoundedRectangle(cornerRadius:12).fill(Color(.systemBackground)).shadow(color:.black.opacity(0.04),radius:4,y:1))
    }
}
struct DailyReflectionView: View {
    @Environment(\.modelContext) var ctx
    @State private var reflection: DailyReflection?
    @State private var best = ""; @State private var tomorrow = ""
    @State private var mood: Mood?; @State private var paragraphs = [FreeParagraph(content:"", sortOrder:0)]
    var body: some View {
        ScrollView {
            VStack(spacing:16) {
                VStack(alignment:.leading, spacing:8) {
                    Text("今天情绪").font(.headline)
                    HStack(spacing:12) { ForEach(Mood.allCases, id:\.self) { m in
                        Button { mood=m } label: {
                            Text(["😄","🙂","😐","😔","😰"][Mood.allCases.firstIndex(of:m)!])
                                .font(.title).padding(8)
                                .background(Circle().fill(mood==m ? Color(red:0.29,green:0.56,blue:0.85).opacity(0.2) : .clear))
                        }
                    }}
                }.padding().card()
                VStack(alignment:.leading, spacing:12) {
                    Text("今天最值得记录的一件事").font(.headline)
                    TextEditor(text:$best).frame(minHeight:80).padding(8).background(Color(.systemGray6)).cornerRadius(8)
                }.padding().card()
                VStack(alignment:.leading, spacing:12) {
                    Text("明天最重要的三件事").font(.headline)
                    TextEditor(text:$tomorrow).frame(minHeight:80).padding(8).background(Color(.systemGray6)).cornerRadius(8)
                }.padding().card()
                VStack(alignment:.leading, spacing:8) {
                    HStack { Text("自由笔记").font(.headline); Spacer(); Button("+ 添加") {
                        withAnimation { paragraphs.append(FreeParagraph(content:"", sortOrder:paragraphs.count)) }
                    }.font(.subheadline) }
                    ForEach($paragraphs) { $p in
                        TextEditor(text:$p.content).frame(minHeight:60).padding(8)
                            .background(Color(.systemGray6)).cornerRadius(8)
                    }.onDelete { paragraphs.remove(atOffsets:$0) }
                }.padding().card()
                Button(action:save) {
                    Text("保存今日反思").fontWeight(.semibold).frame(maxWidth:.infinity)
                        .padding().background(Color(red:0.29,green:0.56,blue:0.85)).foregroundColor(.white).cornerRadius(12)
                }.padding(.horizontal)
            }.padding(.vertical)
        }.onAppear(perform:load)
    }
    func load() {
        let start = Date().startOfDay
        if let exist = try? ctx.fetch(FetchDescriptor<DailyReflection>(
            predicate: #Predicate { $0.date >= start && $0.date < start.endOfDay })).first {
            reflection = exist; best = exist.structuredAnswers["today_best"] ?? ""
            tomorrow = exist.structuredAnswers["tomorrow_three"] ?? ""
            mood = exist.moodEnum; paragraphs = exist.freeParagraphs
            if paragraphs.isEmpty { paragraphs = [FreeParagraph(content:"", sortOrder:0)] }
        }
    }
    func save() {
        let r: DailyReflection
        if let exist = reflection { r = exist }
        else { r = DailyReflection(); ctx.insert(r) }
        r.structuredAnswers = ["today_best":best, "tomorrow_three":tomorrow]
        r.moodEnum = mood; r.freeParagraphs = paragraphs.filter{!$0.content.isEmpty}
        try? ctx.save()
    }
}
