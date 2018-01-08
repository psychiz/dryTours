import Foundation

class StationValue {
    // strings are used for what the technicians typed in, values are used for precise math
    var reading: String?
    var value: Double?
    
    init(reading: String?) {
        self.reading = reading
    }
}
