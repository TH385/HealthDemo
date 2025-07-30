import SwiftUI
import HealthKit

struct SleepView: View {
	var states : States
	@State var showAlert = false
	@State var sleepSelect: Double = 8.1
	var body: some View {
		HStack {
			Picker(selection: $sleepSelect) {
				Text("6.1").tag(6.1)
				Text("6.5").tag(6.5)
				Text("7.1").tag(7.1)
				Text("7.5").tag(7.5)
				Text("8.1").tag(8.1)
				Text("8.2").tag(8.2)
				Text("8.3").tag(8.3)
				Text("8.4").tag(8.4)
				Text("8.5").tag(8.5)
				Text("8.6").tag(8.6)
				Text("8.7").tag(8.7)
				Text("8.8").tag(8.8)
			} label: {
				Text("sleep")
			}
			Button("hours sleep") {
				let now = Date()
				let startTime = now.addingTimeInterval(-1 * sleepSelect * 60 * 60)
				let deepSleepSample  = HKCategorySample(type: HKCategoryType(.sleepAnalysis),
														value:HKCategoryValueSleepAnalysis.asleepDeep.rawValue,
														start: startTime,
														end: now)
				states.healthStore.save(deepSleepSample) { success, error in
					if(success) {
						showAlert = true
					} else {
						print("save failed \(String(describing: error)) ")
					}
				}
			}
		}
		.alert("sleep saved", isPresented: $showAlert) {
			Button("OK", role: .cancel) {
				print("")
			}
		}
	}
}

#Preview {
	SleepView(states:States())
}
