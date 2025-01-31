def on_resize(boss, window, data=None):
    if getattr(boss, "font_size_multiplier", None) is None:
        boss.font_size_multiplier = 0

    if data is None:
        data = boss.cached_geometry
    else:
        boss.cached_geometry = data

    # Define known screen widths and corresponding font sizes
    width_min, width_max = 1280, 3840  # Example values for MacBook vs. Studio Display
    font_min, font_max = 10, 17  # Font size 10 for MacBook, 17 for Studio Display

    width = data["new_geometry"].right

    # Linear interpolation of the font size
    if width <= width_min:
        new_font_size = font_min
    elif width >= width_max:
        new_font_size = font_max
    else:
        new_font_size = font_min + (width - width_min) / (width_max - width_min) * (
            font_max - font_min
        )

    boss.set_font_size(new_font_size * (1 + (0.3 * boss.font_size_multiplier)))


def on_set_user_var(boss, window, data):
    if getattr(boss, "font_size_multiplier", None) is None:
        boss.font_size_multiplier = 0

    if data["key"] == "var:KITTY_ADJUST_FONT_SIZE_OFFSET":
        value = data["value"]
        if value == "up":
            boss.font_size_multiplier += 1
        elif value == "down":
            boss.font_size_multiplier -= 1

        on_resize(boss, window)
