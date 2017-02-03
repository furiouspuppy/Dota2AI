# Style Guide
* Read through the lua-users Lua Style Guide here: http://lua-users.org/wiki/LuaStyleGuide for an idea of typical conventions.  Specifics for this project are listed below.

# Formatting
* Use 1 tab for indentations

# Naming
* use self-documenting variable names
* constants use ```UPPERCASE_SNAKE```
* variable names use ```camelCase```
* functions use ```PascalCase```
* Use ```_``` for unneeded/unused variables

    ```Lua
    local TEAM_RADIANT   = 2
    local tableNearbyHeroes = {}
    local function GetLane() end

    for _,v in ipairs(table) do
      print(v)
    end
    ```

# Layout

* Use spaces around operators

    ```Lua
    -- bad
    local a=1*2
    local s='a'..'b'

    -- good
    local a = 1 * 2
    local s = 'a' .. 'b'
    ```

* One space after ```( [``` and before ```] )```

    ```Lua
    -- bad
    function Bad(argument)
    end

    -- good
    function Good( argument )
    end
    ```

* Align blocks of assignments or function arguments to a tab stop if possible, especially if related

    ```Lua
    -- bad
    local a = 1
    local long_identifier = 2

    -- good
    local a               = 1
    local long_identifier = 2

    -- bad
    sysCommand(form, UI_FORM_UPDATE_NODE, 'a', FORM_NODE_VISIBLE, false)
    sysCommand(form, UI_FORM_UPDATE_NODE, 'sample', FORM_NODE_VISIBLE, false)

    -- good
    sysCommand(form, UI_FORM_UPDATE_NODE, 'a',      FORM_NODE_VISIBLE, false)
    sysCommand(form, UI_FORM_UPDATE_NODE, 'sample', FORM_NODE_VISIBLE, false)
    ```

* Leave an empty line between function definitions, also empty lines between blocks are acceptable

    ```Lua
    -- bad
    function a()
    end
    function b()
    end

    -- good
    function a()
    end

    function b()
    end
    ```
    

# Comments

* Don't write unnecessary comments. Try to make code self documenting and simple
* Don't leave commented out code in. Use the version control system


# Annotations
* Use TODO: and FIXME: tags
* TODO indicates a missing feature to be implemented later
* FIXME indicates a problem in the existing code (inefficient implementation, bug, unnecessary code, etc)
* Avoid using other tags unless really necessary


# Scopes

* Prefer to use locals whenever possible
* Prefer to use modules instead of polluting the global scope
* Prefer to create local aliases when requiring a module


# Strings

* Prefer double-quoted strings over single-quoted


# Functions

* Avoid bot-specific code especially in *_generic files
* Use constants/utils/etc files when appropriate
* Keep argument list shorter than 3 or 4 parameters
* Avoid one-lining functions

    ```Lua
    -- bad
    function bad() return 0 end
    function longArgumentList(arg1, arg2, arg3, arg4, arg5, arg6)
    end

    -- good
    function good()
      return 0
    end

    function optionTable(options)
    end
    ```

* Write for performance, prefer to return as early as possible

    ```Lua
    -- bad
    function badFunction(arg)
      if arg == 1 then
        -- process for 1
        return 0
      elseif arg == 2 then
        -- process for 2
        return 5
      elseif arg == 3 then
        -- process for 3
        return -2
      else
        -- process for others
        return 7
      end

    end

    -- good
    function goodFunction(arg)
      if not arg then return 0 end

      -- process

      return 1
    end
    ```

* Indent argument list to align to first argument when inserting line-break

    ```Lua
    -- bad
    badCall(arg1,
    arg2,
    arg3,
    arg4
    )

    -- good
    goodCall(arg1,
             arg2,
             arg3,
             arg4)
    ```

* Prefer colon-syntax to explicit self argument

    ```Lua
    -- bad
    function Class.method(self, arg1, arg2)
    end

    -- good
    function Class:method(arg1, arg2)
    end
    ```

# Tables

* Break longer assignment to multiple lines
* Align keys when broken over multiple lines
* For lists where order might be changed frequenlty such as item/skill builds prefer semi-colon instead of comma
* Prefer to use plain keys in dictionary constructors

    ```Lua
    -- bad
    table = {key1=val1, key2=val2, key3=val3, key4=val4}

    -- good
    table = {
      key1 = val1,
      key2 = val2,
      key3 = val3,
      key4 = val4,
    }

    -- ok
    table = {
      ["key1"] = val1,
      ["key2"] = val2
    }

    -- better
    table = {
      key1 = val1;
      key2 = val2;
    }
    ```

# Miscellaneous

* When checking for nil, prefer to use only the variable name

    ```Lua
    -- ok
    if var ~= nil then
    end
    if var == nil then
    end

    -- good
    if var then
    end
    if not var then
    end
    ```

* Prefer single conditional assignment to if-then-else

    ```Lua
    -- bad
    if not x then
      x = 1
    end

    -- good
    x = x or 1
    ```

* Avoid more than 3 levels of nesting
* Use your own judgement to break any of the above rules

# General rules
* Don't force a bot to do actions outside of places designated for actions such as modes or ability_item_usage type files.  We don't want to have to track down errant behaviors.
* Don't try to perform actions in a mode they don't belong in i.e. grab runes in mode_farm_*, if a bot walks by a rune to grab mode_rune_* should take over.  If there isn't an appropriate place to handle an action we should have a project discussion on how to handle it.
* SetActionQueueing() should always be left off.  If you turn action queueing on for a combo or set of movements, turn it off afterward.



