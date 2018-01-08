import Foundation

class TourStationReading {
    var id: Int?        // set once recorded in database
    var station: Station?
    var stationValue: StationValue?
    var timeOfReading: Date?
    
    init(station: Station?, stationValue: StationValue?, timeOfReading: Date?) {
        self.station = station
        self.stationValue = stationValue
        self.timeOfReading = timeOfReading
    }
}
