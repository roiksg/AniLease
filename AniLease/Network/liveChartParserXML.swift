//
//  liveChartParserXML.swift
//  AniLease
//
//  Created by VironIT on 22.08.22.
//

import Foundation

class LiveChartParserXML: NSObject, XMLParserDelegate {
    
    // MARK:  VAR
    
    private var item: [LiveChartRSS] = []
    private var completion: (([LiveChartRSS]) -> Void)?
    private let strParser = StringParser()
    
    private var elementName = ""
    private var element = ""
    private var link = ""
    private var title = ""
    private var pubDate = ""
    private var category = ""
    private var imageURL = ""
    
    // MARK:  FUNC
    
    func getLiveChartItem (_ url: URL, completion: (([LiveChartRSS]) -> Void)?) {
        self.completion = completion
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [unowned self](data, response, error)  in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                DispatchQueue.main.async {
                    let status = Status.shared
                    status.description = "LiveChartRSS parsing"
                    status.status = httpResponse.statusCode
                    status.status = 0
                }
            }
            
            if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }
        task.resume()
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(item)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName
        if elementName == "item" {
            link = ""
            title = ""
            pubDate = ""
            category = ""
        }
        if elementName == "enclosure" {
            if let imageURL = attributeDict["url"] {
                self.imageURL = imageURL
            }
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch element {
        case "link": link += string
        case "title": title += string
        case "pubDate": pubDate += string
        case "category": category += string
        default: break
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            pubDate.removeLast(7)
            let time = dateFormatter.date(from: pubDate) ?? Date()
            let (titleName, episodes) = strParser.getNameAndEpisod(title)
            let newItem = LiveChartRSS(link: link, title: titleName, pubDate: time, category: category, imageURL: imageURL, episods: episodes)
            item.append(newItem)
        }
    }
}
