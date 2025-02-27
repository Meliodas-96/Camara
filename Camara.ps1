Add-Type -AssemblyName System.Windows.Forms

# Función para desactivar la cámara
function Disable-Camera {
    $device = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*Camera*" }
    if ($device) {
        Disable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
        Write-Output "Cámara desactivada."
    } else {
        Write-Output "Cámara no encontrada."
    }
}

# Función para activar la cámara
function Enable-Camera {
    $device = Get-PnpDevice | Where-Object { $_.FriendlyName -like "*Camera*" }
    if ($device) {
        Enable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
        Write-Output "Cámara activada."
    } else {
        Write-Output "Cámara no encontrada."
    }
}

# Crear la interfaz gráfica
$form = New-Object System.Windows.Forms.Form
$form.Text = "Control de Cámara"
$form.Size = New-Object System.Drawing.Size(400,300)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::LightSteelBlue

# Agregar icono del sistema y quitar confirmación al cerrar
$form.Icon = [System.Drawing.SystemIcons]::Camera
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.ControlBox = $true
$form.MaximizeBox = $false
$form.MinimizeBox = $true

$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Control de Cámara"
$labelTitle.Font = New-Object System.Drawing.Font("Arial",16,[System.Drawing.FontStyle]::Bold)
$labelTitle.AutoSize = $true
$labelTitle.Location = New-Object System.Drawing.Point(120,20)

$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Text = "Estado: Desconocido"
$labelStatus.Font = New-Object System.Drawing.Font("Arial",12)
$labelStatus.AutoSize = $true
$labelStatus.Location = New-Object System.Drawing.Point(50,200)

$buttonDisable = New-Object System.Windows.Forms.Button
$buttonDisable.Text = "Desactivar Cámara"
$buttonDisable.Font = New-Object System.Drawing.Font("Arial",10)
$buttonDisable.Size = New-Object System.Drawing.Size(120,40)
$buttonDisable.Location = New-Object System.Drawing.Point(50,100)
$buttonDisable.BackColor = [System.Drawing.Color]::LightCoral
$buttonDisable.Add_Click({
    Disable-Camera
    $labelStatus.Text = "Estado: Cámara Desactivada"
})

$buttonEnable = New-Object System.Windows.Forms.Button
$buttonEnable.Text = "Activar Cámara"
$buttonEnable.Font = New-Object System.Drawing.Font("Arial",10)
$buttonEnable.Size = New-Object System.Drawing.Size(120,40)
$buttonEnable.Location = New-Object System.Drawing.Point(200,100)
$buttonEnable.BackColor = [System.Drawing.Color]::LightGreen
$buttonEnable.Add_Click({
    Enable-Camera
    $labelStatus.Text = "Estado: Cámara Activada"
})

$form.Controls.Add($labelTitle)
$form.Controls.Add($buttonDisable)
$form.Controls.Add($buttonEnable)
$form.Controls.Add($labelStatus)

# Cambiar ShowDialog por Show para evitar el diálogo de confirmación
$form.Show()
[System.Windows.Forms.Application]::Run($form)