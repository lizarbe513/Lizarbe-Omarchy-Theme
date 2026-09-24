local active_border_color = "#E31B23"
local inactive_border_color = "#D5D8DC"

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 1,
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  decoration = {
    rounding = 0,
    shadow = {
      enabled = true,
      range = 24,
      render_power = 3,
      color = "rgba(00000022)",
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})
