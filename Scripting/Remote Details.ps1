## Program similar to ComputerDetails but tries to enter a pssession and calls for details


## GUI must have a search bar and a button to clear and wipe the variables that stores the current computer in-search

## Keep looking for a way to execute without powershell cmd 



Add-Type -AssemblyName System.Windows.Forms 

$FormObject = [System.Windows.Forms.Form]
$LabelOject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]

$MainWindowForm = New-Object $FormObject

$MainWindowForm.ClientSize='400,320'
$MainWindowForm.Text='Remote Computer Details'
$MainWindowForm.BackColor="white"


#Add Label that says "Connect to:"

$computerTextBox = New-Object System.Windows.Forms.TextBox
$computerTextBox.Location = '145,20'#'Position from left app side, Position from top of app bar'
$computerTextBox.Size = '150,26'
$computerTextBox.ReadOnly = $false

$ComputerTextBoxLabel = New-Object $LabelOject
$ComputerTextBoxLabel.Text = "Connect to:"
$ComputerTextBoxLabel.AutoSize = $true 
$ComputerTextBoxLabel.Font = 'Verdana,12'
$ComputerTextBoxLabel.Location = New-Object System.Drawing.Point(15,20)

# Add Status Label and Connection (eg: Connected / Error! Check computer Connection)

$labelStatus = New-Object $LabelOject
$labelStatus.Text = "Status:"
$labelStatus.AutoSize = $true
$labelStatus.Font = 'Verdana,12'
$labelStatus.Location = New-Object System.Drawing.Point(15,50)

$StatusOutput = New-Object $LabelOject
$StatusOutput.Text = ""
$StatusOutput.AutoSize = $true
$StatusOutput.Font = 'Verdana,12'
$StatusOutput.Location = New-Object System.Drawing.Point(140,50)


$NamePrint = $labelTitle, $ComputerNameOutput
#Name Object 


$labelTitle = New-Object $LabelOject
$labelTitle.Text = "Name:"
$labelTitle.AutoSize = $true
$labelTitle.Font = 'Verdana,12'
$labelTitle.Location = New-Object System.Drawing.Point(15,80)

$ComputerNameOutput = New-Object $LabelOject
$ComputerNameOutput.Text = $ComputerName
$ComputerNameOutput.AutoSize = $true
$ComputerNameOutput.Font = 'Verdana,12'
$ComputerNameOutput.Location = New-Object System.Drawing.Point(140,80)

#Model Object 


$labelModel = New-Object $LabelOject
$labelModel.Text = "Model:"
$labelModel.AutoSize = $true
$labelModel.Font = 'Verdana,12'
$labelModel.Location = New-Object System.Drawing.Point(15,110)

$ComputerModelOutput = New-Object $LabelOject
$ComputerModelOutput.Text = ""
$ComputerModelOutput.AutoSize = $true
$ComputerModelOutput.Font = 'Verdana,12'
$ComputerModelOutput.Location = New-Object System.Drawing.Point(140,110)

#Manufacturer Object 


$labelManufacturer = New-Object $LabelOject
$labelManufacturer.Text = "Manufacturer:"
$labelManufacturer.AutoSize = $true
$labelManufacturer.Font = 'Verdana,12'
$labelManufacturer.Location = New-Object System.Drawing.Point(15,140)

$ComputerManufacturerOutput = New-Object $LabelOject
$ComputerManufacturerOutput.Text = ""
$ComputerManufacturerOutput.AutoSize = $true
$ComputerManufacturerOutput.Font = 'Verdana,12'
$ComputerManufacturerOutput.Location = New-Object System.Drawing.Point(140,140)

#Domain Object 

$labelDomain = New-Object $LabelOject
$labelDomain.Text = "Domain:"
$labelDomain.AutoSize = $true
$labelDomain.Font = 'Verdana,12'
$labelDomain.Location = New-Object System.Drawing.Point(15,170)

$ComputerDomainOutput = New-Object $LabelOject
$ComputerDomainOutput.Text = ""
$ComputerDomainOutput.AutoSize = $true
$ComputerDomainOutput.Font = 'Verdana,12'
$ComputerDomainOutput.Location = New-Object System.Drawing.Point(140,170)

# Wifi Mac

$labelWifi = New-Object $LabelOject
$labelWifi.Text = "Wi-Fi Mac:"
$labelWifi.AutoSize = $true
$labelWifi.Font = 'Verdana,12'
$labelWifi.Location = New-Object System.Drawing.Point(15,200)

