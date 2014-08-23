clsObject = {__ClassType = '<base class>'}
function clsObject:inherit(o)
    o = o or {}
    if not self.__SubClass then
        self.__SubClass = {}
        setmetatable(self.__SubClass, {__mode="v"})
    end
    table.insert(self.__SubClass, o)

    for k, v in pairs(self) do
        if not o[k] then
            o[k]=v
        end
    end
    o.__SubClass = nil
    o.__SuperClass = self

    return o
end

function clsObject:attachToClass(Obj)
    setmetatable(Obj, {__ObjectType="<base object>", __index = self})
    return Obj
end

function clsObject:new(...)
    local o = {}
    self:attachToClass(o)

    if o.__init__ then
        o:__init__(...)
    end
    return o
end

local function Import(file)
    local Ret = {}
    setmetatable(Ret, {__index=_G})
    local func = loadfile(file)
    assert(func, "no such file:"..file)
    setfenv(func, Ret)()
    return Ret 
end

--local ITEM_DAT = Import(ITEM_DAT_FILE)

return clsObject