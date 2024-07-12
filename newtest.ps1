$inputCsvPath = "D:\Support\tf_code\color_srgb.csv"
$outputCsvPath = "D:\Support\tf_code\output.csv"

$columnNameToCheck = "HEX"

$data = Import-Csv -Path $inputCsvPath

$filteredData = $data | Where-Object { $_.$columnNameToCheck -ne "" }

if ($filteredData.Count -gt 0) {
    $filteredData | Export-Csv -Path $outputCsvPath -NoTypeInformation
    Write-Output "Filtered data with non-empty values in '$columnNameToCheck' column saved to $outputCsvPath."
} else {
    Write-Output "No rows found with non-empty values in '$columnNameToCheck' column."
}
