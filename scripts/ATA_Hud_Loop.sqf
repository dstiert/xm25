_player = _this select 0;
_playerPos = getpos _player;
_lasRange = 0;
_laserActive = false;
private["_hasXM", "_hudHun", "_hudTen", "_hudOne", "_cutOn", "_dropEst", "_dropAngDeg", "_dropAngRad", "_crossY", "_setRange", "_setHun", "_setTen", "_setOne", "_angMode", "_angThou", "_angHun", "_angTen", "_angOne", "_fovPos", "_fovDir", "_optZoomed"];

//*******************change me*****************************
_rangeCap = 800.0;  //max burst set range
_rangeDeck = 20.0;  //min burst set range
_timeStep1 = 5;  //delay for checking if XM-25 in gear (sec)
_timeStep2 = 0.25;  //delay for hud ui update
_radMode = true; //true for radians, false for degrees
//*********************************************************

_xm25s = ["ATA_XM25_F", "ATA_XM25_Sec_F"];
_cutOn = false;
_player setVariable ["ATA_LaserFlag", false];
_player setVariable ["ATA_DetRange", 150];
_player setVariable ["ATA_OptZoomed", false];
_lasRange = 150;
_hudHun = 1;
_hudTen = 5;
_hudOne = 0;
_player setVariable ["ATA_XM25_Setup", true];
_player setVariable ["ATA_XM25Active", false];  //true when holding xm25 with scope up. Disables key Event Handler when false.

