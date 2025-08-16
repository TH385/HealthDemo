import SwiftUI
import HealthKit

struct WorkoutView: View {
	var states : States
	@State var showAlert = false
	@State var heartRateSelect: Double = 120.0
	var body: some View {
		HStack{
			Picker(selection: $heartRateSelect) {
				Text("120").tag(120.0)
				Text("130").tag(130.0)
				Text("140").tag(140.0)
			} label: {
				Text("heart rate")
			}
			Button("bpm/30mins") {
				let now = Date()
				let ago30min = now.addingTimeInterval(-1 * 31 * 60.0)
					// workout
				states.configuration.activityType = .walking
				states.configuration.locationType = .indoor
				
				let builder = HKWorkoutBuilder(healthStore: states.healthStore,
											   configuration: states.configuration,
											   device: .local())
				
				builder.beginCollection(withStart: ago30min) { success, error in
					if success {
						print(" begin done ")
					} else {
						print(" begin failed \(String(describing: error)) ")
					}
				}
				let sample = HKQuantitySample( //
					type: HKQuantityType.quantityType(forIdentifier: .heartRate)! //
					, quantity: HKQuantity( //
						unit: .count().unitDivided(by: .minute())
										   , doubleValue: heartRateSelect) //
					, start: ago30min //
					, end: now)
				builder.add([sample]) { success, error in
					if success {
						print(" sample done ")
					} else {
						print(" sample failed \(String(describing: error)) ")
					}
				}
				
				builder.endCollection(withEnd: now) { success, error in
					builder.finishWorkout { workout, error in
						if let _ = workout {
							print("Workout saved:")
						} else {
							print("Error saving workout: \(String(describing: error))")
						}
					}
				}
				let hrvQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: 0.4)
				let hrvSample = HKQuantitySample( //
					type: states.hrvType //
					, quantity: hrvQuantity //
					, start: ago30min //
					, end: now);
				states.healthStore.save(hrvSample) { success, error in
					if(success) {
						showAlert = true
					} else {
						print("hrv failed")
					}
				}
			}
		}
		.alert("workout saved", isPresented: $showAlert) {
			Button("OK", role: .cancel) { }
		}
	}
}

#Preview(traits: .sizeThatFitsLayout) {
	WorkoutView(states: States())
}
