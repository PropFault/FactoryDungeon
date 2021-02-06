#pragma once
#include <string>
#include <nlohmann/json.hpp>
struct Action{
    std::string uniqueID;
    std::string actionType;
    uint64_t tick;
    NLOHMANN_DEFINE_TYPE_INTRUSIVE(uniqueID, actionType, tick);
}