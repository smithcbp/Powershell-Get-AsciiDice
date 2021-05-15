<#
.SYNOPSIS
  Displays ASCII art dice
.DESCRIPTION
  Easily create ascii are dice for your powershell games. You can roll them at random, or from a number set. You can change the colors too.
.NOTES
  Author: Chris Smith (smithcbp on github)
.PARAMETER Random
    Rolls the specified amount of dice at random and displays them in ascii art. 
.PARAMETER Numbers
    Display the specified numbers, 1-6 in ascii art.
.PARAMETER color
    Choose the color of your die. Default is white
.EXAMPLE
Get-AsciiDice -Numbers 123456 -color Gray

 ___    ___    ___    ___    ___    ___ 
|   |  |  o|  |o  |  |o o|  |o o|  |o o|
| o |  |   |  | o |  |   |  | o |  |o o|
|   |  |o  |  |  o|  |o o|  |o o|  |o o|
 ---    ---    ---    ---    ---    ---
Get-AsciiDice -Random 3
 ___    ___    ___ 
|  o|  |o o|  |o o|
|   |  | o |  |   |
|o  |  |o o|  |o o|
 ---    ---    --- 
#>

function Get-AsciiDice {
  Param
(
    [parameter(Mandatory=$true,
    ParameterSetName="Random")]
    [int]$Random,
    
    [parameter(Mandatory=$true,
    ParameterSetName="Numbers")]
    $Numbers,

    [parameter(Mandatory=$False)]
    [ValidateSet("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")]
    [String]$DieColor = "White"
  )

  if ($random) {
      $NumberSet = (1..$random | foreach {Get-Random -Maximum 6 -Minimum 1})
      $NumberSet = ($NumberSet -join '').ToString().ToCharArray()
  }
  if ($Numbers) {
      $NumberSet = $Numbers.ToString().ToCharArray()
  }

 $NumberSet | foreach { if ($_ -gt '6'){Write-Error -Message "Only supports digits 1-6" -ErrorAction Stop} }
 if ($($NumberSet.Count) -gt 10){Write-Error -Message "Only supports up to 10 die" -ErrorAction Stop}

  $d = [PSCustomObject]@{
      t1 = '   '
      m1 = ' o '
      b1 = '   '
      t2 = '  o'
      m2 = '   '
      b2 = 'o  '
      t3 = 'o  '
      m3 = ' o '
      b3 = '  o'
      t4 = 'o o'
      m4 = '   '
      b4 = 'o o'
      t5 = 'o o'
      m5 = ' o '
      b5 = 'o o'
      t6 = 'o o'
      m6 = 'o o'
      b6 = 'o o'
      }
  
$DiePicture = foreach ($n in $Numberset){   
  $t = 't' + $n
  $m = 'm' + $n
  $b = 'b' + $n  
  Write-Output " ___ "
  Write-Output "|$($d.$t)|"
  Write-Output "|$($d.$m)|"
  Write-Output "|$($d.$b)|"
  Write-Output " --- "
  }

Write-Host -ForegroundColor $DieColor ($DiePicture[0,5,10,15,20,25,30,35,40,45] -join '  ')
Write-Host -ForegroundColor $DieColor ($DiePicture[1,6,11,16,21,26,31,36,41,46] -join '  ')
Write-Host -ForegroundColor $DieColor ($DiePicture[2,7,12,17,22,27,32,37,42,47] -join '  ')
Write-Host -ForegroundColor $DieColor ($DiePicture[3,8,13,18,23,28,33,38,43,48] -join '  ')
Write-Host -ForegroundColor $DieColor ($DiePicture[4,9,14,19,24,29,34,39,44,49] -join '  ')
}