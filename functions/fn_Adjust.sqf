#include "..\script_component.hpp"

private["_delta"];

if (!GVAR(active)) exitWith {};

_delta = _this select 0;
GVAR(detRange) = GVAR(detRange) + _delta;

if(GVAR(detRange) > GVAR(rangeCap)) then {GVAR(detRange) = GVAR(rangeCap)};
if(GVAR(detRange) < GVAR(rangeDeck)) then {GVAR(detRange) = GVAR(rangeDeck)};