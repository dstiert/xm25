#include "..\script_component.hpp"

private ["_shooter", "_ammoType", "_validAmmo", "_proj", "_shooterPos", "_curRange", "_burstPos", "_args"];

_shooter = _this select 0;
_ammoType = _this select 4;
_proj = _this select 6;
_validAmmo = "ATA_G_25mm_HE";

hint format["firing at %1 m", GVAR(detRange)];

if(GVAR(detRange) < 20) then { GVAR(detRange) = 20 };  //safety first!

if !(_ammoType == _validAmmo) exitWith {};

[{
	_args = _this select 0;
	_shooter = _args select 0;
	_proj = _args select 1;
	_shooterPos = getPos _shooter;
	_curRange = ((getPos _proj) distance _shooterPos);
		
	if((_curRange > GVAR(detRange)) && !(isNull _proj)) then {
		_burstPos = getPos _proj;
		
		deleteVehicle _proj;
		null = "ATA_B_25MM_HE" createVehicle (_burstPos);
		[_this select 1] call CBA_fnc_removePerFrameHandler;
	};
}, 0, [_shooter, _proj]] call CBA_fnc_addPerFrameHandler;