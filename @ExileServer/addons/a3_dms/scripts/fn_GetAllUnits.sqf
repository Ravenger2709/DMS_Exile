/*
	DMS_fnc_GetAllUnits
	Created by eraser1
	Modified by Ravenger2709

	Usage:
	[
		_unitOrGroupOrArray1,
		_unitOrGroupOrArray2,
		...
		_unitOrGroupOrArrayN
	] call DMS_fnc_GetAllUnits;

	Returns all living units from a given array of groups or objects.
*/

if !(_this isEqualType []) then {
	_this = [_this];
};

private _units = [];
private _footUnits = [];
private _vehicleUnits = [];
private _staticUnits = [];

{
	private _parameter = _x;

	_units append
	(
		switch (typeName _parameter) do
		{
			case "ARRAY":
			{
				_parameter call DMS_fnc_GetAllUnits
			};

			case "OBJECT":
			{
				if (alive _parameter) then {
					if (_parameter isKindOf "LandVehicle" || _parameter isKindOf "Air" || _parameter isKindOf "Ship") then {
						_vehicleUnits append (crew _parameter select {alive _x});
					} else if (_parameter isKindOf "StaticWeapon") then {
						_staticUnits append (crew _parameter select {alive _x});
					} else {
						_footUnits pushBack _parameter;
					};
					[_parameter];
				} else {
					[];
				};
			};

			case "GROUP":
			{
				(units _parameter) select {alive _x};
			};

			default
			{
				diag_log format ["DMS ERROR :: Calling DMS_fnc_GetAllUnits with an invalid parameter: %1 | Type: %2", _parameter, typeName _parameter];
				[]
			};
		}
	);
} forEach _this;

if (DMS_DEBUG) then {
	diag_log format ["GetAllUnits :: Foot units: %1", _footUnits];
	diag_log format ["GetAllUnits :: Vehicle units: %1", _vehicleUnits];
	diag_log format ["GetAllUnits :: Static units: %1", _staticUnits];
	diag_log format ["GetAllUnits :: Total units: %1", _units];
};

_units
