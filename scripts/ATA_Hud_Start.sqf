if(isDedicated) exitWith{};

if (!isNull (player getVariable "ATA_XM25_Setup")) exitWith{};

/*
//just for testing
removeAllWeapons player;
player addMagazines ["ATA_4Rnd_HE_25mm", 6];
player addWeapon "ATA_XM25_F";
*/

player setVariable ["ATA_XM25_Setup", false];
hint format ["Setup XM25 %1", player];

//---------------localSwap-------------------------------
//null = [player] execVM "scripts\ATA_Hud_Loop.sqf";  //when mission folder
null = [player] execVM "ATA_XM25\scripts\ATA_Hud_Loop.sqf";
//ATA_onKeyPress = compile preprocessFile "scripts\ATA_KeyHandeler.sqf"; 
ATA_onKeyPress = compile preprocessFile "\ATA_xm25\scripts\ATA_KeyHandeler.sqf"; 
//-------------------------------------------------------

waitUntil {!(isNull findDisplay 46)};
null = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this Call ATA_onKeyPress"];

null = player addEventHandler ["Fired", {_this execVM "\ATA_xm25\scripts\ATA_XM25_Airburst.sqf"}];




