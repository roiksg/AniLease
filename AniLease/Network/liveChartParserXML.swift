//
//  liveChartParserXML.swift
//  AniLease
//
//  Created by VironIT on 22.08.22.
//

import Foundation

class LiveChartParserXML: NSObject, XMLParserDelegate {
    
    private var item: [Item] = []
    private var completion: (([Item]) -> Void)?
    
    private var elementName = ""
    private var element = ""
    private var link = ""
    private var title = ""
    private var pubDate = ""
    private var category = ""
    private var imageURL = ""
    
    func getLiveChartItem (_ url: URL, completion: (([Item]) -> Void)?) {
        self.completion = completion
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
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
            // Sun, 21 Aug 2022 09:00:00 +0000
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            let time = dateFormatter.date(from: pubDate) ?? Date()
            let newItem = Item(link: link, title: title, pubDate: time, category: category, imageURL: imageURL)
            item.append(newItem)
        }
    }
}
