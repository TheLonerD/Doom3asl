state("Doom3", "Steam")
{
    bool isLoading : 0x12BAF5D;
    bool isCutscene : "gamex86.dll", 0x43F408;
}

state("dhewm3", "dhewm3-1.5.0")
{
    bool isLoading : 0x242AEB9;
    bool isCutscene : "base.dll", 0x4FA858;
}

state("dhewm3", "dhewm3-1.5.1")
{
    bool isLoading : 0x59F364;
    bool isCutscene : "base.dll", 0x51D7E0;
}

state("dhewm3", "dhewm3-1.5.2")
{
    bool isLoading : 0x5CB9BC;
    bool isCutscene : "base.dll", 0x51E7B0;
}

state("Doom3BFG", "BFG-Steam-Old")
{
    bool isLoading : 0x4B56D4;
    bool isCutscene : 0xC8EB2C;
}

state("Doom3BFG", "BFG-Steam-New")
{
    bool isLoading : 0x4B77D4;
    bool isCutscene : 0xC90A84;
}

state("Doom3BFG", "BFG-GOG")
{
    bool isLoading : 0x4B56D4;
    bool isCutscene : 0xC8EB2C;
}

state("Doom3BFG", "RBDOOM3-1.1.0-preview3")
{
    bool isLoading : 0x19C4CEC;
    bool isCutscene : 0x1848150;
}

state("RBDoom3BFG", "RBDOOM3-1.1.0-preview3")
{
    bool isLoading : 0x19C4CEC;
    bool isCutscene : 0x1848150;
}

state("Doom3BFG", "RBDOOM3-1.2.0-preview1")
{
    bool isLoading : 0x278CCE1;
    bool isCutscene : 0x249A92C;
}

state("RBDoom3BFG", "RBDOOM3-1.2.0-preview1")
{
    bool isLoading : 0x278CCE1;
    bool isCutscene : 0x249A92C;
}

init
{
    vars.isLoading = false;
    var size = modules.First().ModuleMemorySize;
    switch (size)
    {
        case 38739968: // 3.38 MB (3,549,696 bytes)
            version = "dhewm3-1.5.0";
            break;
        case 42106880: // 13.90 MB (14,598,144 bytes)
            version = "dhewm3-1.5.1";
            break;
        case 42369024: // 14.10 MB (14,789,632 bytes)
            version = "dhewm3-1.5.2";
            break;
        case 30056448: // 6.20 MB (6,510,592 bytes)
            version = "RBDOOM3-1.1.0-preview3";
            break;
        case 44576768: // 7.94 MB (8,332,288 bytes)
            version = "RBDOOM3-1.2.0-preview1";
            break;
        case 15675392: // 5.46 MB (5,727,368 bytes)
            version = "BFG-Steam-Old";
            break;
        case 15130624: // 4.93 MB (5,177,344 bytes)
            version = "BFG-Steam-New";
            break;
        case 15119172: // 4.93 MB (5,176,968 bytes)
            version = "BFG-GOG";
            break;
        case 41897984: // 5.57 MB (5,840,896 bytes)
            version = "Steam";
            break;
        default:
            version = "Unknown";
            print("Unknown DOOM 3 version: " + size);
            break;
    }
}

update
{
    if (version == "Unknown")
    {
        return false;
    }

    vars.isLoading = (current.isLoading && settings["skipLoading"]) || (current.isCutscene && settings["skipCutscenes"]);
}

isLoading
{
    return vars.isLoading;
}

startup
{
    settings.Add("skipLoading", true, "Do not include loading screens in the game time.");
    settings.Add("skipCutscenes", true, "Do not include cutscenes in the game time.");
}
