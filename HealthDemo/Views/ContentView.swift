import SwiftUI
import HealthKit

struct ContentView: View {
	var states = States()
	var body: some View {
		VStack {
			Spacer()
			PermissionView(states: states)
			Spacer()
			SleepView(states:states)
			Spacer()
			WorkoutView(states:states)
			Spacer()
			StepView(states:states)
			Spacer()
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
