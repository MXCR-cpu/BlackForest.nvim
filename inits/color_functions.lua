local api = vim.api
-- local g = vim.g
local fn = vim.fn
local degToRad = 0.01745329251994329576923690768489

local function f_inv(t)
  if t > 6 / 29 then
    return t * t * t
  else
    return 3 * (6 / 29) * (6 / 29) * (t - 4 / 29)
  end
end

local function gamma(t)
  if t > 0.0031308 then
    return 1.055 * (t ^ (1 / 2.4)) - 0.055
  else
    return 12.92 * t
  end
end

local xyzRef = {
  x = 95.047,
  y = 100.000,
  z = 108.883,
}

M = {}

M.utility = {
  stringify = function(table)
    local fieldsExist = function(tble, fields)
      local exist = (type(tble) == "table")
      for field in fields:gmatch(".") do
        exist = exist and (tble[field] ~= nil)
      end
      return exist
    end

    if type(table) == "string" then
      return table
    elseif fieldsExist(table, "rgb") then
      return "{"
        .. table.r
        .. ","
        .. table.g
        .. ","
        .. table.b
        .. "}"
    elseif fieldsExist(table, "lch") then
      return "{"
        .. table.l
        .. ","
        .. table.c
        .. ","
        .. table.h
        .. "}"
    elseif fieldsExist(table, "lab") then
      return "{"
        .. table.l
        .. ","
        .. table.a
        .. ","
        .. table.b
        .. "}"
    end
  end,

  parseTextLch = function(text)
    local numbers = {}
    for number in text:gmatch("%d+") do
      table.insert(numbers, tonumber(number))
    end
    return { l = numbers[1], c = numbers[2], h = numbers[3] }
  end,

  cleanText = function(text)
    text = text:gsub("^[%s\"'#]+", "")
    text = text:gsub("[%s\"']+$", "")
    return text
  end,

  capitalize = function(str)
    return string.upper(str)
  end,
}


M.testUtilityFunctions = function()
  local testCases = {
    stringify = {
      { { l = 100, c = 0, h = 0 }, "{100,0,0}" },
      { { l = 74, c = 30, h = 20 }, "{74,30,20}" },
      { { l = 30, c = 50, h = 85 }, "{30,50,85}" },
    },
    parseTextLch = {
      { "{100,0,0}", { l = 100, c = 0, h = 0 } },
      { "{65,20,30}", { l = 65, c = 20, h = 30 } },
      { "{80,38,75}", { l = 80, c = 38, h = 75 } },
    },
    cleanText = {
      { '  "#FFFFFF" ', "FFFFFF" },
    },
    capitalize = {
      { "ffffff", "FFFFFF" },
      { "fe7f6f", "FE7F6F" },
      { "#aaaaaa", "#AAAAAA" },
    },
  }
  local passedFlag = true

  for key, value in pairs(testCases) do
    for _, v in ipairs(value) do
      if M.utility.stringify(M.utility[key](v[1]))
        ~= M.utility.stringify(v[2]) then
        print(
          key
            .. "\t: error : "
            .. M.utility.stringify(v[1])
            .. " => "
            .. M.utility.stringify(M.utility[key](v[1]))
            .. " != "
            .. M.utility.stringify(v[2])
        )
        passedFlag = false
        break
      end
    end
    if passedFlag then
      print(key .. "\t: passed")
    end
  end
end

-- Color Conversion Functions
-- RGB to Hex Function

