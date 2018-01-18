Add-Type -AssemblyName System.IO.Compression.FileSystem

$url = "http://docs.apprenda.com/sites/default/files/Apprenda-8.2.0.zip"
$output = "C:\Apprenda.zip"
if (!(Test-Path -Path C:\Apprenda)) {
  Write-Output "Downloading Apprenda, please wait..."
  (New-Object System.Net.WebClient).DownloadFile($url, $output)
  Write-Output "Download complete, unzipping Apprenda to C:\Apprenda..."
  [System.IO.Compression.ZipFile]::ExtractToDirectory("C:\Apprenda.zip", "C:\Apprenda")
  Write-Output "Now removing Apprenda zip..."
  Remove-Item "C:\Apprenda.zip"
}
