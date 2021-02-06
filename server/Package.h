#pragma once
#include <vector>
#include "Action.h"
#include <nlohmann/json.hpp>

enum PackageType{
    CLIENT_INIT,
    ACTIONS_COMMITTED
}
NLOHMANN_JSON_SERIALIZE_ENUM( TaskState, {
    {CLIENT_INIT, "CLIENT_INIT"},
    {ACTIONS_COMMITTED, "ACTIONS_COMMITTED"},
})
struct Package{
    PackageType type;
    std::vector<Action> actions;
    int tickRate;
    int serverTick;
    NLOHMANN_DEFINE_TYPE_INTRUSIVE(type, actions, tickRate, serverTick);
}