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
    private let strParser = StringParser()
    
    private var elementName = ""
    private var element = ""
    private var title = ""
    private var pubDate = ""
    private var subtitles = ""
    private var category = ""
    private var episodes = ""
    
    func getEraiRawsItem (_ url: URL, completion: (([EraiRawsRSS]) -> Void)?) {
        self.completion = completion
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [unowned self](data, response, error)  in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                print("MYLOG \(httpResponse.statusCode)")
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
            episodes = ""
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
            pubDate.removeLast(2)
            // Sun, 21 Aug 2022 09:00:00 +0000
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            pubDate.removeLast(7)
            let time = dateFormatter.date(from: pubDate) ?? Date()
            title = title.replacingOccurrences(of: "(V2) ", with: "")
            var newItem = EraiRawsRSS(title: title, pubDate: time, subtitles: subtitles, category: category, episods: strParser.getERAndSPEpisods(title))
            let newTitle = strParser.getNameToEraiRaws(newItem)
            newItem.title = newTitle
//            print("MYLOG: element \(newItem.title)
            item.append(newItem)
        }
    }
}
