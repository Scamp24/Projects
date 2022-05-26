'*' * 80
"{0,49}" -f "Network Printers Add Tool"
'*' * 80

$connectionRoute = ## Add the Network or Local path for your printer


#Printer Addition locally 
Try{
Add-printer -ConnectionName $connectionRoute
Write-Host "Printer Has been added successfully" -ForegroundColor Yellow
}
Catch{
Write-Host "There was an error, please check the printer connection"
}

#Printer Addition inside a Network

$printer = Read-Host -Prompt "Enter the the Name of the Printer"

Try{
Add-Printer -ConnectionName \\Network\$printer  #Edit the path to where the printer is located
Write-Host "This printer has been added succesfully" -ForegroundColor Yellow
}
catch{
Write-Host  "This printer Couldn't be added, please check the Printer or Network connection"
}


Start-Sleep 180
