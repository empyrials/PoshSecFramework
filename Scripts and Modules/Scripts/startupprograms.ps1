<#
.DESCRIPTION
Lists all of the applications that are set to starup in the \Run
folder of the registry.

AUTHOR
Ben0xA

.PARAMETER showintab
Specifies whether to show the results in a PoshSec Framework Tab.
#>

Param(	
	[Parameter(Mandatory=$false,Position=1)]
	[boolean]$showintab=$True
)
# Begin Script Flow

#Leave this here for things to play nicely!
Import-Module $PSFramework

#Start your code here.
$progs = @()

$hosts = $PSHosts.GetHosts()

if($hosts) {
  foreach($h in $hosts) {
    $progs +=  Get-RemoteRegistryValue $h.Name 3 "Software\Microsoft\Windows\CurrentVersion\Run\"
    $progs +=  Get-RemoteRegistryValue $h.Name 3 "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run\"
  }
  
  if($progs) {
    if($showintab) {
      $PSTab.AddObjectGrid($progs, "Startup Programs")
      Write-Output "Startup Programs Tab Created."
    }
    else {
      $progs | Out-String
    }    
  }
  else {
    Write-Output "Unable to find any startup programs"
  }
}
else {
  Write-Output "Please select the hosts in the Systems tab to scan."
}

#End Script