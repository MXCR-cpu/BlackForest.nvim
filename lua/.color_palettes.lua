M = {}

M.grey_tone = {
  "#000000",
  "#050505",
  "#0f0f0f",
  "#191919",
  "#232323",
  "#2d2d2d",
  "#363636",
  "#404040",
  "#404040",
  "#4a4a4a",
  "#545454",
  "#5e5e5e",
  "#676767",
  "#717171",
  "#7b7b7b",
  "#858585",
  "#8f8f8f",
  "#989898",
  "#a2a2a2",
  "#acacac",
  "#b6b6b6",
  "#c0c0c0",
  "#c9c9c9",
  "#d3d3d3",
  "#dddddd",
  "#e7e7e7",
  "#f1f1f1",
  "#fbfbfb",
  "#ffffff",
}

M.temper_tone = {
  '#2a363b',
  '#e84a5f',
  '#ff847c',
  '#feceab',
  '#99b898',
}

M.sunset_tone_v1 = {
  "#00202E",
  "#003f5C",
  "#2C4875",
  "#8A508F",
  "#BC5090",
  "#FF6361",
  "#FF8531",
  "#FFA600",
  "#FFD380",
}

M.sunset_tone_v2 = {
  { 198, 100, 9 },
  { 199, 100, 12 },
  { 217, 45, 24 },
  { 294, 28, 36 },
  { 324, 45, 44 },
  { 1,  100, 60 },
  { 24, 100, 60 },
  { 39, 100, 50 },
  { 39, 100, 75 },
}

M.sunset_tone_v3 = {
  { 89, 1, 40 },
  { 90, 5, 30 },
}

M.cherry_tone_v1 = {
  "#110D0D",
  "#201B1C",
  "#322B2D",
  "#433F42",
  "#59595B",
  "#7E7575",
  "#8C4B37",
  "#A89592",
  "#C9B6B3",
  "#E4D4D3",
}

M.cherry_tone_v2 = {
  "#18100F",
  "#262426",
  "#3E3B3E",
  "#4A1B0F",
  "#6C5D5D",
  "#8A3422",
  "#BB5C4D",
  "#D28D88",
  "#E0B4B6",
  "#EBD2D4",
}

vim.g.colors_shades = M.cherry_tone_v1

vim.fn.color_index = function(index)
  return vim.g.colors_shades[
    math.floor((index / 100) * (#vim.g.colors_shades - 1)) + 1
  ]
end

return M


