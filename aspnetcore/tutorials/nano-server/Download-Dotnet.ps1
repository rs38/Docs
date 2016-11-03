$SourcePath = "https://go.microsoft.com/fwlink/?LinkID=809115"
$DestinationPath = "C:\dotnet"

$EditionId = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'EditionID').EditionId

if (($EditionId -eq "ServerStandardNano") -or
    ($EditionId -eq "ServerDataCenterNano") -or
    ($EditionId -eq "NanoServer") -or
    ($EditionId -eq "ServerTuva")) {

        $SourcePath = "https://go.microsoft.com/fwlink/?LinkID=809115"
          $DestinationPath = "C:\temp\RS"
    $TempPath = [System.IO.Path]::GetTempFileName()+".zip"

    try
    {
      Invoke-WebRequest -URI $SourcePath -OutFile  $TempPath
      if ( (Get-Item $TempPath).length  -gt 10kb) #probably more than a warning page
       {
           Expand-Archive -Path $TempPath -DestinationPath $DestinationPath -Force
       }
           else
       {
            Write-Warning "Archive not okay"
        }

    }
    catch [System.Net.WebException],[System.Exception]
    {
        Write-Warning "something was wrong with the download"
        Write-Error $error[0].Exception

    }

    Remove-Item $TempPath
}
