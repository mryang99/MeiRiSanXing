import Testing; import Foundation
@testable import MeiRiSanXing
@Test func testStartOfDay() {
    let d = Calendar.current.date(from:DateComponents(year:2026,month:6,day:26,hour:14))!
    let s = d.startOfDay; #expect(Calendar.current.component(.hour, from:s)==0)
    #expect(Calendar.current.component(.minute, from:s)==0)
}
@Test func testStartOfWeek() {
    let d = Calendar.current.date(from:DateComponents(year:2026,month:6,day:26))!
    #expect(Calendar.current.component(.day, from:d.startOfWeek)==22)
}
@Test func testStartOfMonth() {
    let d = Calendar.current.date(from:DateComponents(year:2026,month:6,day:26))!
    #expect(Calendar.current.component(.day, from:d.startOfMonth)==1)
}
