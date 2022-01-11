$EmojiHash = Import-PowerShellDataFile -Path $PSScriptRoot\PSEmojiCodes.psd1

function ConvertTo-Emoji {
<#
    .SYNOPSIS
    Convert the hex character string to an emoji character.
    .DESCRIPTION
    ConvertTo-Emoji function converts the hex character string to an emoji 
    character. This conversion works in PowerShell versions 5.1 and 7.2.1 in 
    the Windows operating systems. The hex values for the characters used 
    were collected from the Emojipedia website. The hex code string(s) is 
    first converted to a decimal value and then to a character to display in 
    the console.
    .PARAMETER HexStr
    HexStr string parameter contains a hexcode string from the UTF-8 encoding 
    for one or more emojis on the Emojipedia website. The parameter is 
    validated and will only allow Hex Code strings of five or more characters 
    to be used in teh function.
    .EXAMPLE
    The hex string, 1F600, is the hex code for the 'Grinning Face' emoji.

    ConvertTo-Emoji -HexStr "1F600"
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)]
        [ValidatePattern("[0-9a-fA-F]{4,5}")]
        [string]$HexStr	
    )

    foreach ($str in $HexStr) {
        $emojicon = [System.Convert]::toInt32($HexStr, 16)
        Write-Verbose "Emojicon: $emojicon"
        $emoji = [System.Char]::ConvertFromUtf32($emojicon)
        Write-Verbose "Emoji: $emoji"
        Write-Output $emoji
    }
}

function Get-Emoji {
<#
    .SYNOPSIS
    Convert the name of an emoji to an emoji character.
    .DESCRIPTION
    The Get-Emoji function accepts emoji names from the command line and 
    converts the names to emoji characters. This function collects the emoji 
    charcters from the function, ConvertTo-Emoji, for the output from this 
    function. If the emoji name for an emoji does not exist in the PowerShell 
    data file, the expression 'Emoji name not found...' will be returned from
    this function. 
    
    The emoji names and hex codes available to this module are contained in the 
    PowerShell data file named: PSEmojiCodes.psd1. More emojis can easily be 
    added to this module by adding the emoji names and hex codes to the 
    PowerShell data file. THe emojis in this data file are the ones needed by 
    the Pester Quick Start tutorial.
    .PARAMETER Name
    The Name parameter is not a required parameter. If the parameter is not 
    supplied the default value of 'Grinning Face' is used. Multiple names can 
    be passed to this parameter on the command line and the emoji character 
    for each value will be output if the emoji exists in the emoji hash data 
    file.
    .EXAMPLE
    Example #1 collect the default emoji character.

    Get-Emoji
    .EXAMPLE
    Example #2 collects the 'cactus' emoji from the emoji hash table.

    Get-Emoji -Name cactus
    .EXAMPLE
    Example #3 collects the emoji characters for the apple and pencil emojis.

    "apple","pencil" | Get-Emoji
    
#>
    [CmdletBinding()]
    param (
        [Parameter(Position=0,
                   ValueFromPipeline=$true)]
        [string[]]$Name = "Grinning Face"
    )

    Begin {
        Write-Verbose "Name contains: $Name"
        Write-Verbose "EmojiHash: $EmojiHash"
    }

    Process {
        foreach ($emojiName in $Name) {
            Write-Verbose "Emoji name: $emojiName"
            $hex = $emojiHash[$emojiName]
            Write-Verbose "Hex code: $hex"
            if ($null -ne $hex) {
                $emoji = ConvertTo-Emoji -HexStr $hex
            } else {
			    $emoji = "Emoji name not found..."
            }
            Write-Output $emoji
        }
    }

    End {}
}

Export-ModuleMember -Function ConvertTo-Emoji, Get-Emoji
Export-ModuleMember -Variable EmojiHash
