$LanguageList = Get-WinUserLanguageList

if ($LanguageList.LanguageTag -contains 'en-GB') {
  $LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-GB'))
  Set-WinUserLanguageList $LanguageList -Force
}
