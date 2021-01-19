# Jayden's Minecraft Modpack
My personal Minecraft modpack. Designed for Technic Launcher integration [(see here)](https://www.technicpack.net/modpack/jaydens-mods.1804633).

[![Build Status](https://travis-ci.com/JLefebvre55/MinecraftModpack.svg?branch=master)](https://travis-ci.com/JLefebvre55/MinecraftModpack)

## Suggestions

To suggest a mod be added, removed, etc., do the following:

1. Create a new branch;
2. Modify `./modpack.json`, adding the **direct link to the JAR** to the "urls" list as an object (e.g. `{ "url" : "https://YOURURL.com/YOURMOD.jar"}`) if it ***IS NOT*** hosted on CurseForge. If it ***IS*** hosted on CurseForge (preferred), add an object to the "curse" list using the following convention: 
    - "projectId" is a string, and is listed on the mod's page;
    - "fileId" is a string, and is the **numerical last portion** of the URL to the specific version file on CurseForge (i.e. for Just Enough Items, I used the version located at ["https://www.curseforge.com/minecraft/mc-mods/jei/files/3040523"](https://www.curseforge.com/minecraft/mc-mods/jei/files/3040523), meaning that "3040523" is my file ID);
    - "name" may *theoretically* be anything, but should stay true to the name of the mod. I sometimes applied a "nested labelling" scheme.
3. Commit changes and pull request to master. Add me as a reviewer, and I'll check it out.

## Mods List

Alphabetical, with supporting mods nested. See [./modpack.json](./modpack.json) for a more detailed list.

- AppleSkin
- Applied Energistics 2 (w/ Extra Cells and JEI integration)
- Biomes O' Plenty
- Buildcraft (w/ Additional Pipes)
- Forestry
- IndustrialCraft 2 Classic
- Iron Backpacks
- Iron Chests
- Just Enough Items
- JourneyMap
- Modular Powersuits
- Railcraft
- RFTools
- Simple Planes
- Thaumcraft (w/ JEI, Tinkers', and AE2 integration)
- Thermal Foundation/Expansion/Dynamics
- Tinkers' Construct
- TreeCapitator
- Wireless Redstone
- Various Other Support Mods (ChickenChunks, CraftTweaker2, EnergyConverters, HWYLA, WAWLA, Spawn Commands, etc.)

## Possible Additions

- ICBM
- IC2, BuildCraft, etc. addon mods
- Weapons mods?
- ...

## OptiFine 1.12.2 Issue

Some may be wondering as to why OptiFine isn't included in this modpack - as it stands, [OptiFine is straight up not having a good time right now](https://github.com/JLefebvre55/MinecraftModpack/issues/1), at least on MacOS (which is what I use). If you want to add it to your own mods folder, be my guest!

## Obligatory Notice

All credit to each mod's respective owner. All licensing in accordance with each respective mod.

## Todo

- ~~Links in mods list~~ Not gonna do that unless someone begs me to. It's a pain.
- [ ] Config files?
- [ ] More buildcraft/thaumcraft/ic2/etc. addon mods?
- [ ] Check that all mods are listed and working
- [ ] Update readme with total mod count
