/*
    DMS_fnc_TargetsKilledPercent
    Created by Ravenger2709

    Usage:
    [
        _initialUnitCount,
        _unit,
        _group,
        _object
    ] call DMS_fnc_TargetsKilledPercent;

    Will accept non-array argument of group, unit, or object.
*/

if (_this isEqualTo []) exitWith {
    diag_log "DMS ERROR :: Calling DMS_TargetsKilled with empty array!";
};

private _initialUnitCount = _this select 0;
private _args = _this select [1, count _this - 1];
private _killedpercent = false;

// Get the kill percent value from config
private _killPercent = DMS_AI_KillPercent;
//diag_log format ["DMS DEBUG :: Kill percent value: %1", _killPercent];
//diag_log format ["DMS DEBUG :: Initial unit count: %1", _initialUnitCount];

// Calculate the acceptable number of killed units based on initial unit count
private _unitsThreshold = ceil(_killPercent * _initialUnitCount / 100);
//diag_log format ["DMS DEBUG :: Units threshold (killed units): %1", _unitsThreshold];

// Get all living AI units
private _allUnits = _args call DMS_fnc_GetAllUnits;
private _totalUnits = count _allUnits;
//diag_log format ["DMS DEBUG :: Total living units: %1", _totalUnits];

// Calculate the number of killed units
private _killedUnits = _initialUnitCount - _totalUnits;
//diag_log format ["DMS DEBUG :: Total killed units: %1", _killedUnits];

// Check if the number of killed units is greater than or equal to the threshold
if (_killedUnits >= _unitsThreshold) then {
    _killedpercent = true;
    //diag_log "DMS DEBUG :: Kill percent condition met";
} else {
    //diag_log "DMS DEBUG :: Kill percent condition not met";
};

_killedpercent;
