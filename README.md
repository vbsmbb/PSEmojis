# PSEmojis
PSEmojis is a PowerShell module to display character emojis. I created this module to be able to execute the _PESTER Quick Start_ tutorial on the _PESTER_ documentation site. THe module contains two functions and a PowerShell data file.

The function, _**Get-Emoji**_, is the main function that is called to get the emoji by name. This function has a default name, _Grinning Face_, so the Name parameter is not a required parameter. However, if you want to display an emoji other than _Grinning Face_, then the Name parameter is required. This parameter can also accept a list of names directly through the pipeline.

The function, _**ConvertTo-Emoji**_, takes in a hex code value through the parameter, HexStr, which is required. This function was created as a helper function to convert the hex code string into an emoji character. It was just part of the Get-Emoji module until it was necessary to create the character emoji as part of the test script.

The file, _**PSEmojiCodes.psd1**_, is a PowerShell data file with a hash table containing emoji names paired with hex codes for the emoji name. This file only contains the emojis required for the _PESTER Quick Start_ tutorial. Of course, any number of emojis can be added as needed or wanted.

The last part of the _PESTER Quick Start_ tutorial was never implemented. This is the section where a type field was added to the output of the Get-Emoji function. It just did not seem to be a necessity so I ignored it.
