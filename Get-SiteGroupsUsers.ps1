function Get-SiteGroupsUsers {
$SiteUrl = "https://valorbiotechnologyinc.sharepoint.com/sites/Roivant"
$gr = $null
$groupTitle = $null
$user = $null
$report = @()
$grp = $null
$grp = Get-SPOSiteGroup -Site $SiteUrl | Where-Object {$_.Users -notlike "*SharingLinks*"}
foreach ($gr in $grp)
{
   $groupTitle =  $gr.Title 
   $User = Get-SPOSiteGroup -Site $SiteUrl -Group $gr.Title | Select-Object -ExpandProperty Users

   Write-Host $gr.Title -ForegroundColor Yellow
   Write-Host $User
   Write-Host
   
   $obj = New-Object -TypeName PSObject -Property @{
          GroupName = $groupTitle
          Users = $User -join ', '
         }
   $report += $obj
 }   
 $report | select GroupName,Users | epcsv C:\Users\jonathan.valdes\Documents\Results.csv -not
 }