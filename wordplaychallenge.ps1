<#
# Challenge Text
While experienced PowerShell scripters are hopefully tackling their latest challenge, The Chairman didn’t want those of you still in the earlier stages of learning PowerShell to feel left out so he has commissioned a new challenge.

## Beginner Challenge
When you create a string of text in PowerShell, each character can also be represented by its underlying [CHAR] value which actually has an integer value. The value can be turned back into the original string character.

PS C:\> $x = "P"
PS C:\> [char]$x -as [int]
80
PS C:\> [char]80
P

Your challenge is to define a variable with a string of text, like $w=”Iron Scripter”. Write a PowerShell expression that will give you the sum of the integer values for each character in the string. The second part of the challenge is to display the text using its integer values.

74 114 111 110 ...

##Intermediate Challenge
If you have a bit more experience, you should be able to knock out the beginner challenges rather easily. Your challenge is two write 2 PowerShell functions that will accept pipeline input. The first function should take a string of text as input and write a new string that uses the CHAR value doubled. In other words, if the original CHAR value is 111, the new word will use a value of 222. You will definitely get some unusual characters.

The second part of the challenge is to write a function that does the opposite, that is, “decodes” the text. If you’ve done this properly you should be able to decode this:

àÞîÊäæÐÊØØ

And you should be able to “round-trip” your functions:

"Foo 123" | ConvertTo-Foo | ConvertFrom-Foo

and get the original text as the output.

As always, you are encouraged to post a comment with a link to your work. Good luck.

#>

function Sum-CharValues1 {
    param (
        [String]$text = "Iron Scripter"
    )
    # I think the key part here was figuring out how to address the single characters inside the string.

    $sum = 0
    for ($i = 0; $i -lt $text.Length; $i++) {
        $char = [char]$text[$i]
        $sum += ($char -as [int])
    }

    return $sum
}

function Sum-CharValues2 {
    param (
        [String]$text = "Iron Scripter"
    )
    # I tried to avoid the loop and see how it affects performance. This is faster but it's really hard to read, so I stayed with the "slow" version for the next parts.

    $values = $text[0..$text.Length] | ForEach-Object {[char]$_ -as [int]}

    return ($values | Measure-Object -Sum).Sum
}

function List-CharValues {
    param (
        [String]$text = "Iron Scripter"
    )
    # The interesing part here was to output the array in a legible string.

    $values = @()
    for ($i = 0; $i -lt $text.Length; $i++) {
        $char = [char]$text[$i]
        $values += ($char -as [int])
    }

    $valuesString = $values -join " "
    return $valuesString
}

function ConvertTo-Foo {
    param (
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)][String]$text
    )
    # Yeah, learning oppotunity. This is my first function that accepts pipeline input :)

    $fooValues = @()
    for ($i = 0; $i -lt $text.Length; $i++) {
        $char = [char]$text[$i]
        $fooValues += ((($char -as [int])*2) -as [char])
    }

    $fooString = $fooValues -join ""
    return $fooString
}

function ConvertFrom-Foo {
    param (
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)][String]$fooText
    )
    # I renamed the variables to have speaking names, but really this is just ConvertTo-Foo with "/2" instead of "*2"

    $values = @()
    for ($i = 0; $i -lt $fooText.Length; $i++) {
        $char = [char]$fooText[$i]
        $values += ((($char -as [int])/2) -as [char])
    }

    $string = $values -join ""
    return $string
}