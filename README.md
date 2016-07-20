# NPOStream
iOS Swift framework to get dynamic stream URL of the Dutch TV broadcasting studio NPO.

# Usage
1. Import framework in Xcode project
2. Declare: import NPOStream on top of your swift file
3. Call the getStream function. 
NPOStream.getStream(url: String, onCompletion: (NSURL) -> Void)

Use the following links as parameter for 'url' and the dynamic stream URL will be returned in onCompletion

* "Nederland 1":"http://livestreams.omroep.nl/live/npo/tvlive/ned1/ned1.isml/ned1.m3u8"
* "Nederland 2":"http://livestreams.omroep.nl/live/npo/tvlive/ned2/ned2.isml/ned2.m3u8"
* "Nederland 3":"http://livestreams.omroep.nl/live/npo/tvlive/ned3/ned3.isml/ned3.m3u8"
* "NPO Nieuws":"http://livestreams.omroep.nl/live/npo/thematv/journaal24/journaal24.isml/journaal24.m3u8"
* "NPO Politiek":"http://livestreams.omroep.nl/live/npo/thematv/politiek24/politiek24.isml/politiek24.m3u8"
* "NPO Best":"http://livestreams.omroep.nl/live/npo/thematv/best24/best24.isml/best24.m3u8"
* "NPO Doc":"http://livestreams.omroep.nl/live/npo/thematv/hollanddoc24/hollanddoc24.isml/hollanddoc24.m3u8"
* "NPO 101":"http://livestreams.omroep.nl/live/npo/thematv/101tv/101tv.isml/101tv.m3u8"
* "NPO Cultura":"http://livestreams.omroep.nl/live/npo/thematv/cultura24/cultura24.isml/cultura24.m3u8"
* "NPO Zapp Xtra":"http://livestreams.omroep.nl/live/npo/thematv/zappelin24/zappelin24.isml/zappelin24.m3u8"
* "NPO Humor tv":"http://livestreams.omroep.nl/live/npo/thematv/humor24/humor24.isml/humor24.m3u8"

# Example
```NPOStream.getStream("http://livestreams.omroep.nl/live/npo/tvlive/ned1/ned1.isml/ned1.m3u8") { (stream: URL) in  
print(stream)  
// test stream and perform segue to AV Player View..  
}```
