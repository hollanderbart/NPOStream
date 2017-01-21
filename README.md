# NPOStream
Swift framework to get real-time streams of Dutch broadcasting studio (NPO).

# Usage
1. Import framework in Xcode project using Cocoapods ```pod "NPOStream"```
2. Declare: ```import NPOStream``` on top of your swift file
3. Call the NPOStream.getStream function with a ChannelTitle enum case. ChannelTitle is a enum for all available NPO TV channels that NPOStream can provide.

```NPOStream.getStream(ChannelTitle, onCompletion: (URL?, NSError?) -> Void)```

This is the list of the available NPO TV channels:
```
public enum ChannelTitle: String {
    case NPO1 = "NPO 1"
    case NPO2 = "NPO 2"
    case NPO3 = "NPO 3"
    case NPONieuws = "NPO Nieuws"
    case NPOPolitiek = "NPO Politiek"
    case NPOBest = "NPO Best"
    case NPODoc = "NPO Doc"
    case NPO101 = "NPO 101"
    case NPOCultura = "NPO Cultura"
    case NPOZappXtra = "NPO Zapp Xtra"
    case NPOHumor = "NPO Humor TV"
}
```

# Example
```
NPOStream.getStream(ChannelTitle.NPO3) { (url: URL?, error: NSError?) in
  guard let streamURL = url, error == nil else { return }
  self.performSegue(withIdentifier: "player", sender: streamURL)
}
```

Take a look at the Example project for more details..
