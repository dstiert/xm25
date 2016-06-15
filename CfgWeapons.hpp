
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
		
		class WeaponSlotsInfo {
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