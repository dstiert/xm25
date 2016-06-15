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