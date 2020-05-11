# The challenge says "numbers between 1 and 100" I'm going to assume this is to be read as including 1 and 100.

function Beginner1 {
    # Option 1
    # That should be the standard way, I guess.

    $sum = 0
    for ($i = 1; $i -le 100; $i++) {
        if ($i%2 -eq 0) {
            $sum += $i
        }
    }
    
    return $sum
}

function Beginner2 {
    # Option 2
    # Let's go for something stupid inflexible, just because we can.

    $sum = 0
    $countMe = $true
    for ($i = 1; $i -le 100; $i++) {
        $countMe = !$countMe
        if ($countMe) {
            $sum += $i
        }
    }
    
    return $sum
}

function Beginner3 {
    # Option 3
    # I could obviously just adjust the increment.

    $sum = 0
    for ($i = 0; $i -le 100; $i=$i+2) {
        $sum += $i
    }
    
    return $sum
}

function Beginner4 {
    # Option 4
    # I could approach it from both ends.

    $sum = 0
    for ($i = 0; $i -le 50; $i++) {
        if ($i%2 -eq 0) {
            $j = 100-$i
            if ($j -eq $i) {
                $j = 0
            }
            $sum += ($i+$j)    
        }
    }
    
    return $sum
}

function Intermediate {
    param (
        [Int]$max = 512,
        [Int]$step = 4
    )
    # Just picking up the simple solution and parametrising it.

    $sum = 0
    for ($i = 1; $i -le $max; $i++) {
        if ($i%$step -eq 0) {
            $sum += $i
        }
    }
    
    return $sum
}

function Bonus1 {
    param (
        [Int]$max = 512,
        [ValidateRange(1,10)][Int]$step = 4
    )
    # Validating the input for $step.

    $sum = 0
    for ($i = 1; $i -le $max; $i++) {
        if ($i%$step -eq 0) {
            $sum += $i
        }
    }
    
    return $sum
}

function Bonus2 {
    param (
        [Int]$max = 512,
        [ValidateRange(1,10)][Int]$step = 4
    )
    # Returning a hashtable containing the sum and an array of all matches.

    $sum = 0
    $matches = @()
    for ($i = 1; $i -le $max; $i++) {
        if ($i%$step -eq 0) {
            $sum += $i
            $matches += $i
        }
    }
    
    $result = @{
        "sum" = $sum;
        "matches" = $matches
    }
    return $result
}

function Bonus3 {
    param (
        [Int]$min = 1,    
        [Int]$max = 512,
        [ValidateRange(1,10)][Int]$step = 4
    )
    # Why is this a bonus point? I just parametrised the starting number.

    $sum = 0
    $matches = @()
    for ($i = $min; $i -le $max; $i++) {
        if ($i%$step -eq 0) {
            $sum += $i
            $matches += $i
        }
    }
    
    $result = @{
        "sum" = $sum;
        "matches" = $matches
    }
    return $result
}