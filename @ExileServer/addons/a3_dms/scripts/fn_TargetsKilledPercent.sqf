/*
    DMS_fnc_TargetsKilledPercent
    Created by Ravenger2709

    Usage:
    [
        _unit,
        _group,
        _object,
        _threshold
    ] call DMS_fnc_TargetsKilledPercent;

    Will accept non-array argument of group, unit, or object.
*/

if (!(_this isEqualType [])) exitWith
{
    diag_log "DMS ERROR :: Calling DMS_TargetsKilled with non-array argument!";
};

if (count _this < 4) exitWith
{
    diag_log "DMS ERROR :: Calling DMS_TargetsKilled with insufficient parameters!";
};

private _unit = _this select 0;
private _group = _this select 1;
private _object = _this select 2;
private _threshold = _this select 3;

private _killedpercent = false;

// Получение значения DMS_AI_KillPercent из config.sqf
private _killPercent = DMS_AI_KillPercent;

// Получение всех живых AI юнитов
private _allUnits = [_unit, _group, _object] call DMS_fnc_GetAllUnits;
private _totalUnits = count _allUnits;

// Подсчет убитых юнитов
private _killedUnits = _totalUnits - {alive _x} count _allUnits;

// Проверка, если процент убитых юнитов больше или равен DMS_AI_KillPercent
if ((_killedUnits / _totalUnits) * 100 >= _killPercent) then
{
    _killedpercent = true;
};

_killedpercent;
