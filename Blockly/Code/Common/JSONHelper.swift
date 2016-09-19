/*
* Copyright 2015 Google Inc. All Rights Reserved.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation

@objc(BKYJSONHelper)
public final class JSONHelper: NSObject {
  // MARK: - Public

  /**
  Convenience method for retrieving a JSON object from a String.

  - Parameter jsonString: The JSON string
  - Returns: Either a Dictionary<String, Any> or Array<Any>
  */
  public static func JSONObjectFromString(_ jsonString: String) throws -> Any {
    guard
      let jsonData =
        jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) else
    {
      throw BlocklyError(.jsonParsing, "Could not convert json to NSData:\n\(jsonString)")
    }

    return try JSONSerialization.jsonObject(
      with: jsonData, options:JSONSerialization.ReadingOptions(rawValue: 0))
  }

  /**
  Convenience method for retrieving a JSON dictionary from a String.

  - Parameter jsonString: A valid JSON string dictionary
  - Returns: The JSON dictionary
  */
  public static func JSONDictionaryFromString(_ jsonString: String) throws
    -> Dictionary<String, Any>
  {
    // Parse jsonString into json dictionary
    guard let json = try JSONObjectFromString(jsonString) as? Dictionary<String, Any> else {
      throw BlocklyError(.jsonInvalidTypecast,
        "Could not convert Any to Dictionary<String, Any>")
    }
    return json
  }

  /**
  Convenience method for retrieving a JSON array from a String.

  - Parameter jsonString: A valid JSON string array
  - Returns: The JSON array
  */
  public static func JSONArrayFromString(_ jsonString: String) throws -> [Any] {
    // Parse jsonString into json array
    guard let json = try JSONObjectFromString(jsonString) as? [Any] else {
      throw BlocklyError(.jsonInvalidTypecast, "Could not convert Any to [Any]")
    }
    return json
  }
}
