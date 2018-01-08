import Foundation

extension NSDate {
    // https://stackoverflow.com/a/43885031/1747442
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self as Date)
    }
    
    func toDateTime() -> String {
        let dateTimePattern = "h:mm:s a yyyy-MM-dd "
        
        return self.toString(dateFormat: dateTimePattern)
    }
}
