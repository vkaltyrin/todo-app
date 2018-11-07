import Foundation
import EarlGrey
@testable import TodoApplication

protocol MatcherFactory: class {
    func navigationBar(title: String) -> GREYElementMatcherBlock
    func cell() -> GREYElementMatcherBlock
    func element<T>(subject: T) -> GREYElementMatcherBlock
}

final class MatcherFactoryImpl: MatcherFactory {
    func navigationBar(title: String) -> GREYElementMatcherBlock {
        let descriptionBlock: DescribeToBlock = { (description: Any) -> Void in
            let greyDescription:GREYDescription = description as! GREYDescription
            greyDescription.appendText("Find a navigation bar with preassigned title")
        }
        
        return GREYElementMatcherBlock(
            matchesBlock: { (element) -> Bool in
                if let navigationBar = element as? UINavigationBar {
                    return navigationBar.topItem?.title == title
                } else {
                    return false
                }
            },
            descriptionBlock: descriptionBlock
        )
    }
    
    func cell() -> GREYElementMatcherBlock {
        let descriptionBlock: DescribeToBlock = { (description: Any) -> Void in
            let greyDescription:GREYDescription = description as! GREYDescription
            greyDescription.appendText("Find UITableViewCell element")
        }
        
        return GREYElementMatcherBlock(
            matchesBlock: { (element) -> Bool in
                if let _ = element as? UIKit.UITableViewCell {
                    return true
                } else {
                    return false
                }
        },
            descriptionBlock: descriptionBlock
        )
    }
    
    func element<T>(subject: T) -> GREYElementMatcherBlock {
        let descriptionBlock: DescribeToBlock = { (description: Any) -> Void in
            let greyDescription:GREYDescription = description as! GREYDescription
            greyDescription.appendText("Find \(T.self) element")
        }
        
        return GREYElementMatcherBlock(
            matchesBlock: { (element) -> Bool in
                if let _ = element as? T {
                    return true
                } else {
                    return false
                }
            },
            descriptionBlock: descriptionBlock
        )
    }
}
