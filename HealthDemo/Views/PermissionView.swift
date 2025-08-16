import SwiftUI
import HealthKit

struct PermissionView: View {
	var states : States
	@State var showAlert = false
	var body: some View {
		Button("Permission") {
			states.healthStore.requestAuthorization( //
				toShare: [states.hrType //
						  ,states.hrvType //
						  ,states.rhrType //
						  ,states.stepType //
						  ,states.dwrType //
						  ,states.sleepSampleType //
						  ,states.wrktType] //
				, read: [states.hrType //
						 ,states.hrvType //
						 ,states.rhrType //
						 ,states.stepType //
						 ,states.dwrType //
						 ,states.sleepSampleType //
						 ,states.wrktType]) //
			{ success,error in
				if success {
					showAlert = true
				} else {
					print("grant failed \(String(describing: error)) ")
				}
			}
		}
		.alert("granted", isPresented: $showAlert) {
			Button("OK", role: .cancel) { }
		}
    }
}

#Preview(traits: .sizeThatFitsLayout) {
	PermissionView(states:States())
}
