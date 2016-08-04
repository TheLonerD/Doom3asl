state("Doom3", "Steam")
{
    bool isLoading : 0x12BAF5D;
    bool isCutscene : "gamex86.dll", 0x43F408;
}

state("Doom3BFG", "BFG-Steam")
{
    bool isLoading : 0x4B56D4;
    bool isCutscene : 0xC8EB2C;
}

state("Doom3BFG", "RBDOOM3-preview3")
{
    bool isLoading : 0x19C4CEC;
    bool isCutscene : 0x1848150;
}

state("RBDoom3BFG", "RBDOOM3-preview3")
{
    bool isLoading : 0x19C4CEC;
    bool isCutscene : 0x1848150;
}

init
{
    vars.isLoading = false;
    switch (modules.First().ModuleMemorySize)
    {
        case 30056448: // 6.20 MB (6,510,592 bytes)
            version = "RBDOOM3-preview3";
            break;
        case 15675392: // 5.46 MB (5,727,368 bytes)
            version = "BFG-Steam";
            break;
        case 41897984: // 5.57 MB (5,840,896 bytes)
            version = "Steam";
            break;
        default:
            print("Unknown DOOM 3 version.");
            break;
    }
}

update
{
    if (version == "") return false;
    vars.isLoading = current.isLoading || current.isCutscene;
}

isLoading
{
    return vars.isLoading;
}
