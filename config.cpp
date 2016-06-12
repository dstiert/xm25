class CfgPatches {
	class ATA_xm25 {
		units[] = {};
		weapons[] = {"ATA_xm25_F"};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_Weapons_F"};
	};
};

class Extended_PostInit_EventHandlers {
	class XM25_PostInit {
		init = "null = execVM '\ATA_xm25\scripts\ATA_Hud_Start.sqf'";
	};
};
	
class CfgAmmo {
	class G_40mm_HE;
	class Grenade;
	class ATA_G_25mm_HE: G_40mm_HE {
		airfriction = -0.001; //twice 556?

		hit = 10;  //40mm 12
		indirecthit = 5;  //40mm 10
		indirecthitrange = 6;  //40mm 4
		model = "\A3\weapons_f\ammo\UGL_slug"; //gonnachange
		typicalspeed = 210;

	
	};
	class ATA_B_25MM_HE: Grenade {  //subbed for round when airbursting
		hit = 10;
		indirecthit = 5;
		indirecthitrange = 6;
		explosionTime = 0.001;
		//explosionEffects = "GrenadeExplosion"; //just gonna mess with it
	};
	
};


class CfgMagazines {
	class CA_Magazine;
	class ATA_4Rnd_HE_25mm: CA_Magazine {
		scope = 2; 
		descriptionShort = "25mm High Explosive Airbursting<br />Rounds: 4<br />Used in: XM-25"; 
		displayName = "25mm 4Rnd XM25 Mag";
		ammo = "ATA_G_25mm_HE"; 
		count = 4; 
		initSpeed = 210; 
		picture = "\ATA_xm25\data\ui\gear_xm25_4rnd.paa";  
	};
};

class Mode_SemiAuto;

class CfgWeapons {
	class Rifle;
	class InventoryItem_Base_F;
	class ATA_XM25_Base: Rifle {
		class WeaponSlotsInfo;
		class ATA_XM25_Single: Mode_SemiAuto {
			recoil = "M240Recoil";
			minRange = 30;
			minRangeProbab = 0.1;
			midRange = 250;
			midRangeProbab = 0.7;
			maxRange = 500;
			maxRangeProbab = 0.05;
			aiRateOfFireDistance = 500;
			sound[] = {"A3\sounds_f\Weapons\grenades\ugl_shot_1", 1, 1, 400};
			ffMagnitude = 0.1;
			ffFrequency = 1;
			ffCount = 1;
		};
		//gun particles
	};
	
	
	class ATA_XM25_F : ATA_XM25_Base {
		reloadAction = "GestureReloadKhaybar";
		handAnim[] = {"OFP2_ManSkeleton","\ATA_xm25\data\anim\ata_xm25handpos.rtm"};
		magazines[] = {"ATA_4Rnd_HE_25mm"}; //flares, smoke
		modes[] = {"ATA_XM25_Single"};
		sound[] = {"A3\sounds_f\Weapons\grenades\ugl_shot_1", 1, 1, 400};
		reloadMagazineSound[] = {"A3\Sounds_F\weapons\Khaybar\reload_khaibar.wav",1.0,1,50};
		drySound[] = {"A3\sounds_f\weapons\Other\dry_1.wav",0.01,1,10};		
		magazineReloadTime = 3;
		reloadTime = 0.5;
		
		modelOptics = "\ATA_xm25\ATA_xm25_ret";
		class OpticsModes
		{
			class optic
			{
				opticsID = 1;
				useModelOptics = 1;
				opticsZoomMax=0.2000;
				opticsZoomMin=0.3500;
				opticsZoomInit=0.3500;
				distanceZoomMax=300;
				distanceZoomMin=300;
 				nFovLimit = 0.2000;
 				discretefov[] = {0.3500,0.2000};
 				discreteInitIndex = 0;	
				memoryPointCamera = "eye";
				cameraDir = "look";
				opticsFlare = 1;
				opticsDisablePeripherialVision = 1;
				
				visionMode[] = {"Normal","NVG"};
				opticsPPEffects[] = {"OpticsCHAbera1","OpticsBlur1"};
			};
		};

 		irLaserPos="laser pos";
 		irLaserEnd="laser dir";
		irDistance=5;
		value = 20;
		canLock = 0;
		autoReload = 0;
		autoAimEnabled = 0;
		dispersion = 0.007;
		aiDispersionCoefY = 6;
		maxLeadSpeed = 15;
		muzzlePos = "usti granatometu";
		muzzleEnd = "konec granatometu";
		cartridgePos = "";
		cartridgeVel = "";

		UiPicture = "\ATA_xm25\data\ui\icon_ata_heab_ca.paa";
		picture = "\ATA_xm25\data\ui\gear_ata_xm25_x.paa";
		scope = 2;
		
		class WeaponSlotsInfo : WeaponSlotsInfo{
			mass = 40;
		};
		
		
		model = "ATA_xm25\ATA_xm25_f.p3d";

		displayName = "XM-25 CDTE";
		class Library{
			libTextDesc = "The XM25 Counter Defilade Target Engagement (CDTE) System, also known as the Punisher and Individual Semiautomatic Air Burst System is an air burst grenade launcher derived from the XM29 OICW.";
		};
		descriptionShort = "Airbursting Grenade Launcher.";
	};
};


