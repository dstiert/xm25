#include "\a3\editor_f\Data\Scripts\dikCodes.h"
#include "..\script_component.hpp"

GVAR(zoomed) = false;
GVAR(active) = false;
GVAR(detRange) = 150;
GVAR(rangeCap) = 800;
GVAR(rangeDeck) = 20;

hint "binding";

["XM25 Airburst", "RangeKey", "Toggle Ranging", { call ata_fnc_range }, "", [DIK_L, [false, false, false]]] call cba_fnc_addKeybind;

["XM25 Airburst", "RangeInc", "Increase Range", { [1] call ata_fnc_adjust }, "", [DIK_PGUP, [false, false, false]]] call cba_fnc_addKeybind;

["XM25 Airburst", "RangeDec", "Decrease Range", { [-1] call ata_fnc_adjust }, "", [DIK_PGDN, [false, false, false]]] call cba_fnc_addKeybind;

["XM25 Airburst", "RangeIncCoarse", "Increase Range (Coarse)", { [10] call ata_fnc_adjust }, "", [DIK_PGUP, [true, false, false]]] call cba_fnc_addKeybind;

["XM25 Airburst", "RangeDecCoarse", "Decrease Range (Coarse)", { [-10] call ata_fnc_adjust }, "", [DIK_PGDN, [true, false, false]]] call cba_fnc_addKeybind;

["cameraView", { _this call ata_fnc_hudloop }] call CBA_fnc_addPlayerEventHandler;