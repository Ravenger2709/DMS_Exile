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

// Static variable to store initial unit count
if (isNil "DMS_initialUnitCount") then
{
    DMS_initialUnitCount = count (_this call DMS_fnc_GetAllUnits);
};

// Calculate the acceptable number of remaining units based on initial unit count
private _unitsThreshold = floor((100 - _killPercent) * DMS_initialUnitCount / 100);

// Get all living AI units
private _allUnits = _this call DMS_fnc_GetAllUnits;
private _totalUnits = count _allUnits;

// Check if the number of living units is less than or equal to the threshold
if (_totalUnits <= _unitsThreshold) then
{
    _killedpercent = true;
};

_killedpercent;
