//
//  EraiRawsParserXML.swift
//  AniLease
//
//  Created by VironIT on 23.08.22.
//

import Foundation

class EraiRawsParserXML: NSObject, XMLParserDelegate {
    
    private var item: [EraiRawsRSS] = []
    private var completion: (([EraiRawsRSS]) -> Void)?
    
    private var elementName = ""
    private var element = ""
    private var title = ""
    private var pubDate = ""
    private var subtitles = ""
    private var category = ""
    
    func getEraiRawsItem (_ url: URL, completion: (([EraiRawsRSS]) -> Void)?) {
        self.completion = completion
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [unowned self](data, response, error)  in
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
            title = ""
            pubDate = ""
            subtitles = ""
            category = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch element {
        case "title": title += string
        case "pubDate": pubDate += string
        case "erai:subtitles": subtitles += string
        case "erai:category": category += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let dateFormatter = DateFormatter()
            // Sun, 21 Aug 2022 09:00:00 +0000
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            let time = dateFormatter.date(from: pubDate) ?? Date()
            let newItem = EraiRawsRSS(title: title, pubDate: time, subtitles: subtitles, category: category)
            item.append(newItem)
        }
    }
}
