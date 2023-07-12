local conf = {
			name = 'LAYOUT_pretty',
			variant = 'zmk',
			layout = {
				'x x x x x x x _ _ _ _ _ _ x x x x x x x',
				'x x x x x x x _ _ _ _ _ _ x x x x x x x',
				'x x x x x x x x x _ _ x x x x x x x x x',
				'x x x x x x _ _ x _ _ x _ _ x x x x x x',
				'x x x x x _ x x x _ _ x x x _ x x x x x',
			},
		}

require("qmk").setup(conf)
