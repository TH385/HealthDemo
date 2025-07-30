import Foundation
import HealthKit

struct States {
	let healthStore = HKHealthStore()
		// Heart Rates
	let hrType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
	let hrvType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
	let rhrType = HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!
	
		//Steps
	let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
	let dwrType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
	
		//Sleep
	let sleepSampleType = HKCategoryType(.sleepAnalysis)
	let sleepCategory = HKCategoryValueSleepAnalysis.asleepDeep.rawValue
		//workout
	let wrktType = HKQuantityType.workoutType()
	let configuration = HKWorkoutConfiguration()
	
	var types: Set<HKSampleType>? = [ //
		HKQuantityType.quantityType(forIdentifier: .heartRate)! //
		, HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)! //
		, HKQuantityType.quantityType(forIdentifier: .restingHeartRate)! //
		, HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! //
		, HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)! //
		, HKCategoryType(.sleepAnalysis) //
		, HKQuantityType.workoutType() //
	]
}
