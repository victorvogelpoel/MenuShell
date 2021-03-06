function Start-MenuShell
{
    <#
    .Synopsis
        Starts MenuShell, a simple console menu maker
    .Description
        Starts MenuShell, a simple console based menu on top of PowerShell.
    .Example
        Start-MenuShell -Menu @{    
            "(P)erformance" = @{
                "CPU" = { 
                    Get-Counter '\Processor(*)\% Processor Time'  
                } 
                'Disks' = { 
                    Get-Counter '\PhysicalDisk(*)\% Disk Read Time', '\PhysicalDisk(*)\% Disk Write Time', '\PhysicalDisk(*)\% Idle Time', '\PhysicalDisk(*)\% Disk Time' 
                } 
        
            }
            "(D)isks" = @{
                "(%)Free" = { 
                    Get-Counter '\LogicalDisk(*)\% Free Space' 
                } 
            }
            "(R)emoting" = @{
                "Endpoints" =  { 
                    Get-PSSessionConfiguration 
                } 
            }
            "(H)ardware" = @{
                "System (I)nfo" = { 
                    Get-WmiObject Win32_ComputerSystem 
                }
                "(R)AM" = {
                    Get-WmiObject Win32_PhysicalMemory
                }
                "Bios" = {
                    Get-WmiObject Win32_Bios
                } 
            }    
        }
    #>
    param(
    # The Menu.  Keys in the menu are strings, with aliases in paranethesis (for instance, e(x)it)
    # The value can either by a script block, or a hashtable.  
    # If it is a script block, the script will be run when the option is selected.  If it is a hashtable, a new menu will be presented to the user.
    [Parameter(Mandatory=$true,Position=0)]
    [Hashtable]
    $Menu,

    # The name of the menu.
    [Parameter(Position=1)]
    [string]
    $Name,

    # The colors to use for options in the menu.  The option colors are valid at any depth of the menu.
    [Parameter(Position=2)]
    [Hashtable]
    $OptionColor
    )

    process {
        #region Create the menu shell object from the parameters
        $menuShell = New-Object PSObject -Property $PSBoundParameters
        

        
        $menuShell.pstypenames.clear()
        $menuShell.pstypenames.add('MenuShell')
        #endregion Create the menu shell object from the parameters

        # And the formatter does the rest ;-)
        $menuShell

    }
} 
