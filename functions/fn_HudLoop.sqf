#include "..\script_component.hpp"

private ["_player", "_camera", "_radMode", "_setHun", "_setTen", "_setOne", "_angMode", "_angThou", "_angHun", "_angTen", "_angOne", "_dropEst", "_dropAngDeg", "_dropAngRad", "_crossY"];
_player = _this select 0;
_camera = _this select 1;
_radMode = true;

if (currentWeapon _player != "ATA_XM25_F" || cameraView != "GUNNER") exitWith {};

cutRsc ["ATA_XM25display","plain"];
GVAR(active) = true;

[{
    if (currentWeapon _player != "ATA_XM25_F" || cameraView != "GUNNER") exitWith {
        GVAR(active) = false;
		cutText ["","plain"];
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
	
	_setHun = floor(GVAR(detRange) / 100); //100s
	_setTen = floor(GVAR(detRange) / 10 - _setHun * 10); //10s
	_setOne = floor(GVAR(detRange) - 100 * _setHun - 10 * _setTen); //1s
	
	//Calc Angle/reticle drop. observed data set and got quadratic regression and rough
	//translation to screen position as constant.
	if(GVAR(detRange) < 120) then {
		_dropEst = (GVAR(detRange)^2 * 1.208986e-4) - (GVAR(detRange) * 2.188210057e-3) + 0.0145;
	} else {
		if(GVAR(detRange) < 300) then {
			_dropEst = (GVAR(detRange)^2 * 1.6293704e-4) - (GVAR(detRange) * 1.1505025e-2) + 0.536782147;
		} else {
			_dropEst = (GVAR(detRange)^3 * 1.590704103e-7) + (GVAR(detRange)^2 * 5.5154453e-5) + (GVAR(detRange) * 1.2244372e-2) -1.1140626;
		};
	};
	_dropAngDeg = asin (_dropEst / GVAR(detRange));
	_dropAngRad = rad(_dropAngDeg);
	
	_crossY = 0.5 + _dropAngRad * 2.3;  //guess and check
	
	if(GVAR(zoomed)) then {
		//hint "that shit is all zoomed and shit"
		//max = .2000 min = 0.3500
		_crossY = ((_crossY - 0.5) * (0.35 / 0.20) + 0.5);

	};
	
	((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504015) ctrlSetPosition [0.5 - 32/1024, _crossY  - 32/768, 64/1024, 64/768];
	((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504015) ctrlCommit .001;
	((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504024) ctrlSetText "\ATA_XM25\data\ui\lcd_10.paa";
	
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
	
	/*
	if(_lasRange > 99) then {
		((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504011) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_hudHun];
	} else {
		((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504011) ctrlSetText format ["\ATA_XM25\data\ui\lcd_blank.paa",_hudHun];
	};
	*/
	if(GVAR(detRange) > 99) then {
		((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504016) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_setHun];
	} else {
		((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504016) ctrlSetText format ["\ATA_XM25\data\ui\lcd_blank.paa",_setHun];
	};
	//((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504012) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_hudTen];
	//((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504013) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_hudOne];
	((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504017) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_setTen];
	((uiNamespace getVariable "ATA_xm25_HUD") displayCtrl 504018) ctrlSetText format ["\ATA_XM25\data\ui\lcd_%1.paa",_setOne];
	

}, 0, []] call CBA_fnc_addPerFrameHandler;