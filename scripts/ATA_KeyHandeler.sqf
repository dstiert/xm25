if (player getVariable "ATA_XM25Active") then {
	private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt","_handled", "_laseFlag", "_detRange", "_optZoomed", "_targInc"];
	_ctrl = _this select 0;
	_dikCode = _this select 1;
	_shift = _this select 2;
	_ctrlKey = _this select 3;
	_alt = _this select 4;
	  
	//hint format["%1 was pressed... ever so gently", _dikCode];
	_handled = false;
	_laseFlag = player getVariable "ATA_LaserFlag";
	_detRange = player getVariable "ATA_DetRange";
	_trackIndex = player getVariable "ATA_ShotTrackIndex";
	_trackArr = player getVariable "ATA_ShotTrackArr";

	if (_shift) then {
		_targInc = 10.0; //increment of 10 for coarse adjust while holding shift
	} else {
		_targInc = 1.0; //increment of 1 for fine adjust
	};
	switch (_dikCode) do {
		case 38: {
			//L: ranging mode
			_laseFlag = !_laseFlag;
			_handled = true;
		};
		case 201: {
			//pgup detonation range increment up
			_detRange = _detRange + _targInc;
			_handled = true;
		};
		
		case 209: {
			//pgdn detonation range increment down
			_detRange = _detRange - _targInc;
			_handled = true;
		};
		
		case 78: {
			//+ on numpad
			//key handeler didn't work consistently without going via local var for some reason
			_optZoomed = true;  
			player setVariable ["ATA_OptZoomed", _optZoomed];
			_handled = true;
			
		};
		
		case 74: {
			//- on numpad
			_optZoomed = false;
			player setVariable ["ATA_OptZoomed", _optZoomed];
			_handled = true;
		};
		
	};
	player setVariable ["ATA_DetRange", _detRange];
	player setVariable ["ATA_LaserFlag", _laseFlag];
	
	
};
_handled;  //world falls apart without this