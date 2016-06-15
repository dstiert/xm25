class CfgPatches {
	class ATA_xm25 {
		units[] = {};
		weapons[] = {"ATA_xm25_F"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F"};
	};
};

class CfgFunctions
{
	class ATA
	{
		class XM25
		{
			file = "\ATA_xm25\functions";
			class Range {};
			class Adjust {};
			class Fired {};
			class HudLoop {};
		};
	};
};

class Extended_PostInit_EventHandlers {
	class XM25_PostInit {
		init = "null = execVM '\ATA_xm25\scripts\ATA_InitXM25.sqf'";
	};
};

class Extended_FiredBIS_Eventhandlers {
	class CAManBase {
		fired = "_this call ata_fnc_fired";
	};
};

#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgWeapons.hpp"
#include "RscTitles.hpp"