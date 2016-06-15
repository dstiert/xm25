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
	
