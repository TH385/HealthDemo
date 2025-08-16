import SwiftUI
import HealthKit

struct StepView: View {
	var states : States
	@State var showAlert = false
	@State var stepSelect: Double = 15000.0
	var body: some View {
		HStack {
			Picker(selection: $stepSelect) {
				Text("100").tag(100.0)
				Text("500").tag(500.0)
				Text("1000").tag(1000.0)
				Text("5000").tag(5000.0)
				Text("10000").tag(10000.0)
				Text("15000").tag(15000.0)
			} label: {
				Text("steps")
			}
			Button("steps/20mins") {
				let now = Date()
				let ago20min = now.addingTimeInterval(-1 * 20 * 60.0)
				let stepQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: stepSelect);
				let stepSample = HKQuantitySample(//
					type: states.stepType //
					, quantity: stepQuantity //
					, start: ago20min //
					, end: now);
				states.healthStore.save(stepSample) { success, error in
					if(success) {
						showAlert = true
					} else {
						print("save failed \(String(describing: error))")
					}
				}
			}
		}
		.alert("step saved", isPresented: $showAlert) {
			Button("OK", role: .cancel) { }
		}
	}
}

#Preview(traits: .sizeThatFitsLayout) {
	StepView(states:States())
}
