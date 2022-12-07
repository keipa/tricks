$LanguageList = Get-WinUserLanguageList
$LanguageList.Add('en-GB')
Set-WinUserLanguageList $LanguageList -Force
$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-GB'))
Set-WinUserLanguageList $LanguageList -Force


Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
