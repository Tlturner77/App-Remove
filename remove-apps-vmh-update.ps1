########################################
#   12/13/2022
#   Timothy Turner, Digicorp, inc.
#   Startup Script to Remove Software
#	Version for testing with local group policy output file statically set
########################################
$open_file = "Open File" 
out-file -Append -FilePath C:\IT\remove-apps.log -InputObject $open_file
$installed_apps = Get-ItemProperty HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*  |Select-Object DisplayName,PSChildName, UninstallString

$match_str = '^Msi.'


#THE FOLLOWING STRINGS ARE NOT IN USE AT THIS TIME
# $remove_str = 'MsiExec.exe /quiet /x '
# $quite_args = ' /quiet'
# $remove_args= '/x '

#ARRAY OF APPS THAT YOU WANT TO HAVE REMOVED
$badapps = @(
  '{FDB77018-8B16-456D-AAC9-0CFA01A36D92}',   #putty
  '{4748282E-2448-11E8-81BC-53A8D56EE868}',   #GeoGebra Classic
  '{D86F0E67-2C02-4DFF-A46A-6871BA809A51}',   #OpenOffice 4.1.13 
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
  '{3C4DF0FD-95CF-4F7B-A816-97CEF616948F}',   # HPE System Management Homepage
  '{57012794-25b3-4611-b5d2-c4e488530283}',   # Camtasia 2020
  '{d9716ffd-76d1-476b-b102-347db224d132}',   # Camtassia 2021
  'KeePassPasswordSafe2_is1',                 # KeePass Password Safe
  'Mozilla Thunderbird 102.1.2 (x86 en-US)',  # Mozilla Thunderbird
  'Skype_is1',                                # Skype	
  'WinPcapInst'                               #WinPcap 4.1.3
  )
    Start-Process -FilePath "C:\Windows\SysWOW64\msiexec.exe" -ArgumentList "/x T:\LibreOffice_7.5.1_Win_x86-64.msi /qn"
	  Start-Process -FilePath "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -ArgumentList "/s"
	  start-process -FilePath "C:\Program Files (x86)\SeaMonkey\uninstall\helper.exe" -ArgumentList "/s"
	  start-process -FilePath "C:\Program Files\SeaMonkey\uninstall\helper.exe" -ArgumentList "/s"
	  start-process -FilePath "C:\Program Files\Mozilla Thunderbird\uninstall\helper.exe" -ArgumentList "/s"
	  start-process -FilePath "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -ArgumentList "/s"
	  start-process -FilePath "C:\Program Files (x86)\Mozilla Maintenance Service\uninstall.exe" -argumentlist "/s"
    start-process -FilePath "C:\Program Files\7-Zip\uninstall.exe" -argumentlist "/S"
    start-process -FilePath "C:\Program Files\CDBurnerXP\unins000.exe" -argumentlist "/VERYSILENT /NORESTART"
    start-process -FilePath "C:\Program Files (x86)\CDBurnerXP\unins000.exe" -argumentlist "/VERYSILENT /NORESTART"

Try{
    foreach( $app in $installed_apps) {
        # CHECKS THE REGISTRY TO VALIDATE THAT YOU CAN REMOVE THE FILE VIA MsiExe.exe COMMAND
        if ($app.PSChildName -in $badapps) {

                if ($app.UninstallString -match $match_str) {
                
                $argumentlist =  "/x", $app.PSChildName , "/qn"
                write-host "Removing IF: " $app.DisplayName " Command: " $argumentlist
                Start-Process msiexec.exe -Wait -ArgumentList $argumentlist
                   # write-host $app.UninstallString
                }
                
               else{
                $app.UninstallString.trim() |Out-String -Stream |Select-String -Pattern '"([^"]*)"' |
                    ForEach-Object {
                    
                    $first, $last = $_.Matches[0].Groups[1..2].Value
                    # write-host $last "," $first
                    $args = " /uninstall", "/silent","/s" 
                    write-host "Removing ELSE: " $app.DisplayName "Command: " $first
                    Start-Process $first -ArgumentList $args
                    }
                }
        }
    }
}
Catch {
  out-file -Append -FilePath C:\IT\remove-apps.log -InputObject $_  
}
#}