-- Helper: get current script directory (computed only once)
local function script_dir()
    local info = debug.getinfo(1, "S").source:sub(2)
    return info:match("(.*/)") or "./"
end

-- Base directory for input/output
local baseDir = script_dir() .. "../fulldata/"

-- Create a Metatable for summaries
local SummaryMetaTable = {
    __add = function(left, right)
        local newSummary = {super=0, good=0, middle=0, low=0}
        for k, v in pairs(left) do
            newSummary[k] = v + right[k]
        end
        return newSummary
    end
}

-- Read data from data4.txt
local lines = {}
local filepath = baseDir .. "data4.txt"
for line in io.lines(filepath) do
    table.insert(lines, line)
end

-- Skip header
table.remove(lines, 1)

-- Initialize table to hold summary counts for each person
local people = {}

-- Process each line and collect data
for _, line in ipairs(lines) do
    local name, tech, soft, bus, creative, academic =
        line:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")

    local summary = {super=0, good=0, middle=0, low=0}
    setmetatable(summary, SummaryMetaTable)

    for _, skill in ipairs({tech, soft, bus, creative, academic}) do
        summary[skill] = (summary[skill] or 0) + 1
    end

    local finalSummary
    if summary.super > 0 then
        finalSummary = "super"
    elseif summary.good >= 2 then
        finalSummary = "good"
    elseif summary.middle >= 3 then
        finalSummary = "middle"
    else
        finalSummary = "low"
    end

    table.insert(people, {name, tech, soft, bus, creative, academic, finalSummary})
end

-- Write data to data5.txt
local out = io.open(baseDir .. "data5.txt", "w")
out:write("Name,Technical Skills,Soft Skills,Business Skills,Creative Skills,Academic Skills,Summary\n")
for _, entry in ipairs(people) do
    out:write(table.concat(entry, ',') .. "\n")
end
out:close()