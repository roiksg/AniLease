//
//  SubsPleaseparserXML.swift
//  AniLease
//
//  Created by VironIT on 24.08.22.
//

import Foundation

class SubsPleaseParserXML: NSObject, XMLParserDelegate {
    
    private var item: [SubsPleaseRSS] = []
    private var completion: (([SubsPleaseRSS]) -> Void)?
    private let strParser = StringParser()
    
    private var elementName = ""
    private var element = ""
    private var title = ""
    private var pubDate = ""
    private var episodes = ""
    
    func getSubsPleaseItem (_ url: URL, completion: (([SubsPleaseRSS]) -> Void)?) {
        self.completion = completion
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [unowned self](data, response, error)  in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                DispatchQueue.main.async {
                    let status = Status.shared
                    status.description = "SubsPleaseRSS parsing"
                    status.status = httpResponse.statusCode
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
            title = ""
            pubDate = ""
            episodes = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch element {
        case "category": title += string
        case "pubDate": pubDate += string
        case "title": episodes += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let dateFormatter = DateFormatter()
            // Sun, 21 Aug 2022 09:00:00 +0000
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let time = dateFormatter.date(from: pubDate) ?? Date()
            let newItem = SubsPleaseRSS(title: strParser.getNameToSubsPlease(title), pubDate: time, episods: strParser.getERAndSPEpisods(episodes))
            item.append(newItem)
        }
    }
}
