# Enlarge only the disposable CI desktop so 200% previews fit on screen.
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

public static class PreviewDisplay {
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct DevMode {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string DeviceName;
        public ushort SpecVersion, DriverVersion, Size, DriverExtra;
        public uint Fields;
        public int PositionX, PositionY;
        public uint DisplayOrientation, DisplayFixedOutput;
        public short Color, Duplex, YResolution, TTOption, Collate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string FormName;
        public ushort LogPixels;
        public uint BitsPerPel, PelsWidth, PelsHeight, DisplayFlags, DisplayFrequency;
        public uint ICMMethod, ICMIntent, MediaType, DitherType, Reserved1, Reserved2;
        public uint PanningWidth, PanningHeight;
    }
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    public static extern bool EnumDisplaySettings(string device, int index, ref DevMode mode);
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    public static extern int ChangeDisplaySettings(ref DevMode mode, uint flags);
}
'@

$best = $null
for ($index = 0; ; $index++) {
    $mode = [PreviewDisplay+DevMode]::new()
    $mode.Size = [Runtime.InteropServices.Marshal]::SizeOf([type][PreviewDisplay+DevMode])
    if (-not [PreviewDisplay]::EnumDisplaySettings($null, $index, [ref]$mode)) { break }
    if ($mode.PelsWidth -ge 1600 -and $mode.PelsHeight -ge 1080 -and $mode.BitsPerPel -ge 32) {
        if ($null -eq $best -or ($mode.PelsWidth * $mode.PelsHeight) -lt ($best.PelsWidth * $best.PelsHeight)) {
            $best = $mode
        }
    }
}
if ($null -ne $best) {
    $result = [PreviewDisplay]::ChangeDisplaySettings([ref]$best, 0)
    Write-Host "Preview display change: $result ($($best.PelsWidth)x$($best.PelsHeight))"
} else {
    Write-Warning 'No large display mode is available; high-DPI previews may be cropped.'
}
