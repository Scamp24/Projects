Add-Type -AssemblyName System.Windows.Forms 

$FormObject = [System.Windows.Forms.Form]
$LabelOject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]

$MainWindowForm = New-Object $FormObject

$MainWindowForm.ClientSize='400,200'
$MainWindowForm.Text='Computer Details'
$MainWindowForm.BackColor="white"

$ComputerName = Hostname
$ComputerModel = Get-WmiObject -Class Win32_ComputerSystem | Select "Model"
$ComputerManufacturer = Get-WmiObject -Class Win32_ComputerSystem | Select "Manufacturer"
$ComputerDomain = Get-WmiObject -Class Win32_ComputerSystem | Select "Domain"

$WifiMac = ""

try {
$WifiMacCheck = Get-NetAdapter -Name "Wi-Fi" -ErrorAction Stop
$WifiMac = $WifiMacCheck.MacAddress
} catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {
$WifiMac = "Error! Check Wi-Fi Drivers"
}

$EthernetMac = ""

try {
$EthernetMacCheck = Get-NetAdapter -Name "Ethernet" -ErrorAction Stop
$EthernetMac = $EthernetMacCheck.MacAddress
} catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException] {
$EthernetMac = "Error! Check Ethernet Drivers"
}


$NamePrint = $labelTitle, $ComputerNameOutput
#Name Object 


$labelTitle = New-Object $LabelOject
$labelTitle.Text = "Name:"
$labelTitle.AutoSize = $true
$labelTitle.Font = 'Verdana,12'
$labelTitle.Location = New-Object System.Drawing.Point(15,10)

$ComputerNameOutput = New-Object $LabelOject
$ComputerNameOutput.Text = $ComputerName
$ComputerNameOutput.AutoSize = $true
$ComputerNameOutput.Font = 'Verdana,12'
$ComputerNameOutput.Location = New-Object System.Drawing.Point(140,10)

#Model Object 


$labelModel = New-Object $LabelOject
$labelModel.Text = "Model:"
$labelModel.AutoSize = $true
$labelModel.Font = 'Verdana,12'
$LabelModel.Location = New-Object System.Drawing.Point(15,40)

$ComputerModelOutput = New-Object $LabelOject
$ComputerModelOutput.Text = $ComputerModel.Model
$ComputerModelOutput.AutoSize = $true
$ComputerModelOutput.Font = 'Verdana,12'
$ComputerModelOutput.Location = New-Object System.Drawing.Point(140,40)

#Manufacturer Object 


$labelManufacturer = New-Object $LabelOject
$labelManufacturer.Text = "Manufacturer:"
$labelManufacturer.AutoSize = $true
$labelManufacturer.Font = 'Verdana,12'
$labelManufacturer.Location = New-Object System.Drawing.Point(15,70)

$ComputerManufacturerOutput = New-Object $LabelOject
$ComputerManufacturerOutput.Text = $ComputerManufacturer.Manufacturer
$ComputerManufacturerOutput.AutoSize = $true
$ComputerManufacturerOutput.Font = 'Verdana,12'
$ComputerManufacturerOutput.Location = New-Object System.Drawing.Point(140,70)

#Domain Object 

$labelDomain = New-Object $LabelOject
$labelDomain.Text = "Domain:"
$labelDomain.AutoSize = $true
$labelDomain.Font = 'Verdana,12'
$labelDomain.Location = New-Object System.Drawing.Point(15,100)

$ComputerDomainOutput = New-Object $LabelOject
$ComputerDomainOutput.Text = $ComputerDomain.Domain
$ComputerDomainOutput.AutoSize = $true
$ComputerDomainOutput.Font = 'Verdana,12'
$ComputerDomainOutput.Location = New-Object System.Drawing.Point(140,100)

# Wifi Mac

$labelWifi = New-Object $LabelOject
$labelWifi.Text = "Wi-Fi Mac:"
$labelWifi.AutoSize = $true
$labelWifi.Font = 'Verdana,12'
$labelWifi.Location = New-Object System.Drawing.Point(15,130)

$ComputerWifiOutput = New-Object $LabelOject
$ComputerWifiOutput.Text = $WifiMac
$ComputerWifiOutput.AutoSize = $true
$ComputerWifiOutput.Font = 'Verdana,12'
$ComputerWifiOutput.Location = New-Object System.Drawing.Point(140,130)

# Ethernet Mac 

$labelEthernet = New-Object $LabelOject
$labelEthernet.Text = "Ethernet Mac:"
$labelEthernet.AutoSize = $true
$labelEthernet.Font = 'Verdana,12'
$labelEthernet.Location = New-Object System.Drawing.Point(15,160)

$ComputerEthernetOutput = New-Object $LabelOject
$ComputerEthernetOutput.Text = $EthernetMac
$ComputerEthernetOutput.AutoSize = $true
$ComputerEthernetOutput.Font = 'Verdana,12'
$ComputerEthernetOutput.Location = New-Object System.Drawing.Point(140,160)


$MainWindowForm.Controls.AddRange(@($LabelTitle,$ComputerNameOutput,$labelModel,$ComputerModelOutput,$labelManufacturer,$ComputerManufacturerOutput,$labelDomain,$ComputerDomainOutput,$labelWifi,$ComputerWifiOutput,$labelEthernet,$ComputerEthernetOutput))



#Display the form 
$MainWindowForm.ShowDialog()

#Cleans up the form
$MainWindowForm.Dispose()
