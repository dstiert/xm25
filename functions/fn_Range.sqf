#include "..\script_component.hpp"

private["_hasXM", "_playerPos", "_xm25s", "_lasRange"];

if (!GVAR(active)) exitWith {};

_playerPos = getpos player;

hint "range";

_xm25s = ["ATA_XM25_F", "ATA_XM25_Sec_F"];

GVAR(detRange) = round (player distance screenToWorld [0.5,0.5]);
if (!isnull cursorTarget) then { 
	GVAR(detRange) = round (player distance getpos cursortarget);
};

if(GVAR(detRange) > GVAR(rangeCap)) then {GVAR(detRange) = GVAR(rangeCap)};
if(GVAR(detRange) < GVAR(rangeDeck)) then {GVAR(detRange) = GVAR(rangeDeck)};