sleep 2;
while {player == _player} do {

	_hasXM = false;
	{
		if((vehicle _player) hasWeapon _x) then {_hasXM = true};
	} forEach _xm25s;
	
	while {_hasXM} do {
		//hint format ["checking %1", _player isIRLaserOn (currentWeapon player)]; //gonna have to setup as laser proxy on gun... booooo
	
		_laserActive = player getVariable "ATA_LaserFlag";
		if((currentWeapon _player in _xm25s) && (cameraView == "GUNNER")) then {
			
			if(!_cutOn) then {  //keeps from calling cutrsc more than once
				_player setVariable ["ATA_XM25Active", true]; 
				cutRsc ["ATA_XM25display","plain"];
				sleep 0.001;
				_cutOn = true;
			};
			_setRange = _player getVariable "ATA_DetRange"; //changed by keyhandeler
			_optZoomed = _player getVariable "ATA_OptZoomed"; //changed by keyhandeler
			_playerPos = getpos _player;
			
			//_laserActive = _player isIRLaserOn (currentWeapon player);  //doesn't work without laserpointer class
			//WIP for change to ACC class on model. bound to keyhandeler for now with ATA_LaserFlag.
			
			if(_laserActive) then {
				_lasRange = round (_player distance screenToWorld [0.5,0.5]);
				if (!isnull cursorTarget) then { 
					_lasRange = round (_player distance getpos cursortarget);
				};
			
			
				if(_lasRange < _rangeDeck) then {
					_lasRange = _rangeDeck;
				};

				if(_lasRange > _rangeCap) then {  //clamps allowed range
					_hudHun = "10";  //-1 == "star error paa"
					_hudTen = "10";
					_hudOne = "10";
					_lasRange = _rangeCap;
				} else {  //seperate digits for display
					_hudHun = floor(_lasRange / 100); //100s
					_hudTen = floor(_lasRange / 10 - _hudHun * 10); //10s
					_hudOne = floor(_lasRange - 100 * _hudHun - 10 * _hudTen); //1s
				};
				_setRange = _lasRange;
				
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504024) ctrlSetText "\ATA_XM25\data\ui\lcd_10.paa";
			
			} else {
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504024) ctrlSetText "\ATA_XM25\data\ui\lcd_min.paa";
			};
			
			if(_setRange > _rangeCap) then {_setRange = _rangeCap};
			if(_setRange < _rangeDeck) then {_setRange = _rangeDeck};
			
			_setHun = floor(_setRange / 100); //100s
			_setTen = floor(_setRange / 10 - _setHun * 10); //10s
			_setOne = floor(_setRange - 100 * _setHun - 10 * _setTen); //1s
			
			_player setVariable ["ATA_DetRange", _setRange]; //used and modded by keyhandeler
			
			//Calc Angle/reticle drop. observed data set and got quadratic regression and rough
			//translation to screen position as constant.
			if(_setRange < 120) then {
				_dropEst = (_setRange^2 * 1.208986e-4) - (_setRange * 2.188210057e-3) + 0.0145;
			} else {
				if(_setRange < 300) then {
					_dropEst = (_setRange^2 * 1.6293704e-4) - (_setRange * 1.1505025e-2) + 0.536782147;
				} else {
					_dropEst = (_setRange^3 * 1.590704103e-7) + (_setRange^2 * 5.5154453e-5) + (_setRange * 1.2244372e-2) -1.1140626;
				};
			};
			_dropAngDeg = asin (_dropEst / _setRange);
			_dropAngRad = rad(_dropAngDeg);
			
			_crossY = 0.5 + _dropAngRad * 2.3;  //guess and check
			
			if(_optZoomed) then {
				//hint "that shit is all zoomed and shit"
				//max = .2000 min = 0.3500
				_crossY = ((_crossY - 0.5) * (0.35 / 0.20) + 0.5);

			};
			
			((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504015) ctrlSetPosition [0.5 - 32/1024, _crossY  - 32/768, 64/1024, 64/768];
			((uiNamespace getVariable "ATA_xm25_Hud") displayCtrl 504015) ctrlCommit .001;
			
			if(_radMode) then {  //radians display
				if(_dropAngRad < 0.1) then {
					_dropAngRad = _dropAngRad * 100000;
				} else{
					_dropAngRad = _dropAngRad * 10000;
				};
				_angThou = floor(_dropAngRad / 1000); //tenths
				_angHun = floor(_dropAngRad / 100) - _angThou * 10; //hundredths
				_angTen = floor(_dropAngRad / 10 - _angThou * 100 - _angHun * 10); //thousandths
				_angOne = floor(_dropAngRad - _angThou * 1000 - 100 * _angHun - 10 * _angTen); //ten thousandths
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504020) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angThou];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504021) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angHun];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504022) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angTen];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504023) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angOne];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504019) ctrlSetText format ["\ATA_XM25\data\ui\lcd_mils.paa",_angOne];
				
			} else {  //degrees display
				_dropAngDeg = _dropAngDeg * 1000;
				_angThou = floor(_dropAngDeg / 1000); //ones
				_angHun = floor(_dropAngDeg / 100) - _angThou * 10; //tenths
				_angTen = floor(_dropAngDeg / 10 - _angThou * 100 - _angHun * 10); //hundredths
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504020) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angThou];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504021) ctrlSetText "\ATA_XM25\data\ui\lcd_dec.paa";  //decimal place
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504022) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angHun];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504023) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_angTen];
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504019) ctrlSetText format ["\ATA_XM25\data\ui\lcd_degs.paa",_angOne];
			};
			
			if(_lasRange > 99) then {
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504011) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_hudHun];
			} else {
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504011) ctrlSetText format ["\ATA_XM25\data\ui\lcd_blank.paa",_hudHun];
			};
			if(_setRange > 99) then {
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504016) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_setHun];
			} else {
				((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504016) ctrlSetText format ["\ATA_XM25\data\ui\lcd_blank.paa",_setHun];
			};
			((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504012) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_hudTen];
			((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504013) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_hudOne];
			((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504017) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_setTen];
			((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504018) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_setOne];
			
		} else { //not looking in scope
			if(_cutOn) then {
				cutText ["","plain"];
				_player setVariable ["ATA_XM25Active", false];
				_cutOn = false; 
			};
		};
	
		sleep _timeStep2;
	}; //scope check & ui update loop
	sleep _timeStep1 + random (2);
}; //inv check loop

if (alive player) then // player has teamswitched
{
	//null = [player] execVM "scripts\ATA_Hud_Loop.sqf";  //for local folder
	null = [player] execVM "\ATA_xm25\scripts\ATA_Hud_Loop.sqf";
};