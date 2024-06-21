<#
.SYNOPSIS
  <Overview of script>
.DESCRIPTION
  <Brief description of script>
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        0.9
  Author:         embreq
  Creation Date:  20.06.2024
  Purpose/Change: Proof of concept
  Todo: Add 423 frontnums to list / Add beautiful export to markdown.

#>

function get-TrainInfos($frontnum, $dbmultiplikator, $RegioCode) {
    # Nur wichtig bei manueller Eingabe der $frontnum
    if ($frontnum.Length -ne $dbmultiplikator.Length) {
        Write-Host "[Error] Die Zahlen müssen die gleiche Länge haben."
        return
    }

    # Ergebnis-Array initialisieren
    $result = @()

        for ($i = 0; $i -lt $frontnum.Length; $i++) {
        $digit1 = [int][string]$frontnum[$i]
        $digit2 = [int][string]$dbmultiplikator[$i]
        $result += $digit1 * $digit2
    }

    # Quersumme berechnen
    $crossSum = 0
    foreach ($value in $result) {
        $crossSum += $value
    }

    # Nächste Zehnerstelle finden und Prüfziffer berechnen
    $nextTen = [Math]::Ceiling($crossSum / 10) * 10
    $checkDigit = $nextTen - $crossSum

    Write-Host "$frontnum | $backnum | https://qr.zugportal.de/u/$RegioCode$frontnum$checkDigit"
}

$RegioCode = "94800" #fixer DB-Wert

# Erstelle Bereich von 430001 bis 430097
for ($num = 430001; $num -le 430097; $num++) {
    $frontnum = $num.ToString()
    $backnum = ($num + 500).ToString()  
    $dbmultiplikator = "121212" #fixer DB-Wert

    get-TrainInfos -frontnum $frontnum -dbmultiplikator $dbmultiplikator -RegioCode $RegioCode
}

# Erstelle Bereich von 430200 bis 430297
for ($num = 430200; $num -le 430297; $num++) {
    $frontnum = $num.ToString()
    $backnum = ($num + 500).ToString()
    $dbmultiplikator = "121212" #fixer DB-Wert

    get-TrainInfos -frontnum $frontnum -dbmultiplikator $dbmultiplikator -RegioCode $RegioCode
}

