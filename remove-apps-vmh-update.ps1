########################################
#   12/13/2022
#   Timothy Turner, Digicorp, inc.
#   Startup Script to Remove Software
#	Version for testing with local group policy output file statically set
########################################
$open_file = "Open File" 
out-file -Append -FilePath C:\IT\remove-apps.log -InputObject $open_file
$installed_apps32 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*  |Select-Object DisplayName,PSChildName, UninstallString
$installed_apps64 = Get-ItemProperty HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*  |Select-Object DisplayName,PSChildName, UninstallString
$installed_apps = $installed_apps32 + $installed_apps64

#$installed_apps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*  |Select-Object DisplayName,PSChildName, UninstallString
$Logfile = "C:\IT\remove-apps.log"
Function LogWrite
{
Param ([string]$logstring)

Add-content $Logfile -value $logstring
}
$match_str = '^Msi.'

$winzipargs = "/x t:\wzipse40.msi /qn"

#THE FOLLOWING STRINGS ARE NOT IN USE AT THIS TIME
# $remove_str = 'MsiExec.exe /quiet /x '
# $quite_args = ' /quiet'
# $remove_args= '/x '

#ARRAY OF APPS THAT YOU WANT TO HAVE REMOVED
$badapps = @(
  '{FADD87FD-83C7-40B4-9180-EA9371C1A348}',   #Open Office
  '{F27DBA46-80E1-4858-9285-19198FFFB43D}',   #GOOGLE EARTH TEST SYSTEM
  '{4EEF2644-700F-46F8-9655-915145248986}',   #PUTTY TEST SYSTEM
  '{2408F291-807B-43A8-9731-61C35F046E1B}',   #ROYAL TS TEST SYSTEM
  '{CD95F661-A5C4-44F5-A6AA-ECDD91C24143}',   #wINZIP TEST SYSTEM
  '{FDB77018-8B16-456D-AAC9-0CFA01A36D92}',   #putty
  '{4748282E-2448-11E8-81BC-53A8D56EE868}',   # GeoGebra Classic
  '{D86F0E67-2C02-4DFF-A46A-6871BA809A51}',   # OpenOffice 4.1.13 
  '{AC76BA86-7AD7-FFFF-7B44-AE1401753200}',   # Adobe Acrobat MUI
  '{9A4EBA01-3CB0-4941-88D0-63CC54279A83}',   #boxcryptor 
  '{767359F7-2B5F-4D4E-B22A-7CE210BCE249}',   # Node.js update
  '{e143ddcf-9377-4de1-bf77-8cff028b1d96}',   # Camtasia 2022
  '{7E265513-8CDA-4631-B696-F40D983F3B07}_is1' 
  '{50229C72-539F-4E65-BEB5-F0491C5074B7}',   # 64 Bit HP CIO Components Installer     
  '{59221905-940E-4B6D-9316-EFCD56952394}',   # Camtasia 2020    
  '{6ADCC315-C91D-4A29-A4EF-A2A27BC82CBC}',   # Boxcryptor       
  '{DE181B35-ACEF-4DB0-86D9-731D5767ABB1}',   # Google Earth Pro  
  '{3257C686-FB94-11E9-A078-000C29C1951D}',   # Foxit PhantomPDF  
  '{C0C2B2B6-3890-48FC-A8F8-60ACC986953D}',   # Node.js
  '{A0397FA8-34ED-4A41-A8C9-30EE0B89C464}',   # Backup and Sync from Google     
  '{739B363A-A8C1-4D32-843D-07603700D19F}',   # iTunes         
  '{B749FD2B-4D1A-43BB-8E7B-713FDBDFEA9B}',   # Camtasia 2019
  '{C0FF714D-B7A7-4A30-B9F7-FA8C206B46C3}',   # Camtasia 2021 
  '{842C327E-0C47-4ECB-8921-7DF4B7D2B0B5}',   # LibreOffice 7.2.7.2 
  '{099218A5-A723-43DC-8DB5-6173656A1E94}',   # Dropbox Update Helper
  '{39EBA97A-668A-4DD6-8BF0-EC4ADC7410A4}',   # LibreOffice 7.0.6.2
  '{4748282E-2448-11E8-81BC-53A8D56EE868}',   # GeoGebra Classic
  '{96FD33BF-A8E3-4E1C-93AF-8CD5DD2817EC}',   # Royal TS
  '{D86F0E67-2C02-4DFF-A46A-6871BA809A51}',   # OpenOffice 4.1.13
  '{DA3490CA-0264-42EC-9301-0ECEC0B1D584}',   # Microsoft Azure CLI
  '{57012794-25b3-4611-b5d2-c4e488530283}',   # Camtasia 2020
  '{d9716ffd-76d1-476b-b102-347db224d132}',   # Camtassia 2021
  'KeePassPasswordSafe2_is1',                 # KeePass Password Safe
  'Mozilla Thunderbird 102.1.2 (x86 en-US)',  # Mozilla Thunderbird
  'Skype_is1',                                # Skype	
  'WinPcapInst'                               #WinPcap 4.1.3
  )
   # Start-Process msiexec.exe -ArgumentList $winzipargs

    Start-Process -FilePath "C:\Windows\SysWOW64\msiexec.exe" -Wait -ArgumentList "/x T:\LibreOffice_7.5.1_Win_x86-64.msi /qn"
    Start-Process -FilePath "msiexec.exe" -Wait -ArgumentList "/x {767359F7-2B5F-4D4E-B22A-7CE210BCE249} /quiet"
    Start-Process -FilePath "msiexec.exe" -Wait -ArgumentList "/x {C0C2B2B6-3890-48FC-A8F8-60ACC986953D} /quiet"
    Start-Process -FilePath "msiexec.exe" -Wait -ArgumentList "/x {59614D31-548E-46E6-AD64-FF6D6E10CF0C} /qn"
    Start-Process -FilePath "C:\Windows\SysWOW64\msiexec.exe" -Wait -ArgumentList "/x C:\IT\LibreOffice_7.5.2_Win_x86-64.msi /qn"


    ################### Remove Firefox ###################
    if(test-path "C:\Program Files\Mozilla Firefox\uninstall\helper.exe")
    { 
      Logwrite "Removing Firefox"
      Start-Process -FilePath "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -Wait -ArgumentList "/s"
    }
   
    ################### Remove Foxit ###################
    If(test-path "C:\Program Files (x86)\Foxit Software\Foxit PDF Reader\unins000.exe" )
    {
      LogWrite "Removing Foxit"
      Start-Process -FilePath "C:\Program Files (x86)\Foxit Software\Foxit PDF Reader\unins000.exe" -Wait -ArgumentList "/VERYSILENT /NORESTART"
    }
    ################### Remove Teamviewer ###################
    Start-Process -FilePath "C:\Program Files (x86)\TeamViewer\uninstall.exe" -Wait -ArgumentList "/VERYSILENT /NORESTART"
    
    ################### Remove SeaMonkey ###################    
    if(test-path "C:\Program Files (x86)\SeaMonkey\uninstall\helper.exe") 
    {
      LogWrite "Removing SeaMonkey"
      start-process -FilePath "C:\Program Files (x86)\SeaMonkey\uninstall\helper.exe" -Wait -ArgumentList "/s"
    } 
    
    ################### Remove Thunderbird ################### 
    if(test-path "C:\Program Files\Mozilla Thunderbird\uninstall\helper.exe")
    {
      LogWrite "Removing Thunderbird"
      start-process -FilePath "C:\Program Files\Mozilla Thunderbird\uninstall\helper.exe" -Wait -ArgumentList "/s"
    }
    ################### Remove Thunderbird 32bit ################### 
    if(test-path "C:\Program Files (x86)\Mozilla Thunderbird\uninstall\helper.exe" )
    {
      LogWrite "Removing Thunderbird 32bit"
      start-process -FilePath "C:\Program Files (x86)\Mozilla Thunderbird\uninstall\helper.exe" -Wait -ArgumentList "/s"
    }
    
    ################### Remove Firefox 32bit ################### 
    if(test-path "C:\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe")
    {
      LogWrite "Removing Firefox 32bit"
      start-process -FilePath "C:\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe" -Wait -ArgumentList "/s"
    }
    ################### Remove Mozilla Maintenance ################### 
    if(test-path "C:\Program Files (x86)\Mozilla Maintenance Service\uninstall.exe")
    {
      LogWrite "Removing Mozilla Maintenance"
      start-process -FilePath "C:\Program Files (x86)\Mozilla Maintenance Service\uninstall.exe" -Wait -argumentlist "/s"
    }
    
    ################### Remove 7zip 32bit ################### 
    if(test-path "C:\Program Files (x86)\7-Zip\uninstall.exe")
    {
      LogWrite "Removing 7zip 32bit"
      start-process -FilePath "C:\Program Files (x86)\7-Zip\uninstall.exe" -Wait -argumentlist "/S"
    }

    ################### Remove 7zip 64bit ################### 
    if(test-path "C:\Program Files\7-Zip\uninstall.exe" )
    {
      LogWrite "Removing 7zip 64bit"
      start-process -FilePath "C:\Program Files\7-Zip\uninstall.exe" -Wait -argumentlist "/S"
    }
    
    ################### Remove CDBurnerXP 64bit ################### 
     if(test-path "C:\Program Files\CDBurnerXP\unins000.exe")
     {
      LogWrite "Removing CDBurnerXP 64bit"
      start-process -FilePath "C:\Program Files\CDBurnerXP\unins000.exe" -Wait -argumentlist "/VERYSILENT /NORESTART"
     }
    
    ################### Remove CDBurnerXP 32bit ################### 
    if(test-path "C:\Program Files (x86)\CDBurnerXP\unins000.exe" )
    {
      LogWrite "Removing CDBurnerXP 32bit"
      start-process -FilePath "C:\Program Files (x86)\CDBurnerXP\unins000.exe" -Wait -argumentlist "/VERYSILENT /NORESTART"
    }
    ################### Remove Pzip 64bit ###################
   if(test-path "C:\Program Files\PeaZip\unins000.exe")
    {
      LogWrite "Removing PZip 64bit"
      start-process -FilePath "C:\Program Files\PeaZip\unins000.exe" -Wait -argumentlist "/VERYSILENT /NORESTART"
    }

    ################### Remove Pzip 32bit ###################
    if(test-path "C:\Program Files\PeaZip\unins000.exe")
    {
      LogWrite "Removing PZip 32bit"
      start-process -FilePath "C:\Program Files (x86)\PeaZip\unins000.exe" -Wait -argumentlist "/VERYSILENT /NORESTART"
    }


    Try{
    foreach( $app in $installed_apps) {
        # CHECKS THE REGISTRY TO VALIDATE THAT YOU CAN REMOVE THE FILE VIA MsiExe.exe COMMAND
        if ($app.PSChildName -in $badapps) {

                if ($app.UninstallString -match $match_str) {
                
                $argumentlist =  "/x", $app.PSChildName , "/quiet /norestart"
                LogWrite "Removing " $app.DisplayName
                write-host "Removing IF: " $app.DisplayName " Command: " $argumentlist
                Start-Process msiexec.exe -Wait -ArgumentList $argumentlist
                # write-host "full command: " $retval
                }
                
               else{
                $app.UninstallString.trim() |Out-String -Stream |Select-String -Pattern '"([^"]*)"' |
                    ForEach-Object {
                    
                    $first, $last = $_.Matches[0].Groups[1..2].Value
                    # write-host $last "," $first
                    $aargs = " /uninstall", "/silent","/s" 
                    LogWrite "Removing " $app.DisplayName
                    write-host "Removing ELSE: " $app.DisplayName "Command: " $first
                    Start-Process -Wait $first -ArgumentList $aargs
                    }
                }
        }
    }
}
Catch {
  out-file -Append -FilePath C:\IT\remove-apps.log -InputObject $_  
}
#}