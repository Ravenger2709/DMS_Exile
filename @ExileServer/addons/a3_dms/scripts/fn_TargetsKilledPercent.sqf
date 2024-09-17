/*
    DMS_fnc_TargetsKilledPercent
    Created by Ravenger2709

    Usage:
    [
        _unit,
        _group,
        _object
    ] call DMS_fnc_TargetsKilledPercent;

    Will accept non-array argument of group, unit, or object.
*/

if (_this isEqualTo []) exitWith
{
    diag_log "DMS ERROR :: Calling DMS_TargetsKilled with empty array!";
};

private _killedpercent = false;

// Get the kill percent value from config
private _killPercent = DMS_AI_KillPercent;

// Get all living AI units
private _allUnits = _this call DMS_fnc_GetAllUnits;
private _totalUnits = count _allUnits;

// Calculate the number of units that need to be killed
private _unitsToKill = ceil((_killPercent / 100) * _totalUnits);

// Check if the number of living units is less than or equal to the required kill percent
if (_totalUnits <= _unitsToKill) then
{
    _killedpercent = true;
};

// Log the result using DMS_fnc_DebugLog
[_killedpercent, "Targets Killed Percent"] call DMS_fnc_DebugLog;

_killedpercent;
