import Foundation

class TourLogic {
    static let startTourThresholdInSeconds: Double = 30 * 60  // 30 minutes
    static let recentToursInHours: Int = -24       // negative for in the past

    // TODO: unit test
    static func canTourBeStarted(tour: Tour) -> Bool {
        var canTourBeStarted = false
        let timeBeforeNow = Date(timeIntervalSinceNow: -startTourThresholdInSeconds)
        let timeAfterNow = Date(timeIntervalSinceNow: startTourThresholdInSeconds)
        
        // TODO: defaulting to now until can get property start time on backend, need for simulating time
        let tourStartTime = (tour.startDate ?? NSDate()) as Date
        
        if timeBeforeNow < tourStartTime && timeAfterNow > tourStartTime {
            canTourBeStarted = true
        }
        
        return canTourBeStarted
    }
    
    static func getRecentTours(tours: [Tour]) -> [Tour] {
        let recentTours = tours.filter { (tour) -> Bool in
            // TODO: defaulting to now until can get property start time on backend, need for simulating time
            let tourDateTime = (tour.startDate ?? NSDate()) as Date
          
            let toursSinceLastTimeframe = Calendar.current.date(byAdding: .hour, value: recentToursInHours, to: Date())!
            
            return tourDateTime as Date > toursSinceLastTimeframe
        }
        
        return recentTours
    }
}