// Control types
#define CT_STATIC 0
#define CT_BUTTON 1
#define CT_EDIT 2
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define CT_TOOLBOX 6
#define CT_CHECKBOXES 7
#define CT_PROGRESS 8
#define CT_HTML 9
#define CT_STATIC_SKEW 10
#define CT_ACTIVETEXT 11
#define CT_TREE 12
#define CT_STRUCTURED_TEXT 13
#define CT_CONTEXT_MENU 14
#define CT_CONTROLS_GROUP 15
#define CT_XKEYDESC 40
#define CT_XBUTTON 41
#define CT_XLISTBOX 42
#define CT_XSLIDER 43
#define CT_XCOMBO 44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT 80
#define CT_OBJECT_ZOOM 81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK 98
#define CT_USER 99
#define CT_MAP 100
#define CT_MAP_MAIN 101

// Static styles
#define ST_POS 0x0F
#define ST_HPOS 0x03
#define ST_VPOS 0x0C
#define ST_LEFT 0x00
#define ST_RIGHT 0x01
#define ST_CENTER 0x02
#define ST_DOWN 0x04
#define ST_UP 0x08
#define ST_VCENTER 0x0c
#define ST_TYPE 0xF0
#define ST_SINGLE 0
#define ST_MULTI 16
#define ST_TITLE_BAR 32
#define ST_PICTURE 48
#define ST_FRAME 64
#define ST_BACKGROUND 80
#define ST_GROUP_BOX 96
#define ST_GROUP_BOX2 112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE 144
#define ST_WITH_RECT 160
#define ST_LINE 176

#define FontM "TahomaB"
/*
class Extended_Init_EventHandlers
{
	class AllVehicles // the script will abort if already initialized on the player
	{
		null = "[] execVM ""\ATA_xm25\scripts\ATA_Hud_Start.sqf"";";
	};
};
*/

class LCDDigit {
	type = CT_STATIC;
	idc = -1;
	style = ST_PICTURE;
	x = 0.5;
	y = 0.5;
	w = "12/1024";
	h = "12/768";
	text = "\ATA_XM25\data\ui\lcd_10.paa";
	colorBackground[] = { 0, 0, 0, 0 };
	colorText[] = { 1, 1, 1, 0.7 };
	font = FontM;
	sizeEx = 0;
	waitForLoad = 0;
};

class RscTitles {
	class ATA_XM25display {
		idd = 504000;
		movingEnable = false;
		fadein = 0;
		fadeout = 0;
		duration = 100000;
		name = "XM25 Hud";
		onLoad="uiNamespace setVariable ['ATA_XM25_HUD', _this select 0];";
		controls[] = {
			"LasRngDig1", "LasRngDig2", "LasRngDig3", 
			"SetRngDig1", "SetRngDig2", "SetRngDig3", 
			"AngDig1", "AngDig2", "AngDig3", "AngDig4",
			"LaserDot", "Crosshair", "UnitsAng", "AngDigMin"
		};
		
		class LasRngDig1 : LCDDigit {
			idc = 504011;
			x = 0.49;
			y = 0.46;
		};
		class LasRngDig2 : LCDDigit {
			idc = 504012;
			x = 0.50;
			y = 0.46;
		};
		class LasRngDig3 : LCDDigit {
			idc = 504013;
			x = 0.51;
			y = 0.46;
		};
		class SetRngDig1 : LCDDigit {
			idc = 504016;
			x = 0.80;
			y = 0.51;
		};		
		class SetRngDig2 : LCDDigit {
			idc = 504017;
			x = 0.81;
			y = 0.51;
		};		
		class SetRngDig3 : LCDDigit {
			idc = 504018;
			x = 0.82;
			y = 0.51;
		};
	
		class LaserDot : LCDDigit {
			idc = 504014;
			x = 0.484375;
			y = 0.4791667;
			w = "32/1024";
			h = "32/768";
			text = "\ATA_XM25\data\ui\lcd_dot.paa";
		};
		class Crosshair : LCDDigit {
			x = 0.46875;
			y = 0.500;
			w = "64/1024";
			h = "64/768";
			idc = 504015;
			text = "\ATA_XM25\data\ui\lcd_cross.paa";
		};
		class UnitsAng : LCDDigit {
			x = 0.79;
			y = 0.35;
			w = "48/1024";
			h = "12/768";
			idc = 504019;
			text = "\ATA_XM25\data\ui\lcd_mils.paa";
		};
		class AngDig1 : LCDDigit {
			x = 0.79;
			y = 0.32;
			idc = 504020;
		};
		class AngDig2 : LCDDigit {
			x = 0.80;
			y = 0.32;
			idc = 504021;
		};
		class AngDig3 : LCDDigit {
			x = 0.81;
			y = 0.32;
			idc = 504022;
		};
		class AngDig4 : LCDDigit {
			x = 0.82;
			y = 0.32;
			idc = 504023;
		};
		class AngDigMin : LCDDigit {
			x = 0.78;
			y = 0.32;
			idc = 504024;
			text = "\ATA_XM25\data\ui\lcd_min.paa";
		};
	};
};
	