$ComputerWifiOutput = New-Object $LabelOject
$ComputerWifiOutput.Text = ""
$ComputerWifiOutput.AutoSize = $true
$ComputerWifiOutput.Font = 'Verdana,12'
$ComputerWifiOutput.Location = New-Object System.Drawing.Point(140,200)

# Ethernet Mac 

$labelEthernet = New-Object $LabelOject
$labelEthernet.Text = "Ethernet Mac:"
$labelEthernet.AutoSize = $true
$labelEthernet.Font = 'Verdana,12'
$labelEthernet.Location = New-Object System.Drawing.Point(15,230)

$ComputerEthernetOutput = New-Object $LabelOject
$ComputerEthernetOutput.Text = ""
$ComputerEthernetOutput.AutoSize = $true
$ComputerEthernetOutput.Font = 'Verdana,12'
$ComputerEthernetOutput.Location = New-Object System.Drawing.Point(140,230)


# Make sure to make the proper preparation to make the textbox base of the case below


$SearchButton = New-Object System.Windows.Forms.Button                                                     
$SearchButton.Text = 'Search'
$SearchButton.Location = "60, 270"
$SearchButton.Add_Click({

if (Test-Connection $computerTextBox.Text -Quiet){
$StatusOutput.Text = "Connected"
$Session = New-PSSession -ComputerName $ComputerTextBox.Text


#All done to Make a New-Pssession and exit once it calls for the Command with the Invoke Function

$ComputerNameOutput.Text = Invoke-Command -Session $Session {Hostname}

$ComputerModel = Invoke-Command -Session $Session {Get-WmiObject -Class Win32_ComputerSystem | Select "Model"}
$ComputerModelOutput.Text = $ComputerModel.Model

$ComputerManufacturer = Invoke-Command -Session $Session {Get-WmiObject -Class Win32_ComputerSystem | Select "Manufacturer"}
$ComputerManufacturerOutput.text = $ComputerManufacturer.Manufacturer


$ComputerDomain = Invoke-Command -Session $Session {Get-WmiObject -Class Win32_ComputerSystem | Select "Domain"}
$ComputerDomainOutput.Text = $ComputerDomain.Domain

$WifiMacCheck = ""

try {
$WifiMacCheck = Invoke-Command -Session $Session {Get-NetAdapter -Name "Wi-Fi" -ErrorAction Stop}
$ComputerWifiOutput.Text = $WifiMacCheck.MacAddress
} catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {
$ComputerWifiOutput.Text = "Error! Check Wi-Fi Drivers"
}

$EthernetMac = ""

try {
$EthernetMacCheck = Invoke-Command -Session $Session {Get-NetAdapter -Name "Ethernet" -ErrorAction Stop}
$ComputerEthernetOutput.Text = $EthernetMacCheck.MacAddress
} catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {
$ComputerEthernetOutput.Text = "Error! Check Ethernet Drivers"
}


} else {
    $StatusOutput.Text = "Offline" 
    $ComputerNameOutput.Text = "Error!"
    $ComputerModelOutput.Text = "Error!"
    $ComputerManufacturerOutput.Text = "Error!"
    $ComputerDomainOutput.Text = "Error!"
    $ComputerWifiOutput.Text = "Error!"
    $ComputerEthernetOutput.Text = "Error!"
    } })



$ContentClearButton = New-Object System.Windows.Forms.Button
$ContentClearButton.Text = "Clear"
$ContentClearButton.Location = "160,270"
$ContentClearButton.Add_Click({
$computerTextBox = ""
$StatusOutput.Text = "Input Computer"
$ComputerNameOutput.Text = ""
$ComputerModelOutput.Text = ""
$ComputerManufacturerOutput.Text = ""
$ComputerDomainOutput.Text = ""
$ComputerWifiOutput.Text = ""
$ComputerEthernetOutput.Text = ""
   })

$CloseButton = New-Object System.Windows.Forms.Button
$CloseButton.Text= "Close"
$CloseButton.Location = "260,270"
$CloseButton.Add_Click({
$MainWindowForm.Dispose()
})




$MainWindowForm.Controls.AddRange(@($CloseButton,$ContentClearButton,$SearchButton,$labelStatus, $StatusOutput,$ComputerTextBoxLabel,$computerTextBox,$LabelTitle,$ComputerNameOutput,$labelModel,$ComputerModelOutput,$labelManufacturer,$ComputerManufacturerOutput,$labelDomain,$ComputerDomainOutput,$labelWifi,$ComputerWifiOutput,$labelEthernet,$ComputerEthernetOutput))


#Display the form 
$MainWindowForm.ShowDialog()

#Cleans up the form
$MainWindowForm.Dispose()
