private ["_shooter", "_ammoType", "_validAmmo", "_proj", "_burstRange", "_shooterPos", "_curRange", "_burstPos"];

/*
//testing---------------------------------
private ["_shooterPosHeight", "_burstPosHeight", "_shooterAng", "_xm25"];
_xm25 = "ATA_XM25_F";
//----------------------------------------
*/

_shooter = _this select 0;
_ammoType = _this select 4;
_proj = _this select 6;
_validAmmo = "ATA_G_25mm_HE";

_burstRange = _shooter getVariable "ATA_DetRange";

if(_burstRange < 20) then {_burstRange = 20};  //safety first!

if !(_ammoType == _validAmmo) exitWith {};

if(_ammoType == _validAmmo) then {
	_shooterPos = getPos _shooter;
	_curRange = 0;
	
	/*
	//testing stuff-----------------------
	_shooterPosHeight = (getPosASL _shooter) select 2;
	_shooterAng = (_shooter weaponDirection _xm25) select 2;  //elevation when shot
	//------------------------------------
	*/
};
	
while {_curRange < _burstRange} do {
	_curRange = ((getPos _proj) distance _shooterPos);
	
	sleep 0.01;
};
	
if(!(isNull _proj)) then {
	_burstPos = getPos _proj;
	
	/*
	//testing stuff--------------------
	_burstPosHeight = (getPosASL _proj) select 2;
	player globalChat format ["shotRng: %1, shotDrop: %2, Elevation: %3", _curRange, _shooterPosHeight - _burstPosHeight, _shooterAng];
	//---------------------------------
	*/
	
	sleep 0.01;
	
	deleteVehicle _proj;
	null = "ATA_B_25MM_HE" createVehicle (_burstPos);
};