M.error = {
  desc = { "ERROR" },
  to = function(self, type)
    self.desc[#self.desc + 1] = "Failed to convert to " .. type
    return self
  end,
  tostring = function(self)
    return table.concat(self.desc, "\n")
  end,
}

M.conversionChain = function(currentObject, conversions)
  for _, conversion in ipairs(conversions) do
    currentObject = currentObject.to(currentObject, conversion) 
  end
  return currentObject
end

M.hex = {
  value = "",

  set = function(self, value)
    if value:sub(1,1) ~= "#" then
      self.value = value
    else
      self.value = value:sub(2, #value)
    end
  end,

  to = function(self, direction)
    local conversionsTable = {
      RGB = function()
        return M.rgb:set(
          tonumber(string.sub(self.value, 1, 2), 16),
          tonumber(string.sub(self.value, 3, 4), 16),
          tonumber(string.sub(self.value, 5, 6), 16)
        )
      end,
      XYZ = function()
        return M.conversionChain(self, { "RGB", "XYZ" })
      end,
      LAB = function()
        return M.conversionChain(self, { "RGB", "XYZ", "LAB" })
      end,
      LCH = function()
        return M.conversionChain(self, { "RGB", "XYZ", "LAB", "LCH" })
      end,
    }
    return conversionsTable[direction]()
  end,

  tostring = function(self)
    return "#" .. self.value
  end,
}

M.rgb = {
  r = 0,
  g = 0,
  b = 0,

  set = function(self, r, g, b)
    self.r = r
    self.g = g
    self.b = b
    return self
  end,

  to = function(self, direction)
    local conversionsTable = {
      HEX = function()
        self:correct()
        return "#" .. M.utility.capitalize(
          string.format("%02x%02x%02x", self.r, self.g, self.b)
        )
      end,
      XYZ = function()
        self:correct()
        return M.xyz:set(
          self.r * 0.4124 + self.g * 0.3576 + self.b * 0.1805,
          self.r * 0.2126 + self.g * 0.7152 + self.b * 0.0722,
          self.r * 0.0193 + self.g * 0.1192 + self.b * 0.9505
        )
      end,
      LAB = function()
        self:correct()
        return M.conversionChain(self, { "XYZ", "LAB" })
      end,
      LCH = function()
        self:correct()
        return M.conversionChain(self, { "XYZ", "LAB", "LCH" })
      end,
    }
    return conversionsTable[direction]()
  end,

  correct = function(self)
    self.g = self.g > 255 and 255 or self.g
    self.b = self.b > 255 and 255 or self.b

    self.r = 0 > self.r and 0 or self.r
    self.g = 0 > self.g and 0 or self.g
    self.b = 0 > self.b and 0 or self.b

    return self
  end,

  tostring = function(self)
    return string.format("rgb(%03d, %03d, %03d)", self.r, self.g, self.b)
  end,
}

M.xyz = {
  x = 0,
  y = 0,
  z = 0,

  set = function(self, x, y, z)
    self.x = x
    self.y = y
    self.z = z
    return self
  end,

  to = function(self, direction)
    local conversionsTable = {
      HEX = function()
        return M.error:to("LAB")
      end,
      RGB = function()
        local threshold = 0.0031308
        local coefficient_1 = 1.055
        local power = 1 / 2.4
        local intercept = 0.055
        local coefficient_2
        local rgbVar = {
          r = (self.x / 100) * 3.2406
            + (self.y / 100) * -1.5372
            + (self.z / 100) * -0.4986,
          g = (self.x / 100) * -0.9689
            + (self.y / 100) * 1.8758
            + (self.z / 100) * 0.0415,
          b = (self.x / 100) * 0.0557
            + (self.y / 100) * -0.2040
            + (self.z / 100) * 1.0570,
        }

        local conditionalFunction = function(value)
          if value > threshold then
            value = (coefficient_1 * (value ^ power)) - intercept
          else
            value = coefficient_2 * value
          end
        end

        conditionalFunction(rgbVar.r)
        conditionalFunction(rgbVar.g)
        conditionalFunction(rgbVar.b)

        return M.rgb:set(
          rgbVar.r * 255,
          rgbVar.g * 255,
          rgbVar.b * 255
        ):correct()
      end,
      LAB = function()
        local threshold = 0.008856
        local coefficient = 7.787
        local intercept = 0.137931034
        local xyzVar = {
          x = self.x / xyzRef.x,
          y = self.y / xyzRef.y,
          z = self.z / xyzRef.z,
        }

        local conditionalFunction = function(value)
          if value.x > threshold then
            value = value ^ (1/3)
          else
            value = (coefficient * value) + intercept
          end
        end

        conditionalFunction(xyzVar.x)
        conditionalFunction(xyzVar.y)
        conditionalFunction(xyzVar.z)

        return M.lab:set(
          (116 * xyzVar.y) - 16,
          500 * (xyzVar.x - xyzVar.y),
          200 * (xyzVar.y - xyzVar.z)
        )
      end,
      LCH = function(self)
        return M.conversionChain(self, { "LAB", "LCH" })
      end,
    }
    return conversionsTable[direction]()
  end,

  tostring = function(self)
    return string.format("xyz(%03.4f, %03.4f, %03.4f)", self.x, self.y, self.z)
  end,
}

M.lab = {
  l = 0,
  a = 0,
  b = 0,

  set = function(self, l, a, b)
    self.l = l
    self.a = a
    self.b = b
    return self
  end,

  to = function(self, direction)
    local conversionsTable = {
      HEX = function()
        return self:to("XYZ"):to("RGB"):to("HEX")
      end,
      XYZ = function()
        local threshold = 0.008856
        local coefficient = 7.787
        local intercept = 0.137931034
        local xyzVar = {
          x = (self.a / 500) + ((self.l + 16) / 116),
          y = (self.l + 16) / 116,
          z = ((self.l + 16) / 116) - (self.b / 200),
        }

        -- print(vim.inspect(xyzVar))

        local conditionalFunction = function(value)
          if (value ^ 3) > threshold then
            value = value ^ (1 / 3)
          else
            value = (value - intercept) / coefficient
          end
        end

        conditionalFunction(xyzVar.x)
        conditionalFunction(xyzVar.y)
        conditionalFunction(xyzVar.z)

        return M.xyz:set(
          xyzRef.x * xyzVar.x,
          xyzRef.y * xyzVar.y,
          xyzRef.z * xyzVar.z
        )
      end,
      LAB = function()
        return M.error:to("LAB")
      end,
      LCH = function()
        return M.lch:set(
          self.l,
          math.sqrt(self.a ^ 2 + self.b ^ 2),
          math.atan(self.b, self.a * math.sqrt(self.a ^ 2 + self.b ^ 2) ) / degToRad
        )
      end,
    }
    return conversionsTable[direction]()
  end,

  tostring = function(self)
    return string.format("lab(%03.4f, %03.4f, %03.4f)", self.l, self.a, self.b)
  end,
}

M.lch = {
  l = 0,
  c = 0,
  h = 0,

  set = function(self, l, c, h)
    self.l = l
    self.c = c
    self.h = h
    return self
  end,

  to = function(self, direction)
    local conversionsTable = {
      HEX = function()
        return M.conversionChain(self, { "LAB", "XYZ", "RGB", "HEX" })
      end,
      RGB = function()
        return M.conversionChain(self, { "LAB", "XYZ", "RGB" })
      end,
      XYZ = function()
        return M.conversionChain(self, { "LAB", "XYZ" })
      end,
      LAB = function()
        return M.lab:set(
          self.l,
          self.c * math.cos(self.h * degToRad),
          self.c * math.sin(self.h * degToRad)
        )
      end,
    }
    return conversionsTable[direction]()
  end,

  tostring = function(self)
    return string.format("lch(%03.4f, %03.4f, %03.4f)", self.l, self.c, self.h)
  end,
}

M.hsl = {
  h = 0,
  s = 0,
  l = 0,

  set = function(self, h, s, l)
    self.h = h
    self.s = s
    self.l = l
    return self
  end,

  to = function(self)
    local conversionsTable = {
      HEX = function()
        self.h = self.h / 360
        self.s = self.s / 100
        self.l = self.l / 100
        return self:to("RGB"):correct():to("HEX")
      end,
      RGB = function()
        local function hueToRgb(p, q, t)
          if t < 0 then
            t = t + 1
          end
          if t > 1 then
            t = t - 1
          end
          if t < 1 / 6 then
            return p + (q - p) * 6 * t
          end
          if t < 1 / 2 then
            return q
          end
          if t < 2 / 3 then
            return p + (q - p) * (2 / 3 - t) * 6
          end
          return p
        end

        if self.s == 0 then
          return M.rgb:set(self.l, self.l, self.l)
        else
          local q = self.l < 0.5
            and self.l * (1 + self.s)
            or self.l + self.s - self.l * self.s
          local p = 2 * self.l - q
          return M.rgb:set(
            hueToRgb(p, q, self.h + (1 / 3)) * 255,
            hueToRgb(p, q, self.h) * 255,
            hueToRgb(p, q, self.h - (1 / 3)) * 255
          )
        end
      end,
      XYZ = function()
        return M.error:to("XYZ")
      end,
      LAB = function()
        return M.error:to("LAB")
      end,
      LCH = function()
        return M.error:to("LCH")
      end,
    }
    return conversionsTable[type]()
  end
}

-- "FF0000"

M.hexUpdate = function()
  local left = fn.getpos("'<")
  local right = fn.getpos("'>")
  local hexValue = M.utility.cleanText(
    api.nvim_buf_get_text(
      0,
      left[2] - 1,
      left[3] - 1,
      right[2] - 1,
      right[3],
      {}
    )[1]
  )

  -- print(vim.inspect(hexValue))
  local lchValue = M.hexToLch(hexValue, true)
  local newLchValueText = fn.input(
    "Current Lch Value {"
    .. lchValue.l
    .. ","
    .. lchValue.c
    .. ","
    .. lchValue.h
    .. "}; New Lch Value {l,c,h}: "
  )

  local newLchValue = M.utility.parseTextLch(newLchValueText)
  local newHexValue = M.utility.capitalize(M.lchToHex(newLchValue))
  api.nvim_buf_set_text(
    0,
    left[2],
    left[3],
    right[2],
    right[3],
    { newHexValue }
  )
end

M.lchPrintValue = function(prnt)
  local newLchValueText = fn.input("Lch Value {l,c,h}: ")
  local newLchValue = M.utility.parseTextLch(newLchValueText)
  local newHexValue = M.utility.capitalize(M.lchToHex(newLchValue))
  prnt = prnt or false
  if prnt then
    local cursor_position = fn.getpos(".")
    api.nvim_buf_set_text(
      0,
      cursor_position[2] - 1,
      cursor_position[3],
      cursor_position[2] - 1,
      cursor_position[3],
      { newHexValue }
    )
  end
  print("\nHex value: " .. newHexValue)
end

M.testFunctions = function()
  local testCases = {
    rgbToHex = {
      { M.conversionChain(M.rgb:set(255, 0, 0), { "HEX" }):tostring(), "#FF0000" },
      { M.conversionChain(M.rgb:set(255, 255, 255), { "HEX" }):tostring(), "#FFFFFF" },
    },
    hexToRgb = {
      { M.conversionChain(M.hex:set("FF0000"), { "RGB" }):tostring(), "rgb(255, 0, 0)" },
      { M.conversionChain(M.hex:set("FFFFFF"), { "RGB" }):tostring(), "rgb(255, 255, 255)" },
    },
    hexToLab = {
      { M.conversionChain(M.hex:set("FFB636"), { "LAB" }):tostring(), "lab(80, 20, 72)" },
    },
    labToHex = {
      { M.conversionChain(M.lab:set(80, 20, 72), { "HEX" }):tostring(), "#FFB636" },
    },
    hexToLch = {
      { M.conversionChain(M.hex:set("FA1A09"), { "LCH" }):tostring(), "lch(53, 100, 40)" },
    },
    lchToHex = {
      { M.conversionChain(M.lch:set(53, 100, 40), { "HEX" }):tostring(), "#FA1A09" },
    },
  }
  local passedFlag = true

  for key, value in pairs(testCases) do
    for index, v in ipairs(value) do
      if v[1] ~= v[2] then
        print(
          key
            .. " : error ("
            .. index
            .. ") : "
            .. v[1]
            .. " != "
            .. v[2]
        )
        passedFlag = false
        break
      end
    end
    if passedFlag then
      print(key .. " : passed")
    end
  end
end

return M

