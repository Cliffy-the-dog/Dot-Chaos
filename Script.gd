extends Node2D

enum State { MENU, PLAY, PAUSED, OVER, WIN, SETTINGS, TUTORIAL, SHOP, ACHIEVEMENTS, CLASSIC_SLOTS }

const SPEED_SCALE := 0.80
const TIME_SCALE  := 1.20

const DOT_RADIUS       := 15.0
const ENEMY_BASE_SPEED := 320.0 * SPEED_SCALE
const PULSE_RANGE      := 100.0
const SPAWN_INTERVAL   := 0.55
const WAVE_DELAY       := 1.0
const WAVE_START_DELAY := 0.8
const SPEEDRUN_TARGET  := 20
const ENEMY_CAP        := 25
const MIN_SPAWN_DISTANCE := 240.0
const UI_MARGIN        := 24.0

const KEY_SPEED       := 600.0 * SPEED_SCALE
const KEY_ACCEL       := 3600.0 * SPEED_SCALE
const MOUSE_SPEED_CAP := 600.0 * SPEED_SCALE

const JOY_RADIUS   := 80.0
const JOY_DEADZONE := 8.0

const LASER_WARN    := 1.3 * TIME_SCALE
const LASER_FIRE    := 0.40 * TIME_SCALE
const LASER_BAND    := 52.0
const MINE_WARN     := 1.15 * TIME_SCALE
const MINE_FIRE     := 0.40 * TIME_SCALE
const MINE_RADIUS   := 72.0
const METEOR_WARN   := 1.4 * TIME_SCALE
const METEOR_FIRE   := 0.40 * TIME_SCALE
const METEOR_RADIUS := 100.0
const PULSE_WARN    := 1.3 * TIME_SCALE
const PULSE_FIRE    := 0.40 * TIME_SCALE
const PULSE_RADIUS  := 240.0
const BOMB_WARN     := 1.7 * TIME_SCALE
const BOMB_FIRE     := 0.40 * TIME_SCALE
const BOMB_RADIUS   := 125.0
const SAW_WARN      := 1.3 * TIME_SCALE
const SAW_TRAVEL    := 1.4 * TIME_SCALE
const SAW_RADIUS    := 28.0
const SHOCK_WARN    := 1.6 * TIME_SCALE
const SHOCK_FIRE    := 0.55 * TIME_SCALE
const SHOCK_MAX_R   := 420.0

const BORDER_MARGIN         := 80.0
const SCANLINE_SPACING      := 4.0
const DUEL_TARGET           := 3
const DUEL_LIVES_START      := 3
const DUEL_CHARGE_TIME      := 1.5
const DUEL_BEAM_TIME        := 1.5
const DUEL_LASER_WIDTH      := 62.0
const DUEL_CRYSTAL_RADIUS   := 14.0
const DUEL_PICKUP_RADIUS    := 28.0
const DUEL_PLAYER_RADIUS    := 14.0
const DUEL_SPAWN_MIN        := 1.5
const DUEL_SPAWN_MAX        := 3.0
const DUEL_MAX_CRYSTALS     := 3
const DUEL_CRYSTAL_LIFETIME := 7.0

const TRAIL_LIFE := 0.42

const BOSS_WAVE_INTERVAL := 10
const BOSS_HP := 8
const BOSS_RADIUS := 65.0
const BOSS_MONEY_REWARD := 200
const BOSS_SPEED_MULT := 0.30
const ENEMY_HIT_COOLDOWN := 0.5

const CHECKPOINT_INTERVAL := 5
const WAVELESS_BOSS_TIME  := 150.0
const WAVELESS_BOSS_COOLDOWN := 45.0

const POWERUP_DROP_CHANCE := 0.08
const POWERUP_LIFETIME := 10.0
const POWERUP_RADIUS := 16.0
const POWERUP_PICKUP_RADIUS := 34.0
const POWERUP_DURATION := 5.0
const POWERUP_MAGNET_RANGE := 440.0
const POWERUP_MAGNET_SPEED := 500.0 * SPEED_SCALE
const POWERUP_PITY_KILLS := 20  # NEW: guaranteed drop after this many dry kills

# NEW: dash tuning
const DASH_SPEED         := 1400.0 * SPEED_SCALE
const DASH_TIME          := 0.16
const DASH_COOLDOWN      := 1.2
const DASH_IFRAME_GRACE  := 0.06

# NEW: combo & juice
const COMBO_WINDOW       := 3.0
const HITSTOP_TIME       := 0.05
const DEATH_SLOWMO_TIME  := 0.45
const DEATH_SLOWMO_SCALE := 0.25
const NEAR_MISS_RADIUS   := 22.0
const NEAR_MISS_REWARD   := 3

const CUSTOM_ORB_PRICE := 2000
const CUSTOM_TRAIL_PRICE := 3000
const CUSTOM_ORB_ID := "custom_orb"
const CUSTOM_TRAIL_ID := "custom_trail"

const ACHIEVEMENT_DEFS := [
	["first_blood", "First Blood", "Kill your first enemy"],
	["kill_100", "Century", "Kill 100 enemies total"],
	["kill_1000", "Thousand Cuts", "Kill 1000 enemies total"],
	["wave_5", "Rookie", "Reach wave 5 in Classic"],
	["wave_10", "Veteran", "Reach wave 10 in Classic"],
	["wave_20", "Legend", "Reach wave 20 in Classic"],
	["boss_slayer", "Boss Slayer", "Kill a boss"],
	["speedrun_win", "Speed Demon", "Win a Speedrun"],
	["speedrun_fast", "Lightning", "Win a Speedrun in under 2 minutes"],
	["waveless_2min", "Endurance", "Survive 2 minutes in Waveless"],
	["waveless_5min", "Immortal", "Survive 5 minutes in Waveless"],
	["duel_win", "Duelist", "Finish a Duel"],
	["rich", "Money Bags", "Have $1000 at once"],
	["shopper_5", "Shopper", "Own 5 skins"],
	["shopper_10", "Collector", "Own 10 skins"],
	["maxed", "Fully Loaded", "Max out any upgrade"],
	["trail_5", "Trailblazer", "Own 5 trails"],
	["trail_all", "Trail Master", "Own every trail"],
]

const BACKGROUNDS := [
	["nebula", "Nebula"], ["aurora", "Aurora"], ["grid", "Grid Scan"],
	["sunset", "Sunset"], ["ocean", "Deep Ocean"], ["void", "Void"],
	["custom", "Custom (upload)"],
]

const SKINS := [
	["classic", "Classic Red", 0, Color(1, 0.15, 0.2), Color(1, 0.75, 0.75), Color(1, 0.1, 0.15)],
	["cyan", "Cyan Comet", 150, Color(0.2, 0.9, 1.0), Color(0.8, 0.95, 1.0), Color(0.1, 0.7, 1.0)],
	["lime", "Neon Green", 200, Color(0.4, 1.0, 0.3), Color(0.9, 1.0, 0.7), Color(0.2, 0.9, 0.1)],
	["orange", "Sunset Orange", 250, Color(1, 0.55, 0.15), Color(1, 0.85, 0.6), Color(1, 0.4, 0.05)],
	["pink", "Pink Panther", 300, Color(1, 0.5, 0.8), Color(1, 0.8, 0.95), Color(1, 0.3, 0.6)],
	["elec_blue", "Electric Blue", 350, Color(0.3, 0.5, 1.0), Color(0.7, 0.85, 1.0), Color(0.15, 0.3, 1.0)],
	["acid", "Acid Yellow", 400, Color(0.9, 0.95, 0.2), Color(1, 1, 0.7), Color(0.7, 0.8, 0.1)],
	["mint", "Mint Condition", 450, Color(0.5, 1, 0.75), Color(0.85, 1, 0.9), Color(0.3, 0.9, 0.6)],
	["purple", "Purple Haze", 500, Color(0.65, 0.3, 1.0), Color(0.85, 0.7, 1.0), Color(0.5, 0.15, 0.9)],
	["ocean", "Deep Ocean", 550, Color(0.15, 0.35, 0.65), Color(0.4, 0.65, 0.9), Color(0.1, 0.25, 0.5)],
	["solar", "Solar Flare", 600, Color(1, 0.7, 0.2), Color(1, 0.95, 0.6), Color(1, 0.55, 0.1)],
	["copper", "Copper Cowboy", 650, Color(0.75, 0.45, 0.25), Color(0.95, 0.7, 0.5), Color(0.55, 0.3, 0.15)],
	["arctic", "Arctic Fox", 700, Color(0.85, 0.95, 1.0), Color(1, 1, 1), Color(0.6, 0.8, 1.0)],
	["lavender", "Lavender Dream", 750, Color(0.75, 0.6, 0.95), Color(0.92, 0.85, 1.0), Color(0.6, 0.45, 0.9)],
	["jade", "Jade Warrior", 800, Color(0.3, 0.75, 0.5), Color(0.6, 0.95, 0.75), Color(0.2, 0.6, 0.35)],
	["crimson", "Crimson Phantom", 900, Color(0.7, 0.1, 0.2), Color(1, 0.5, 0.55), Color(0.5, 0.05, 0.15)],
	["void_skin", "Void Walker", 1000, Color(0.3, 0.15, 0.5), Color(0.6, 0.4, 0.85), Color(0.15, 0.05, 0.3)],
	["gold", "Golden Wanderer", 1100, Color(1, 0.85, 0.2), Color(1, 1, 0.7), Color(0.85, 0.65, 0.1)],
	["ghost", "Ghost White", 1200, Color(0.95, 0.95, 0.95), Color(1, 1, 1), Color(0.75, 0.75, 0.9)],
	["hotrod", "Hot Rod", 1400, Color(0.75, 0.75, 0.8), Color(1, 1, 1), Color(0.9, 0.1, 0.1)],
	["lava", "Molten Lava", 1500, Color(1, 0.4, 0.1), Color(1, 0.9, 0.4), Color(0.9, 0.15, 0.05)],
	["cyber", "Cyber Punk", 1700, Color(1, 0.2, 0.9), Color(0.6, 1, 1), Color(0.8, 0.1, 0.7)],
	["blood", "Blood Moon", 1900, Color(0.5, 0.05, 0.1), Color(0.9, 0.3, 0.3), Color(0.35, 0.02, 0.08)],
	["rainbow", "Rainbow Rave", 2500, Color(1, 0.3, 0.3), Color(1, 1, 1), Color(1, 0.5, 0.5)],
	["fresh_blood", "Fresh Blood", 0, Color(0.15, 0.05, 0.08), Color(1, 0.25, 0.3), Color(0.5, 0.1, 0.15), "first_blood"],
	["centurion", "Centurion", 0, Color(0.4, 0.4, 0.45), Color(1, 0.9, 0.5), Color(0.6, 0.55, 0.3), "kill_100"],
	["reaper", "Reaper", 0, Color(0.08, 0.08, 0.12), Color(0.35, 1.0, 0.35), Color(0.2, 0.6, 0.2), "kill_1000"],
	["rookie_skin", "Rookie", 0, Color(0.2, 0.8, 0.7), Color(0.9, 1, 1), Color(0.4, 0.9, 0.8), "wave_5"],
	["veteran_skin", "Veteran", 0, Color(0.4, 0.45, 0.25), Color(0.9, 0.85, 0.6), Color(0.6, 0.55, 0.3), "wave_10"],
	["legend_skin", "Legend", 0, Color(0.15, 0.3, 0.85), Color(1, 0.85, 0.3), Color(0.3, 0.5, 1.0), "wave_20"],
	["giant_slayer", "Giant Slayer", 0, Color(0.35, 0.35, 0.4), Color(1, 0.55, 0.15), Color(0.7, 0.3, 0.1), "boss_slayer"],
	["swift", "Swift", 0, Color(0.5, 0.7, 1.0), Color(1, 1, 1), Color(0.6, 0.85, 1.0), "speedrun_win"],
	["bolt_skin", "Bolt", 0, Color(1, 1, 0.9), Color(1, 0.95, 0.2), Color(0.7, 0.9, 1.0), "speedrun_fast"],
	["survivor_skin", "Survivor", 0, Color(0.25, 0.5, 0.2), Color(0.9, 0.2, 0.15), Color(0.4, 0.7, 0.3), "waveless_2min"],
	["eternal", "Eternal", 0, Color(0.9, 0.9, 0.85), Color(1, 1, 1), Color(0.8, 0.85, 0.9), "waveless_5min"],
	["champion", "Champion", 0, Color(1, 0.5, 0.4), Color(1, 0.9, 0.7), Color(1, 0.3, 0.5), "duel_win"],
	["moneybags", "Moneybags", 0, Color(0.15, 0.5, 0.15), Color(1, 0.9, 0.3), Color(0.3, 0.7, 0.3), "rich"],
	["shopper_skin", "Shopper", 0, Color(0.8, 0.1, 0.4), Color(1, 0.85, 0.95), Color(0.6, 0.05, 0.3), "shopper_5"],
	["collector_skin", "Collector", 0, Color(0.45, 0.2, 0.35), Color(1, 0.6, 0.9), Color(0.7, 0.2, 0.5), "shopper_10"],
	["ultimate", "Ultimate", 0, Color(0.7, 0.2, 0.8), Color(1, 0.9, 0.3), Color(0.4, 0.8, 1.0), "maxed"],
	["trailblazer", "Trailblazer", 0, Color(0.9, 0.5, 0.1), Color(1, 0.85, 0.4), Color(1, 0.4, 0.1), "trail_5"],
	["trailm", "Trail Master", 0, Color(0.3, 0.9, 0.9), Color(1, 1, 1), Color(0.2, 0.7, 1.0), "trail_all"],
]

const TRAILS := [
	["basic", "Basic Trail", 0, "fade", Color(1.0, 0.35, 0.35), Color(1, 0.75, 0.75)],
	["ember", "Ember", 120, "sparks", Color(1.0, 0.55, 0.15), Color(1.0, 0.85, 0.3)],
	["frost", "Frost Ribbon", 180, "ribbon", Color(0.55, 0.85, 1.0), Color(0.9, 1.0, 1.0)],
	["violet", "Violet Comet", 240, "comet", Color(0.7, 0.4, 1.0), Color(0.95, 0.8, 1.0)],
	["bubblegum", "Bubblegum", 300, "bubbles", Color(1.0, 0.55, 0.8), Color(1.0, 0.85, 0.95)],
	["prism", "Prism", 420, "rainbow", Color(1, 1, 1), Color(1, 1, 1)],
	["voltage", "Voltage", 500, "zigzag", Color(0.4, 0.7, 1.0), Color(1.0, 1.0, 0.4)],
	["stardust", "Stardust", 650, "stars", Color(1.0, 0.95, 0.6), Color(1, 1, 1)],
	["twin", "Twin Tail", 800, "double", Color(0.4, 1.0, 0.7), Color(0.2, 0.8, 1.0)],
	["halo", "Halo", 1000, "glow", Color(1.0, 0.9, 0.5), Color(1.0, 1.0, 0.9)],
	["spirit", "Spirit Fire", 0, "sparks", Color(0.4, 1.0, 0.8), Color(0.9, 1.0, 1.0), "kill_1000"],
	["royal", "Royal Ribbon", 0, "ribbon", Color(0.85, 0.15, 0.6), Color(1.0, 0.7, 0.95), "rich"],
]

const UPGRADES := [
	["speed", "Hover Boost", [200, 500, 1000, 2000],
		["+10% move speed", "+20% move speed", "+30% move speed", "+45% move speed"]],
	["life", "Extra Life", [300, 900, 2000],
		["+1 Duel life", "+2 Duel lives", "+3 Duel lives"]],
	["revive", "Second Wind", [500, 1500, 3000],
		["+1 revive per run", "+2 revives per run", "+3 revives per run"]],
	["aoe", "Bigger Bangs", [400, 900, 1800],
		["+15% hazard size", "+30% hazard size", "+50% hazard size"]],
	["quick", "Quickdraw", [350, 800, 1600],
		["-15% fire time", "-30% fire time", "-45% fire time"]],
	["money", "Money Magnet", [500, 1200, 2500],
		["+25% money", "+50% money", "+100% money"]],
	["aim", "Aim Assist", [450, 1000, 2200],
		["+25% prediction", "+50% prediction", "+75% prediction"]],
]

const NO_TIER_UPGRADES := [
	["revive_regen", "Phoenix Core", 1800, "Regenerate 1 revive every 45s (up to max)"],
	["revive_cap", "Undying Will", 2600, "Permanent +1 max revive"],
	["shield_start", "Opening Ward", 1400, "Start every run with a 3s shield"],
	["powerup_boost", "Lucky Charm", 1200, "Double powerup drop chance"],
	["slow_field", "Graviton Field", 2200, "Enemies within 120px move 15% slower"],
	["cash_magnet", "Greed Aura", 1600, "Auto-collect cash within 160px"],
	["trail_unlock", "Trail Lover", 3000, "Unlock every trail instantly"],
	["revive_regen_2", "Phoenix Core II", 3200, "Halve revive regen time (every 22.5s)"],
	["aoe_aura", "Wide Warning", 2000, "Hazard sizes +10%"],
	["fire_delay", "Slow Fuse", 2400, "Hazard fire duration +15%"],
	["dash", "Phase Dash", 2800, "Longer revive shield (+1.5s)"],
	["split_bonus", "Split Profit", 1500, "Splitters drop $10 when they split"],
]

const SAVE_PATH := "user://cursor_chaos.json"

var screen: Vector2
var play_rect := Rect2()
var dot_pos: Vector2
var dot_trail: Array = []
var key_vel := Vector2.ZERO
var enemies: Array = []
var hazards: Array = []
var particles: Array = []
var wave := 1
var to_spawn := 0
var spawn_timer := 0.0
var wave_delay_timer := 0.0
var wave_announce_timer := 0.0
var shake := 0.0
var t := 0.0
var font: Font

var state: int = State.MENU
var _settings_origin: int = State.MENU
var current_mode := "classic"
var tutorial_mode := "classic"
var run_time := 0.0
var speedrun_time := 0.0
var waveless_time := 0.0
var _hazard_timer := 1.0
var _inf_enemy_timer := 0.0
var kills_this_run := 0
var revives_remaining := 0
var _revive_regen_timer := 0.0
var _revive_regen_interval := 45.0

var joy_active := false
var joy_index := -1
var joy_base := Vector2.ZERO
var joy_vec := Vector2.ZERO
var touch_target := Vector2.ZERO
var touch_to_go := false
var joy_p1_active := false
var joy_p1_index := -1
var joy_p1_base := Vector2.ZERO
var joy_p1_vec := Vector2.ZERO
var joy_p2_active := false
var joy_p2_index := -1
var joy_p2_base := Vector2.ZERO
var joy_p2_vec := Vector2.ZERO

var p1_pos := Vector2.ZERO
var p2_pos := Vector2.ZERO
var p1_vel := Vector2.ZERO
var p2_vel := Vector2.ZERO
var p1_crystals := 0
var p2_crystals := 0
var p1_lives := 3
var p2_lives := 3
var crystals: Array = []
var crystal_spawn_timer := 0.0
var duel_phase := "racing"
var duel_charge_timer := 0.0
var duel_beam_timer := 0.0
var duel_winner := ""
var duel_laser_end := Vector2.ZERO
var machine_pos := Vector2.ZERO

var fade_alpha := 0.0
var fade_state := ""
var fade_timer := 0.0
var fade_callback := Callable()

var menu_bg_seed := 0
var _game_started_at := 0.0

var money := 0
var owned_skins: Array = ["classic"]
var current_skin := "classic"
var owned_trails: Array = ["basic"]
var current_trail := "basic"
var owned_upgrades := {}
var no_tier_owned := {}
var active_effects := {
	"speed_mult": 1.0, "aoe_mult": 1.0, "fire_mult": 1.0,
	"lead_bonus": 0.0, "money_mult": 1.0, "extra_lives": 0, "revives": 0,
	"max_revives": 0, "shield_start": 0.0, "slow_field": 0.0,
	"drop_mult": 1.0, "cash_aura": 0.0,
}

var current_slot: int = 1
var classic_checkpoints: Array = [0, 0, 0, 0, 0]
var classic_checkpoint: int = 0
var classic_slot_rects: Array = []
var classic_new_rects: Array = []
var classic_back_rect := Rect2()
var _waveless_boss_timer := 0.0

var _prev_money := 0
var _money_flash := 0.0

var custom_bg_path := ""
var custom_bg_texture: Texture2D = null
var custom_orb_path := ""
var custom_orb_texture: Texture2D = null
var custom_trail_path := ""
var custom_trail_texture: Texture2D = null
var bg_refresh_rect := Rect2()

var powerups: Array = []
var shield_timer := 0.0
var slowmo_timer := 0.0
var magnet_timer := 0.0
var toast_message := ""
var toast_timer := 0.0
var achievements_unlocked: Array = []
var achv_stats := {}
var _achv_check_timer := 0.0
var achv_back_rect := Rect2()

# NEW: dash state
var dash_timer := 0.0
var dash_cooldown := 0.0
var dash_dir := Vector2.ZERO
var dash_trail: Array = []

# NEW: combo & juice state
var combo_count := 0
var combo_timer := 0.0
var hitstop_timer := 0.0
var death_slowmo_timer := 0.0
var kills_since_powerup := 0
var text_particles: Array = []
var streak_callout_text := ""
var streak_callout_timer := 0.0
var _last_daily_bonus_day := -1

var scores := {"classic": [], "speedrun": [], "waveless": []}
var tutorial_seen := {"classic": false, "speedrun": false, "waveless": false, "duel": false}
var settings := {
	"sfx": true, "music": true, "screen_shake": true,
	"show_hitboxes": false, "show_fps": false, "arrow_keys": true,
	"background": "nebula",
}

var menu_button_rects := {}
var settings_rows := {}
var audio_row_rects := {}
var audio_refresh_rects := {}
var settings_back_rect := Rect2()
var reset_tut_btn := Rect2()
var tutorial_btn := Rect2()
var overlay_btn_left := Rect2()
var overlay_btn_mid := Rect2()
var overlay_btn_right := Rect2()

var shop_tab_rects := {}
var shop_item_rects: Array = []
var shop_back_rect := Rect2()
var shop_current_tab := "skins"
var shop_scroll := 0.0

var sfx_players: Array = []
var default_sfx := {}
var default_music: AudioStreamWAV = null
var music_player: AudioStreamPlayer
var _sfx_cooldowns := {}
var custom_audio_paths := {}
var custom_streams := {}
var file_dialog: FileDialog
var file_dialog_target := ""

func _ready() -> void:
	_game_started_at = Time.get_ticks_msec() / 1000.0
	screen = get_viewport_rect().size
	_compute_play_rect()
	dot_pos = play_rect.get_center()
	font = ThemeDB.fallback_font
	menu_bg_seed = randi()
	achv_stats = _default_achv_stats()
	get_viewport().size_changed.connect(_on_size_changed)
	_load_scores()
	_prev_money = money
	_setup_audio()
	_setup_file_dialog()
	_set_mouse_visible(true)
	_check_daily_bonus()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_scores()

# NEW: daily return bonus
func _check_daily_bonus() -> void:
	var day := int(Time.get_unix_time_from_system() / 86400.0)
	if _last_daily_bonus_day == day:
		return
	_last_daily_bonus_day = day
	if _game_started_at > 0.0:
		money += 100
		_show_toast("Welcome back! +$100")
		_save_scores()

func _default_achv_stats() -> Dictionary:
	return {
		"kills": 0, "money_earned": 0, "bosses_killed": 0,
		"speedrun_wins": 0, "duel_wins": 0,
		"waveless_best": 0.0, "classic_best_wave": 0, "fastest_speedrun": 999.0,
	}

func _on_size_changed() -> void:
	screen = get_viewport_rect().size
	_compute_play_rect()

func _compute_play_rect() -> void:
	play_rect = Rect2(BORDER_MARGIN, BORDER_MARGIN,
		screen.x - BORDER_MARGIN * 2.0, screen.y - BORDER_MARGIN * 2.0)

func _set_mouse_visible(v: bool) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if v else Input.MOUSE_MODE_HIDDEN)

func _transition_to(cb: Callable) -> void:
	if fade_state != "": return
	fade_callback = cb
	fade_state = "out"
	fade_timer = 0.0

func _process_fade(delta: float) -> void:
	if fade_state == "out":
		fade_timer += delta
		fade_alpha = minf(1.0, fade_timer / 0.15)
		if fade_alpha >= 1.0:
			if fade_callback.is_valid(): fade_callback.call()
			fade_state = "in"
			fade_timer = 0.0
	elif fade_state == "in":
		fade_timer += delta
		fade_alpha = maxf(0.0, 1.0 - fade_timer / 0.25)
		if fade_alpha <= 0.0: fade_state = ""

func _get_skin(skin_id: String) -> Array:
	for s in SKINS:
		if s[0] == skin_id: return s
	return SKINS[0]

func _get_trail(trail_id: String) -> Array:
	for tr in TRAILS:
		if tr[0] == trail_id: return tr
	return TRAILS[0]

func _skin_achv_lock(skin: Array) -> String:
	return str(skin[6]) if skin.size() >= 7 else ""

func _trail_achv_lock(trail: Array) -> String:
	return str(trail[6]) if trail.size() >= 7 else ""

func _skin_primary(skin: Array) -> Color:
	if skin[0] == "rainbow": return Color.from_hsv(fmod(t * 0.3, 1.0), 1.0, 1.0)
	return skin[3]

func _skin_core(skin: Array) -> Color:
	if skin[0] == "rainbow": return Color(1, 1, 1)
	return skin[4]

func _skin_glow(skin: Array) -> Color:
	if skin[0] == "rainbow": return Color.from_hsv(fmod(t * 0.3 + 0.5, 1.0), 1.0, 0.8)
	return skin[5]

func _get_upgrade_max_level(uid: String) -> int:
	for upg in UPGRADES:
		if upg[0] == uid: return (upg[2] as Array).size()
	return 0

func _compute_active_effects() -> void:
	active_effects = {
		"speed_mult": 1.0, "aoe_mult": 1.0, "fire_mult": 1.0,
		"lead_bonus": 0.0, "money_mult": 1.0, "extra_lives": 0, "revives": 0,
		"max_revives": 0, "shield_start": 0.0, "slow_field": 0.0,
		"drop_mult": 1.0, "cash_aura": 0.0,
	}
	var lvl_speed: int = int(owned_upgrades.get("speed", 0))
	var lvl_life: int = int(owned_upgrades.get("life", 0))
	var lvl_revive: int = int(owned_upgrades.get("revive", 0))
	var lvl_aoe: int = int(owned_upgrades.get("aoe", 0))
	var lvl_quick: int = int(owned_upgrades.get("quick", 0))
	var lvl_money: int = int(owned_upgrades.get("money", 0))
	var lvl_aim: int = int(owned_upgrades.get("aim", 0))
	match lvl_speed:
		1: active_effects["speed_mult"] = 1.10
		2: active_effects["speed_mult"] = 1.20
		3: active_effects["speed_mult"] = 1.30
		4: active_effects["speed_mult"] = 1.45
	active_effects["extra_lives"] = lvl_life
	active_effects["revives"] = clampi(lvl_revive, 0, 3)
	match lvl_aoe:
		1: active_effects["aoe_mult"] = 1.15
		2: active_effects["aoe_mult"] = 1.30
		3: active_effects["aoe_mult"] = 1.50
	match lvl_quick:
		1: active_effects["fire_mult"] = 0.85
		2: active_effects["fire_mult"] = 0.70
		3: active_effects["fire_mult"] = 0.55
	match lvl_money:
		1: active_effects["money_mult"] = 1.25
		2: active_effects["money_mult"] = 1.50
		3: active_effects["money_mult"] = 2.00
	match lvl_aim:
		1: active_effects["lead_bonus"] = 0.25
		2: active_effects["lead_bonus"] = 0.50
		3: active_effects["lead_bonus"] = 0.75
	var max_rev: int = int(active_effects["revives"])
	if bool(no_tier_owned.get("revive_cap", false)): max_rev += 1
	active_effects["max_revives"] = max_rev
	active_effects["shield_start"] = 3.0 if bool(no_tier_owned.get("shield_start", false)) else 0.0
	active_effects["slow_field"] = 0.15 if bool(no_tier_owned.get("slow_field", false)) else 0.0
	active_effects["drop_mult"] = 2.0 if bool(no_tier_owned.get("powerup_boost", false)) else 1.0
	active_effects["cash_aura"] = 160.0 if bool(no_tier_owned.get("cash_magnet", false)) else 0.0
	if bool(no_tier_owned.get("aoe_aura", false)): active_effects["aoe_mult"] *= 1.10
	if bool(no_tier_owned.get("fire_delay", false)): active_effects["fire_mult"] *= 1.15

func _award_money(amount: int) -> void:
	var actual := int(amount * float(active_effects["money_mult"]))
	money += actual
	achv_stats["money_earned"] = int(achv_stats["money_earned"]) + actual

func _cycle_background() -> void:
	var idx := 0
	for i in range(BACKGROUNDS.size()):
		if BACKGROUNDS[i][0] == settings["background"]:
			idx = i
			break
	idx = (idx + 1) % BACKGROUNDS.size()
	var new_bg: String = BACKGROUNDS[idx][0]
	settings["background"] = new_bg
	_save_scores()
	if new_bg == "custom" and custom_bg_texture == null:
		_open_file_dialog("bg")

func _open_file_dialog(target: String) -> void:
	file_dialog_target = target
	if target == "bg" or target == "orb" or target == "trail":
		file_dialog.filters = PackedStringArray(["*.png, *.jpg, *.jpeg ; Images"])
		file_dialog.title = "Choose an Image"
	else:
		file_dialog.filters = PackedStringArray(["*.ogg, *.mp3, *.wav ; Audio Files"])
		file_dialog.title = "Choose an Audio File"
	file_dialog.popup_centered()

func _load_custom_bg_texture(path: String) -> void:
	custom_bg_texture = null
	if path == "" or not FileAccess.file_exists(path): return
	var img := Image.load_from_file(path)
	if img == null: return
	custom_bg_texture = ImageTexture.create_from_image(img)

func _load_custom_orb_texture(path: String) -> void:
	custom_orb_texture = null
	if path == "" or not FileAccess.file_exists(path): return
	var img := Image.load_from_file(path)
	if img == null: return
	custom_orb_texture = ImageTexture.create_from_image(img)

func _load_custom_trail_texture(path: String) -> void:
	custom_trail_texture = null
	if path == "" or not FileAccess.file_exists(path): return
	var img := Image.load_from_file(path)
	if img == null: return
	custom_trail_texture = ImageTexture.create_from_image(img)

func _load_custom_bg(path: String) -> void:
	_load_custom_bg_texture(path)
	if custom_bg_texture != null:
		custom_bg_path = path
		settings["background"] = "custom"
		_save_scores()

func _reset_custom_bg() -> void:
	custom_bg_path = ""
	custom_bg_texture = null
	if settings["background"] == "custom":
		settings["background"] = "nebula"
	_save_scores()

func _maybe_drop_powerup(at: Vector2) -> void:
	if current_mode == "duel": return
	kills_since_powerup += 1
	# NEW: pity timer forces a drop after too many dry kills
	var chance := POWERUP_DROP_CHANCE * float(active_effects["drop_mult"])
	var force := kills_since_powerup >= POWERUP_PITY_KILLS
	if not force and randf() > chance: return
	kills_since_powerup = 0
	var types := ["shield", "slowmo", "magnet", "cash"]
	powerups.append({"pos": at, "type": types[randi() % types.size()], "age": 0.0})

func _apply_powerup(ptype: String) -> void:
	_play_sfx("click")
	match ptype:
		"shield":
			shield_timer = POWERUP_DURATION
			_show_toast("Shield!")
		"slowmo":
			slowmo_timer = POWERUP_DURATION
			_show_toast("Slow-mo!")
		"magnet":
			magnet_timer = POWERUP_DURATION
			_show_toast("Magnet!")
		"cash":
			var amt := randi_range(50, 200)
			_award_money(amt)
			_show_toast("+$%d" % amt)

func _show_toast(msg: String) -> void:
	toast_message = msg
	toast_timer = 2.5

# NEW: floating text popups
func _float_text(at: Vector2, msg: String, col: Color) -> void:
	text_particles.append({
		"pos": at, "text": msg, "life": 0.8, "max": 0.8, "col": col,
	})

# NEW: combo tracking
func _add_combo() -> void:
	combo_count += 1
	combo_timer = COMBO_WINDOW
	if combo_count == 10:
		_streak_callout("RAMPAGE")
	elif combo_count == 25:
		_streak_callout("UNSTOPPABLE")
	elif combo_count == 50:
		_streak_callout("LEGENDARY")

func _streak_callout(txt: String) -> void:
	streak_callout_text = txt
	streak_callout_timer = 1.6

# NEW: single source of truth for invulnerability
func _is_invulnerable() -> bool:
	return shield_timer > 0.0 or dash_timer > 0.0 or death_slowmo_timer > 0.0

func _grant_achievement_skin(aid: String) -> void:
	for skin in SKINS:
		if skin.size() >= 7 and str(skin[6]) == aid:
			var sid: String = skin[0]
			if not sid in owned_skins:
				owned_skins.append(sid)

func _unlock_achievement(aid: String) -> void:
	if aid in achievements_unlocked: return
	achievements_unlocked.append(aid)
	_grant_achievement_skin(aid)
	var now := Time.get_ticks_msec() / 1000.0
	if now - _game_started_at > 2.0:
		var aname := aid
		for ad in ACHIEVEMENT_DEFS:
			if ad[0] == aid: aname = ad[1]; break
		_show_toast("Achievement: " + aname)
		_play_sfx("win")
	_save_scores()

func _check_achievements() -> void:
	if not "first_blood" in achievements_unlocked and int(achv_stats["kills"]) >= 1:
		_unlock_achievement("first_blood")
	if not "kill_100" in achievements_unlocked and int(achv_stats["kills"]) >= 100:
		_unlock_achievement("kill_100")
	if not "kill_1000" in achievements_unlocked and int(achv_stats["kills"]) >= 1000:
		_unlock_achievement("kill_1000")
	if not "boss_slayer" in achievements_unlocked and int(achv_stats["bosses_killed"]) >= 1:
		_unlock_achievement("boss_slayer")
	if not "speedrun_win" in achievements_unlocked and int(achv_stats["speedrun_wins"]) >= 1:
		_unlock_achievement("speedrun_win")
	if not "speedrun_fast" in achievements_unlocked and float(achv_stats["fastest_speedrun"]) < 120.0:
		_unlock_achievement("speedrun_fast")
	if not "waveless_2min" in achievements_unlocked and float(achv_stats["waveless_best"]) >= 120.0:
		_unlock_achievement("waveless_2min")
	if not "waveless_5min" in achievements_unlocked and float(achv_stats["waveless_best"]) >= 300.0:
		_unlock_achievement("waveless_5min")
	if not "duel_win" in achievements_unlocked and int(achv_stats["duel_wins"]) >= 1:
		_unlock_achievement("duel_win")
	if not "rich" in achievements_unlocked and money >= 1000:
		_unlock_achievement("rich")
	if not "shopper_5" in achievements_unlocked and owned_skins.size() >= 5:
		_unlock_achievement("shopper_5")
	if not "shopper_10" in achievements_unlocked and owned_skins.size() >= 10:
		_unlock_achievement("shopper_10")
	if not "wave_5" in achievements_unlocked and int(achv_stats["classic_best_wave"]) >= 5:
		_unlock_achievement("wave_5")
	if not "wave_10" in achievements_unlocked and int(achv_stats["classic_best_wave"]) >= 10:
		_unlock_achievement("wave_10")
	if not "wave_20" in achievements_unlocked and int(achv_stats["classic_best_wave"]) >= 20:
		_unlock_achievement("wave_20")
	if not "trail_5" in achievements_unlocked and owned_trails.size() >= 5:
		_unlock_achievement("trail_5")
	if not "trail_all" in achievements_unlocked and owned_trails.size() >= TRAILS.size() + 1:
		_unlock_achievement("trail_all")
	if not "maxed" in achievements_unlocked:
		for uid in owned_upgrades:
			var max_lvl := _get_upgrade_max_level(uid)
			if max_lvl > 0 and int(owned_upgrades[uid]) >= max_lvl:
				_unlock_achievement("maxed"); break

func _setup_audio() -> void:
	for i in 8:
		var p := AudioStreamPlayer.new(); add_child(p); sfx_players.append(p)
	default_sfx["click"] = _make_sound(660, 0.06, "sine", 0.35)
	default_sfx["hazard_warn"] = _make_sound(220, 0.22, "saw", 0.18)
	default_sfx["hazard_fire"] = _make_noise(0.15, 0.28)
	default_sfx["death"] = _make_sweep(660, 110, 0.55, 0.45, true)
	default_sfx["wave"] = _make_sound(523, 0.12, "sine", 0.22)
	default_sfx["win"] = _make_sweep(440, 880, 0.75, 0.38, false)
	# NEW: dash whoosh
	default_sfx["dash"] = _make_noise(0.10, 0.20)
	default_music = _make_music_loop()
	music_player = AudioStreamPlayer.new()
	music_player.volume_db = 0.0
	music_player.finished.connect(_restart_music_if_needed)
	add_child(music_player)
	_reload_custom_streams()
	_apply_music()

func _setup_file_dialog() -> void:
	file_dialog = FileDialog.new()
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.title = "Choose a File"
	file_dialog.size = Vector2i(900, 600)
	file_dialog.filters = PackedStringArray(["*.ogg, *.mp3, *.wav ; Audio Files"])
	file_dialog.use_native_dialog = false
	file_dialog.file_selected.connect(_on_file_selected)
	add_child(file_dialog)

func _on_file_selected(path: String) -> void:
	if file_dialog_target == "": return
	if file_dialog_target == "bg":
		_load_custom_bg(path)
		file_dialog_target = ""
		return
	if file_dialog_target == "orb":
		_load_custom_orb_texture(path)
		if custom_orb_texture != null:
			custom_orb_path = path
			if not CUSTOM_ORB_ID in owned_skins: owned_skins.append(CUSTOM_ORB_ID)
			current_skin = CUSTOM_ORB_ID
			_save_scores()
		file_dialog_target = ""
		return
	if file_dialog_target == "trail":
		_load_custom_trail_texture(path)
		if custom_trail_texture != null:
			custom_trail_path = path
			if not CUSTOM_TRAIL_ID in owned_trails: owned_trails.append(CUSTOM_TRAIL_ID)
			current_trail = CUSTOM_TRAIL_ID
			_save_scores()
		file_dialog_target = ""
		return
	var stream := _load_audio_stream(path)
	if stream == null: return
	custom_audio_paths[file_dialog_target] = path
	custom_streams[file_dialog_target] = stream
	if file_dialog_target == "music": _apply_music()
	_save_scores()

func _load_audio_stream(path: String) -> AudioStream:
	if not FileAccess.file_exists(path): return null
	match path.get_extension().to_lower():
		"ogg": return AudioStreamOggVorbis.load_from_file(path)
		"mp3": return AudioStreamMP3.load_from_file(path)
		"wav": return AudioStreamWAV.load_from_file(path)
	return null

func _reload_custom_streams() -> void:
	custom_streams.clear()
	for key in custom_audio_paths.keys():
		var stream := _load_audio_stream(custom_audio_paths[key])
		if stream != null: custom_streams[key] = stream

func _restart_music_if_needed() -> void:
	if settings["music"] and music_player and not music_player.playing: _apply_music()

func _get_sfx_stream(sname: String) -> AudioStream:
	if custom_streams.has(sname): return custom_streams[sname]
	return default_sfx.get(sname)

func _play_sfx(sname: String) -> void:
	if not settings["sfx"]: return
	var stream := _get_sfx_stream(sname)
	if stream == null: return
	var now := Time.get_ticks_msec() / 1000.0
	if _sfx_cooldowns.has(sname) and now - float(_sfx_cooldowns[sname]) < 0.04: return
	_sfx_cooldowns[sname] = now
	for p in sfx_players:
		if not (p as AudioStreamPlayer).playing:
			(p as AudioStreamPlayer).stream = stream
			(p as AudioStreamPlayer).play()
			return

func _apply_music() -> void:
	if not music_player: return
	var stream: AudioStream = custom_streams.get("music", default_music)
	if settings["music"]:
		if music_player.stream != stream: music_player.stream = stream
		if not music_player.playing: music_player.play()
	else: music_player.stop()

func _reset_audio_slot(key: String) -> void:
	custom_audio_paths.erase(key); custom_streams.erase(key)
	if key == "music": _apply_music()
	_save_scores()

func _make_sound(freq: float, duration: float, wtype: String, volume: float) -> AudioStreamWAV:
	var sr := 22050; var n := int(sr * duration)
	var data := PackedByteArray(); data.resize(n * 2)
	for i in n:
		var tt := float(i) / sr
		var phase := tt * freq * TAU
		var env := 1.0 - tt / duration; env = env * env; env *= minf(1.0, tt / 0.005)
		var s := 0.0
		match wtype:
			"sine": s = sin(phase)
			"square": s = 1.0 if sin(phase) > 0.0 else -1.0
			"saw": s = fmod(phase, TAU) / PI - 1.0
		s *= env * volume
		data.encode_s16(i * 2, int(clampf(s, -1.0, 1.0) * 32767.0))
	return _wrap_wav(data, sr)

func _make_noise(duration: float, volume: float) -> AudioStreamWAV:
	var sr := 22050; var n := int(sr * duration)
	var data := PackedByteArray(); data.resize(n * 2)
	for i in n:
		var tt := float(i) / sr
		var env := 1.0 - tt / duration; env = env * env; env *= minf(1.0, tt / 0.005)
		data.encode_s16(i * 2, int(clampf((randf() * 2.0 - 1.0) * env * volume, -1.0, 1.0) * 32767.0))
	return _wrap_wav(data, sr)

func _make_sweep(f0: float, f1: float, duration: float, volume: float, descending: bool) -> AudioStreamWAV:
	var sr := 22050; var n := int(sr * duration)
	var data := PackedByteArray(); data.resize(n * 2)
	var phase := 0.0
	for i in n:
		var tt := float(i) / sr
		var prog := tt / duration
		var freq := lerpf(f0, f1, prog)
		phase += freq * TAU / sr
		var env := 1.0 - prog if descending else prog
		env = env * env; env *= minf(1.0, tt / 0.005)
		data.encode_s16(i * 2, int(clampf(sin(phase) * env * volume, -1.0, 1.0) * 32767.0))
	return _wrap_wav(data, sr)

func _make_music_loop() -> AudioStreamWAV:
	var sr := 22050; var duration := 4.0; var n := int(sr * duration)
	var data := PackedByteArray(); data.resize(n * 2)
	var notes := [110.0, 146.83, 164.81, 146.83]
	var note_dur := duration / 4.0
	for i in n:
		var tt := float(i) / sr
		var note_idx := int(tt / note_dur) % 4
		var local_t := tt - float(note_idx) * note_dur
		var freq: float = notes[note_idx]
		var env := sin(local_t / note_dur * PI); env = env * env
		var s := sin(tt * freq * TAU) * 0.35 + sin(tt * freq * 2.0 * TAU) * 0.14 + sin(tt * freq * 3.0 * TAU) * 0.06
		var lfo := 0.75 + 0.25 * sin(tt * 0.5 * TAU)
		data.encode_s16(i * 2, int(clampf(s * env * lfo, -1.0, 1.0) * 32767.0))
	var wav := _wrap_wav(data, sr)
	wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
	wav.loop_begin = 0; wav.loop_end = n
	return wav

func _wrap_wav(data: PackedByteArray, sr: int) -> AudioStreamWAV:
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = sr; wav.stereo = false; wav.data = data
	return wav

func _input(event: InputEvent) -> void:
	if file_dialog and file_dialog.visible: return
	if fade_state != "": return
	if event is InputEventScreenTouch:
		_handle_touch(event)
		return
	if event is InputEventScreenDrag:
		_handle_touch(event)
		return
	if event is InputEventKey or event is InputEventMouseButton or event is InputEventMouseMotion:
		if joy_active or joy_p1_active or joy_p2_active:
			joy_active = false
			joy_p1_active = false
			joy_p2_active = false
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_handle_click(event.position); return
	if state == State.SHOP and event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			shop_scroll += 40.0
			return
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			shop_scroll = maxf(0.0, shop_scroll - 40.0)
			return
	if event.is_action_pressed("ui_cancel"): _handle_esc(); return
	if event.is_action_pressed("ui_accept"):
		if state == State.TUTORIAL: _dismiss_tutorial()
		elif state == State.OVER or state == State.WIN: _retry()
		elif state == State.PAUSED: _toggle_pause()
		return
	if state == State.MENU and event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_1: _transition_to(func(): _start_mode("classic"))
			KEY_2: _transition_to(func(): _start_mode("speedrun"))
			KEY_3: _transition_to(func(): _start_mode("waveless"))
			KEY_4: _transition_to(func(): _start_mode("duel"))
			KEY_5: _transition_to(_open_shop)
			KEY_6: _transition_to(_open_achievements)
			KEY_7: _transition_to(func(): _open_settings(State.MENU))

func _handle_touch(event: InputEvent) -> void:
	if state != State.PLAY: return
	if current_mode == "duel":
		if event is InputEventScreenTouch:
			if event.pressed:
				if event.position.x < screen.x * 0.5:
					if not joy_p1_active:
						joy_p1_active = true; joy_p1_index = event.index
						joy_p1_base = event.position; joy_p1_vec = Vector2.ZERO
				else:
					if not joy_p2_active:
						joy_p2_active = true; joy_p2_index = event.index
						joy_p2_base = event.position; joy_p2_vec = Vector2.ZERO
			else:
				if event.index == joy_p1_index: joy_p1_active = false; joy_p1_index = -1; joy_p1_vec = Vector2.ZERO
				if event.index == joy_p2_index: joy_p2_active = false; joy_p2_index = -1; joy_p2_vec = Vector2.ZERO
		elif event is InputEventScreenDrag:
			if event.index == joy_p1_index:
				var d: Vector2 = event.position - joy_p1_base
				if d.length() > JOY_RADIUS: d = d.normalized() * JOY_RADIUS
				joy_p1_vec = d / JOY_RADIUS
			elif event.index == joy_p2_index:
				var d: Vector2 = event.position - joy_p2_base
				if d.length() > JOY_RADIUS: d = d.normalized() * JOY_RADIUS
				joy_p2_vec = d / JOY_RADIUS
		return
	var want_joy := bool(settings["arrow_keys"])
	if event is InputEventScreenTouch:
		if event.pressed:
			if want_joy:
				if not joy_active:
					joy_active = true; joy_index = event.index
					joy_base = event.position; joy_vec = Vector2.ZERO
					touch_to_go = false
			else:
				touch_target = event.position
				touch_to_go = true
		else:
			if joy_active and event.index == joy_index:
				joy_active = false; joy_index = -1; joy_vec = Vector2.ZERO
	elif event is InputEventScreenDrag:
		if joy_active and event.index == joy_index:
			var d: Vector2 = event.position - joy_base
			if d.length() > JOY_RADIUS: d = d.normalized() * JOY_RADIUS
			joy_vec = d / JOY_RADIUS
		elif touch_to_go:
			touch_target = event.position

func _handle_click(p: Vector2) -> void:
	match state:
		State.MENU:
			for mode in menu_button_rects:
				if menu_button_rects[mode].has_point(p):
					_play_sfx("click")
					match mode:
						"settings": _transition_to(func(): _open_settings(State.MENU))
						"shop": _transition_to(_open_shop)
						"achievements": _transition_to(_open_achievements)
						"quit":
							# NEW: save before quit
							_save_scores()
							get_tree().quit()
						_: _transition_to(func(): _start_mode(mode))
					return
		State.CLASSIC_SLOTS:
			for item in classic_slot_rects:
				if (item["rect"] as Rect2).has_point(p):
					_play_sfx("click")
					_transition_to(func(): _start_classic_from_slot(item["slot"], true))
					return
			for item in classic_new_rects:
				if (item["rect"] as Rect2).has_point(p):
					_play_sfx("click")
					_transition_to(func(): _start_classic_from_slot(item["slot"], false))
					return
			if classic_back_rect.has_point(p):
				_play_sfx("click"); _transition_to(func(): state = State.MENU); _set_mouse_visible(true)
		State.SHOP:
			for key in shop_tab_rects:
				if shop_tab_rects[key].has_point(p):
					_play_sfx("click"); shop_current_tab = key; return
			for item in shop_item_rects:
				if (item["rect"] as Rect2).has_point(p):
					_play_sfx("click")
					match item["type"]:
						"skin": _buy_or_equip_skin(item["index"])
						"trail": _buy_or_equip_trail(item["index"])
						"upgrade": _buy_upgrade(item["index"])
						"no_tier": _buy_no_tier(item["index"])
						"custom_orb": _buy_custom_orb()
						"custom_trail": _buy_custom_trail()
					return
			if shop_back_rect.has_point(p):
				_play_sfx("click"); _transition_to(func(): state = State.MENU); _set_mouse_visible(true)
		State.ACHIEVEMENTS:
			if achv_back_rect.has_point(p):
				_play_sfx("click"); _transition_to(func(): state = State.MENU); _set_mouse_visible(true)
		State.TUTORIAL:
			if tutorial_btn.size.x > 0 and tutorial_btn.has_point(p):
				_play_sfx("click"); _dismiss_tutorial()
		State.SETTINGS:
			for key in audio_refresh_rects:
				if audio_refresh_rects[key].has_point(p):
					_play_sfx("click"); _reset_audio_slot(key); return
			for key in audio_row_rects:
				if audio_row_rects[key].has_point(p):
					_play_sfx("click"); _open_file_dialog(key); return
			for key in settings_rows:
				if settings_rows[key].has_point(p):
					if key == "background":
						if bg_refresh_rect.size.x > 0 and bg_refresh_rect.has_point(p):
							_play_sfx("click"); _reset_custom_bg(); return
						_play_sfx("click"); _cycle_background(); return
					else:
						settings[key] = not settings[key]
						if key == "music": _apply_music()
						_save_scores()
						_play_sfx("click"); return
			if reset_tut_btn.size.x > 0 and reset_tut_btn.has_point(p):
				_play_sfx("click")
				tutorial_seen = {"classic": false, "speedrun": false, "waveless": false, "duel": false}
				_save_scores(); return
			if settings_back_rect.has_point(p):
				_play_sfx("click"); _transition_to(func(): state = _settings_origin); _set_mouse_visible(true)
		State.PAUSED:
			if overlay_btn_left.has_point(p): _play_sfx("click"); _toggle_pause()
			elif overlay_btn_mid.has_point(p): _play_sfx("click"); _transition_to(func(): _open_settings(State.PAUSED))
			elif overlay_btn_right.has_point(p): _play_sfx("click"); _transition_to(_go_to_menu)
		State.OVER, State.WIN:
			if overlay_btn_left.has_point(p): _play_sfx("click"); _transition_to(_retry)
			elif overlay_btn_right.has_point(p): _play_sfx("click"); _transition_to(_go_to_menu)

func _handle_esc() -> void:
	if fade_state != "": return
	match state:
		State.PLAY: _toggle_pause()
		State.PAUSED: _toggle_pause()
		State.OVER, State.WIN: _transition_to(_go_to_menu)
		State.TUTORIAL: _dismiss_tutorial()
		State.SHOP: _transition_to(func(): state = State.MENU); _set_mouse_visible(true)
		State.ACHIEVEMENTS: _transition_to(func(): state = State.MENU); _set_mouse_visible(true)
		State.CLASSIC_SLOTS: _transition_to(func(): state = State.MENU); _set_mouse_visible(true)
		State.SETTINGS:
			if file_dialog_target != "": file_dialog_target = ""
			_transition_to(func(): state = _settings_origin)

func _open_settings(from_state: int) -> void:
	_settings_origin = from_state; state = State.SETTINGS; _set_mouse_visible(true)

func _open_shop() -> void:
	state = State.SHOP; shop_current_tab = "skins"; _set_mouse_visible(true)

func _open_achievements() -> void:
	state = State.ACHIEVEMENTS
	_set_mouse_visible(true)

func _open_classic_slots() -> void:
	state = State.CLASSIC_SLOTS
	_set_mouse_visible(true)

func _buy_or_equip_skin(index: int) -> void:
	if index < 0 or index >= SKINS.size(): return
	var skin: Array = SKINS[index]
	var sid: String = skin[0]; var price: int = skin[2]
	var achv_lock := _skin_achv_lock(skin)
	if achv_lock != "" and not achv_lock in achievements_unlocked:
		return
	if sid in owned_skins:
		current_skin = sid; _save_scores()
	elif money >= price:
		money -= price; owned_skins.append(sid); current_skin = sid; _save_scores()

func _buy_or_equip_trail(index: int) -> void:
	if index < 0 or index >= TRAILS.size(): return
	var trail: Array = TRAILS[index]
	var tid: String = trail[0]; var price: int = trail[2]
	var achv_lock := _trail_achv_lock(trail)
	if achv_lock != "" and not achv_lock in achievements_unlocked:
		return
	if tid in owned_trails:
		current_trail = tid; _save_scores()
	elif money >= price:
		money -= price; owned_trails.append(tid); current_trail = tid; _save_scores()

func _buy_upgrade(index: int) -> void:
	if index < 0 or index >= UPGRADES.size(): return
	var upg: Array = UPGRADES[index]
	var uid: String = upg[0]
	var prices: Array = upg[2]
	var current_level: int = int(owned_upgrades.get(uid, 0))
	if current_level >= prices.size(): return
	var next_price: int = int(prices[current_level])
	if money >= next_price:
		money -= next_price
		owned_upgrades[uid] = current_level + 1
		_compute_active_effects()
		_save_scores()

func _buy_no_tier(index: int) -> void:
	if index < 0 or index >= NO_TIER_UPGRADES.size(): return
	var upg: Array = NO_TIER_UPGRADES[index]
	var uid: String = upg[0]
	if bool(no_tier_owned.get(uid, false)): return
	var price: int = int(upg[2])
	if money >= price:
		money -= price
		no_tier_owned[uid] = true
		if uid == "trail_unlock":
			for tr in TRAILS:
				if not tr[0] in owned_trails: owned_trails.append(tr[0])
		_compute_active_effects()
		_save_scores()

func _buy_custom_orb() -> void:
	if custom_orb_texture != null:
		if not CUSTOM_ORB_ID in owned_skins: owned_skins.append(CUSTOM_ORB_ID)
		current_skin = CUSTOM_ORB_ID
		_save_scores()
		return
	if CUSTOM_ORB_ID in owned_skins:
		_open_file_dialog("orb")
		return
	if money < CUSTOM_ORB_PRICE: return
	money -= CUSTOM_ORB_PRICE
	owned_skins.append(CUSTOM_ORB_ID)
	_open_file_dialog("orb")

func _buy_custom_trail() -> void:
	if custom_trail_texture != null:
		if not CUSTOM_TRAIL_ID in owned_trails: owned_trails.append(CUSTOM_TRAIL_ID)
		current_trail = CUSTOM_TRAIL_ID
		_save_scores()
		return
	if CUSTOM_TRAIL_ID in owned_trails:
		_open_file_dialog("trail")
		return
	if money < CUSTOM_TRAIL_PRICE: return
	money -= CUSTOM_TRAIL_PRICE
	owned_trails.append(CUSTOM_TRAIL_ID)
	_open_file_dialog("trail")

func _start_mode(mode: String) -> void:
	if mode == "classic":
		_open_classic_slots()
		return
	current_mode = mode; _reset_play()
	if not tutorial_seen.get(mode, false):
		tutorial_mode = mode; state = State.TUTORIAL; _set_mouse_visible(true)
	else: state = State.PLAY; _set_mouse_visible(false)

func _start_classic_from_slot(slot_n: int, use_checkpoint: bool) -> void:
	if slot_n < 1 or slot_n > 5: return
	current_slot = slot_n
	classic_checkpoint = int(classic_checkpoints[slot_n - 1])
	if not use_checkpoint:
		classic_checkpoint = 0
		classic_checkpoints[slot_n - 1] = 0
	current_mode = "classic"
	_reset_play()
	if not tutorial_seen.get("classic", false):
		tutorial_mode = "classic"; state = State.TUTORIAL; _set_mouse_visible(true)
	else: state = State.PLAY; _set_mouse_visible(false)
	_save_scores()

func _dismiss_tutorial() -> void:
	tutorial_seen[tutorial_mode] = true; _save_scores()
	state = State.PLAY; _set_mouse_visible(false)

func _retry() -> void:
	if current_mode == "classic":
		_start_classic_from_slot(current_slot, true)
	else:
		_start_mode(current_mode)

func _go_to_menu() -> void:
	_save_scores()
	state = State.MENU; _set_mouse_visible(true)
	enemies.clear(); hazards.clear(); particles.clear(); crystals.clear(); dot_trail.clear(); powerups.clear()
	dash_trail.clear(); text_particles.clear()
	shake = 0.0; dot_pos = play_rect.get_center(); key_vel = Vector2.ZERO
	joy_active = false; touch_to_go = false
	joy_p1_active = false; joy_p2_active = false

func _toggle_pause() -> void:
	if state == State.PLAY: state = State.PAUSED; _set_mouse_visible(true)
	elif state == State.PAUSED: state = State.PLAY; _set_mouse_visible(false)

func _reset_play() -> void:
	enemies.clear(); hazards.clear(); particles.clear(); crystals.clear(); dot_trail.clear(); powerups.clear()
	dash_trail.clear(); text_particles.clear()
	shield_timer = float(active_effects["shield_start"])
	slowmo_timer = 0.0; magnet_timer = 0.0
	_waveless_boss_timer = 0.0
	wave = 1; to_spawn = 0; kills_this_run = 0
	spawn_timer = 0.0; wave_delay_timer = 0.0; wave_announce_timer = 0.0
	run_time = 0.0; speedrun_time = 0.0; waveless_time = 0.0
	_hazard_timer = 1.0; shake = 0.0
	dot_pos = play_rect.get_center(); key_vel = Vector2.ZERO
	# NEW: reset dash + combo state
	dash_timer = 0.0; dash_cooldown = 0.0; dash_dir = Vector2.ZERO
	combo_count = 0; combo_timer = 0.0; hitstop_timer = 0.0
	death_slowmo_timer = 0.0; kills_since_powerup = 0
	streak_callout_text = ""; streak_callout_timer = 0.0
	revives_remaining = clampi(int(active_effects["revives"]), 0, 3)
	_revive_regen_timer = 0.0
	_revive_regen_interval = 45.0
	if bool(no_tier_owned.get("revive_regen_2", false)): _revive_regen_interval = 22.5
	p1_crystals = 0; p2_crystals = 0
	var extra: int = int(active_effects["extra_lives"])
	p1_lives = DUEL_LIVES_START + extra
	p2_lives = DUEL_LIVES_START + extra
	duel_phase = "racing"; duel_charge_timer = 0.0; duel_beam_timer = 0.0; duel_winner = ""
	p1_vel = Vector2.ZERO; p2_vel = Vector2.ZERO
	joy_active = false; touch_to_go = false; joy_vec = Vector2.ZERO
	joy_p1_active = false; joy_p2_active = false; joy_p1_vec = Vector2.ZERO; joy_p2_vec = Vector2.ZERO
	if current_mode == "waveless":
		_inf_enemy_timer = 0.2
	elif current_mode == "duel":
		_start_duel()
	else:
		if current_mode == "classic" and classic_checkpoint > 0:
			wave = classic_checkpoint
		else:
			wave = 1
		_start_wave()

func _start_wave() -> void:
	if current_mode == "classic" and wave > 1 and wave % CHECKPOINT_INTERVAL == 0:
		classic_checkpoint = wave
		classic_checkpoints[current_slot - 1] = wave
		_save_scores()
	if current_mode == "classic" and wave > 1 and wave % BOSS_WAVE_INTERVAL == 0:
		to_spawn = 0; spawn_timer = 0.0; wave_delay_timer = 0.0
		wave_announce_timer = 1.5; _hazard_timer = WAVE_START_DELAY
		_play_sfx("wave")
		_spawn_boss()
		return
	to_spawn = mini(wave, 6); spawn_timer = 0.0; wave_delay_timer = 0.0
	wave_announce_timer = 0.9; _hazard_timer = WAVE_START_DELAY; _play_sfx("wave")

func _hazard_interval() -> float:
	return maxf(0.9, 2.2 - run_time * 0.012) + randf_range(-0.2, 0.2)

func _start_duel() -> void:
	machine_pos = play_rect.get_center()
	p1_pos = Vector2(play_rect.position.x + 60.0, machine_pos.y)
	p2_pos = Vector2(play_rect.end.x - 60.0, machine_pos.y)
	crystals.clear(); crystal_spawn_timer = 0.4; duel_laser_end = Vector2.ZERO

func _spawn_duel_crystal() -> void:
	if crystals.size() >= DUEL_MAX_CRYSTALS: return
	var margin := DUEL_CRYSTAL_RADIUS + 18.0
	var x := randf_range(play_rect.position.x + margin, play_rect.end.x - margin)
	var y := randf_range(play_rect.position.y + margin, play_rect.end.y - margin)
	crystals.append({"pos": Vector2(x, y), "age": 0.0})

func _reset_duel_round() -> void:
	p1_crystals = 0; p2_crystals = 0
	p1_pos = Vector2(play_rect.position.x + 60.0, machine_pos.y)
	p2_pos = Vector2(play_rect.end.x - 60.0, machine_pos.y)
	p1_vel = Vector2.ZERO; p2_vel = Vector2.ZERO
	crystals.clear(); crystal_spawn_timer = 0.4
	duel_phase = "racing"; duel_charge_timer = 0.0
	duel_winner = ""; duel_laser_end = Vector2.ZERO

func _process(delta: float) -> void:
	t += delta
	_process_fade(delta)
	if shake > 0.0: shake = max(0.0, shake - delta * 30.0)
	if toast_timer > 0.0: toast_timer = max(0.0, toast_timer - delta)
	if _money_flash > 0.0: _money_flash = max(0.0, _money_flash - delta)
	if streak_callout_timer > 0.0: streak_callout_timer = max(0.0, streak_callout_timer - delta)
	if combo_timer > 0.0:
		combo_timer = max(0.0, combo_timer - delta)
		if combo_timer <= 0.0: combo_count = 0
	_achv_check_timer += delta
	if _achv_check_timer >= 0.5:
		_achv_check_timer = 0.0
		_check_achievements()
	if money != _prev_money:
		_money_flash = 0.6
		_prev_money = money
	match state:
		State.PLAY:
			if wave_announce_timer > 0.0: wave_announce_timer = max(0.0, wave_announce_timer - delta)
			# NEW: hit-stop and death slow-mo gate the tick
			if hitstop_timer > 0.0:
				hitstop_timer = max(0.0, hitstop_timer - delta)
			elif death_slowmo_timer > 0.0:
				death_slowmo_timer = max(0.0, death_slowmo_timer - delta)
				_update_particles(delta * DEATH_SLOWMO_SCALE)
				_update_text_particles(delta * DEATH_SLOWMO_SCALE)
				_update_dash_trail(delta * DEATH_SLOWMO_SCALE)
				if death_slowmo_timer <= 0.0:
					_finalize_death()
			else:
				run_time += delta
				if current_mode == "speedrun": speedrun_time += delta
				elif current_mode == "waveless": waveless_time += delta
				_update_particles(delta); _update_text_particles(delta); _update_dash_trail(delta)
				_game_tick(delta)
		State.OVER, State.WIN:
			_update_particles(delta); _update_text_particles(delta); _update_dash_trail(delta)
	queue_redraw()

# NEW: text particle updater
func _update_text_particles(delta: float) -> void:
	var keep: Array = []
	for tp in text_particles:
		tp["life"] = float(tp["life"]) - delta
		if float(tp["life"]) > 0.0:
			tp["pos"] = (tp["pos"] as Vector2) + Vector2(0, -50.0 * delta)
			keep.append(tp)
	text_particles = keep

# NEW: dash trail updater
func _update_dash_trail(delta: float) -> void:
	var keep: Array = []
	for dt in dash_trail:
		dt["life"] = float(dt["life"]) - delta
		if float(dt["life"]) > 0.0: keep.append(dt)
	dash_trail = keep

func _game_tick(delta: float) -> void:
	if current_mode == "duel": _tick_duel(delta); return
	# NEW: tick dash cooldown / timers
	if dash_cooldown > 0.0: dash_cooldown = max(0.0, dash_cooldown - delta)
	if dash_timer > 0.0:
		dash_timer = max(0.0, dash_timer - delta)
		# dash movement overrides normal movement
		dot_pos += dash_dir * DASH_SPEED * delta
		dash_trail.append({"pos": dot_pos, "life": 0.25})
	# NEW: trigger dash on Space (ui_accept) when not on cooldown
	if dash_timer <= 0.0 and dash_cooldown <= 0.0 and Input.is_action_just_pressed("ui_accept"):
		var dd := Vector2.ZERO
		if joy_active:
			dd = joy_vec.normalized() if joy_vec.length() > 0.1 else Vector2.ZERO
		elif bool(settings["arrow_keys"]):
			if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A): dd.x -= 1.0
			if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D): dd.x += 1.0
			if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W): dd.y -= 1.0
			if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S): dd.y += 1.0
		if dd.length() < 0.1:
			dd = (get_global_mouse_position() - dot_pos)
			if dd.length() < 0.1: dd = Vector2.RIGHT
		dash_dir = dd.normalized()
		dash_timer = DASH_TIME
		dash_cooldown = DASH_COOLDOWN
		_play_sfx("dash")
		shake = max(shake, 4.0 if settings["screen_shake"] else 0.0)
	var move_speed: float = KEY_SPEED * float(active_effects["speed_mult"])
	if dash_timer > 0.0:
		# already moved above; skip normal movement this frame
		pass
	elif joy_active:
		var speed_cap: float = MOUSE_SPEED_CAP * float(active_effects["speed_mult"])
		dot_pos += joy_vec * speed_cap * delta
		key_vel = Vector2.ZERO
	elif touch_to_go:
		var diff := touch_target - dot_pos
		var dist := diff.length()
		var max_move := MOUSE_SPEED_CAP * float(active_effects["speed_mult"]) * delta
		if dist > max_move: diff = diff.normalized() * max_move
		dot_pos += diff; key_vel = Vector2.ZERO
	elif bool(settings["arrow_keys"]):
		var dir := Vector2.ZERO
		if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A): dir.x -= 1.0
		if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D): dir.x += 1.0
		if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W): dir.y -= 1.0
		if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S): dir.y += 1.0
		if dir.length() > 0.0: dir = dir.normalized()
		key_vel = key_vel.move_toward(dir * move_speed, KEY_ACCEL * delta)
		dot_pos += key_vel * delta
	else:
		var target := get_global_mouse_position()
		var diff := target - dot_pos
		var dist := diff.length()
		var max_move := MOUSE_SPEED_CAP * float(active_effects["speed_mult"]) * delta
		if dist > max_move: diff = diff.normalized() * max_move
		dot_pos += diff; key_vel = Vector2.ZERO
	dot_pos.x = clampf(dot_pos.x, play_rect.position.x + DOT_RADIUS, play_rect.end.x - DOT_RADIUS)
	dot_pos.y = clampf(dot_pos.y, play_rect.position.y + DOT_RADIUS, play_rect.end.y - DOT_RADIUS)
	if not joy_active and not touch_to_go and not bool(settings["arrow_keys"]):
		Input.warp_mouse(dot_pos)

	dot_trail.append({"pos": dot_pos, "age": 0.0})
	for i in range(dot_trail.size() - 1, -1, -1):
		var tr: Dictionary = dot_trail[i]
		tr["age"] = float(tr["age"]) + delta
		if float(tr["age"]) > TRAIL_LIFE: dot_trail.remove_at(i)

	if shield_timer > 0.0: shield_timer = max(0.0, shield_timer - delta)
	if slowmo_timer > 0.0: slowmo_timer = max(0.0, slowmo_timer - delta)
	if magnet_timer > 0.0: magnet_timer = max(0.0, magnet_timer - delta)

	var max_rev: int = int(active_effects["max_revives"])
	if bool(no_tier_owned.get("revive_regen", false)) and revives_remaining < max_rev:
		_revive_regen_timer += delta
		if _revive_regen_timer >= _revive_regen_interval:
			_revive_regen_timer = 0.0
			revives_remaining += 1
			_show_toast("Revive regenerated!")

	if magnet_timer > 0.0:
		for pu in powerups:
			var md: Vector2 = dot_pos - pu["pos"]
			if md.length() < POWERUP_MAGNET_RANGE and md.length() > 1.0:
				pu["pos"] += md.normalized() * POWERUP_MAGNET_SPEED * delta

	var cash_aura: float = float(active_effects["cash_aura"])
	var keep_pu: Array = []
	for pu in powerups:
		pu["age"] = float(pu["age"]) + delta
		if float(pu["age"]) >= POWERUP_LIFETIME: continue
		var pd: float = (pu["pos"] as Vector2).distance_to(dot_pos)
		if pd < POWERUP_PICKUP_RADIUS or (cash_aura > 0.0 and str(pu["type"]) == "cash" and pd < cash_aura):
			_apply_powerup(str(pu["type"]))
			_burst(pu["pos"], Color(1, 1, 1), 15)
			continue
		keep_pu.append(pu)
	powerups = keep_pu

	_tick_hazards(delta)
	if state != State.PLAY: return

	var enemy_speed_mult := 1.0
	if slowmo_timer > 0.0: enemy_speed_mult = 0.4

	var survivors: Array = []
	for e in enemies:
		if float(e.get("hit_cd", 0.0)) > 0.0:
			e["hit_cd"] = maxf(0.0, float(e["hit_cd"]) - delta)
		var to_dot: Vector2 = dot_pos - e["pos"]
		var spd: float = float(e["speed"]) * enemy_speed_mult
		if float(active_effects["slow_field"]) > 0.0 and (e["pos"] as Vector2).distance_to(dot_pos) < 120.0:
			spd *= 1.0 - float(active_effects["slow_field"])
		if to_dot.length() > 0.01:
			e["pos"] += to_dot.normalized() * spd * delta
		# NEW: near-miss reward
		var d_enemy := (e["pos"] as Vector2).distance_to(dot_pos)
		if d_enemy < float(e["radius"]) + DOT_RADIUS + NEAR_MISS_RADIUS and d_enemy > float(e["radius"]) + DOT_RADIUS and not _is_invulnerable():
			if not e.get("near_miss", false):
				e["near_miss"] = true
				_award_money(NEAR_MISS_REWARD)
				_float_text(dot_pos + Vector2(0, -24), "CLOSE!", Color(1, 0.9, 0.4))
		if d_enemy < float(e["radius"]) + DOT_RADIUS and not _is_invulnerable():
			_die(); return
		survivors.append(e)
	enemies = survivors

	if current_mode == "waveless":
		_inf_enemy_timer -= delta
		if _inf_enemy_timer <= 0.0 and enemies.size() < ENEMY_CAP:
			_inf_enemy_timer = max(0.3, 1.5 - waveless_time * 0.02); _spawn_enemy()
		if waveless_time >= WAVELESS_BOSS_TIME:
			var has_boss := false
			for e in enemies:
				if e["type"] == "boss":
					has_boss = true
					break
			if not has_boss:
				_waveless_boss_timer -= delta
				if _waveless_boss_timer <= 0.0:
					_spawn_boss()
					_waveless_boss_timer = WAVELESS_BOSS_COOLDOWN
		return

	if to_spawn > 0:
		spawn_timer -= delta
		if spawn_timer <= 0.0:
			spawn_timer = SPAWN_INTERVAL; to_spawn -= 1
			if enemies.size() < ENEMY_CAP: _spawn_enemy()
		return

	if enemies.is_empty():
		wave_delay_timer += delta
		if wave_delay_timer >= WAVE_DELAY:
			if current_mode == "speedrun" and wave >= SPEEDRUN_TARGET: _win_speedrun(); return
			if current_mode == "classic": _award_money(20)
			wave += 1; _start_wave()

func _tick_duel(delta: float) -> void:
	if duel_phase == "beam":
		duel_beam_timer -= delta
		if duel_beam_timer <= 0.0: _reset_duel_round()
		return
	if duel_phase == "done": return
	var duel_speed: float = KEY_SPEED * float(active_effects["speed_mult"])
	var d1 := Vector2.ZERO
	if Input.is_action_pressed("ui_left"): d1.x -= 1.0
	if Input.is_action_pressed("ui_right"): d1.x += 1.0
	if Input.is_action_pressed("ui_up"): d1.y -= 1.0
	if Input.is_action_pressed("ui_down"): d1.y += 1.0
	if d1.length() > 0.0: d1 = d1.normalized()
	if joy_p1_active:
		p1_vel = joy_p1_vec * duel_speed
	else:
		p1_vel = p1_vel.move_toward(d1 * duel_speed, KEY_ACCEL * delta)
	p1_pos += p1_vel * delta
	var d2 := Vector2.ZERO
	if Input.is_key_pressed(KEY_A): d2.x -= 1.0
	if Input.is_key_pressed(KEY_D): d2.x += 1.0
	if Input.is_key_pressed(KEY_W): d2.y -= 1.0
	if Input.is_key_pressed(KEY_S): d2.y += 1.0
	if d2.length() > 0.0: d2 = d2.normalized()
	if joy_p2_active:
		p2_vel = joy_p2_vec * duel_speed
	else:
		p2_vel = p2_vel.move_toward(d2 * duel_speed, KEY_ACCEL * delta)
	p2_pos += p2_vel * delta
	var r := DUEL_PLAYER_RADIUS
	p1_pos.x = clampf(p1_pos.x, play_rect.position.x + r, play_rect.end.x - r)
	p1_pos.y = clampf(p1_pos.y, play_rect.position.y + r, play_rect.end.y - r)
	p2_pos.x = clampf(p2_pos.x, play_rect.position.x + r, play_rect.end.x - r)
	p2_pos.y = clampf(p2_pos.y, play_rect.position.y + r, play_rect.end.y - r)
	if duel_phase == "racing":
		crystal_spawn_timer -= delta
		if crystal_spawn_timer <= 0.0 and crystals.size() < DUEL_MAX_CRYSTALS:
			_spawn_duel_crystal()
			crystal_spawn_timer = randf_range(DUEL_SPAWN_MIN, DUEL_SPAWN_MAX)
		var j := crystals.size() - 1
		while j >= 0:
			var c: Dictionary = crystals[j]
			c["age"] = float(c["age"]) + delta
			if float(c["age"]) >= DUEL_CRYSTAL_LIFETIME:
				_burst(c["pos"], Color(0.7, 0.4, 1.0), 10); crystals.remove_at(j)
			j -= 1
		var i := crystals.size() - 1
		while i >= 0:
			if i >= crystals.size(): i -= 1; continue
			var c: Dictionary = crystals[i]
			var cp: Vector2 = c["pos"]
			var rd := p1_pos.distance_to(cp); var bd := p2_pos.distance_to(cp)
			if rd < DUEL_PICKUP_RADIUS and bd < DUEL_PICKUP_RADIUS:
				if rd <= bd: p1_crystals += 1; _burst(cp, Color(1, 0.3, 0.3), 14)
				else: p2_crystals += 1; _burst(cp, Color(0.3, 0.6, 1.0), 14)
				crystals.remove_at(i); _play_sfx("click")
			elif rd < DUEL_PICKUP_RADIUS:
				p1_crystals += 1; _burst(cp, Color(1, 0.3, 0.3), 14)
				crystals.remove_at(i); _play_sfx("click")
			elif bd < DUEL_PICKUP_RADIUS:
				p2_crystals += 1; _burst(cp, Color(0.3, 0.6, 1.0), 14)
				crystals.remove_at(i); _play_sfx("click")
			i -= 1
		if p1_crystals >= DUEL_TARGET:
			duel_phase = "charging"; duel_winner = "red"
			duel_charge_timer = DUEL_CHARGE_TIME; _play_sfx("wave")
		elif p2_crystals >= DUEL_TARGET:
			duel_phase = "charging"; duel_winner = "blue"
			duel_charge_timer = DUEL_CHARGE_TIME; _play_sfx("wave")
	elif duel_phase == "charging":
		duel_charge_timer -= delta
		duel_laser_end = p1_pos if duel_winner == "blue" else p2_pos
		if duel_charge_timer <= 0.0:
			var target := p1_pos if duel_winner == "blue" else p2_pos
			var target_is_red := duel_winner == "blue"
			_burst(target, Color(1, 0.95, 0.6), 50)
			shake = 22.0 if settings["screen_shake"] else 0.0
			_play_sfx("death")
			if target_is_red: p1_lives -= 1
			else: p2_lives -= 1
			if p1_lives <= 0 or p2_lives <= 0:
				duel_phase = "done"; state = State.OVER; _set_mouse_visible(true)
				if p1_lives > 0 and p2_lives <= 0:
					achv_stats["duel_wins"] = int(achv_stats["duel_wins"]) + 1
				elif p2_lives > 0 and p1_lives <= 0:
					achv_stats["duel_wins"] = int(achv_stats["duel_wins"]) + 1
			else:
				duel_phase = "beam"; duel_beam_timer = DUEL_BEAM_TIME

func _tick_hazards(delta: float) -> void:
	if current_mode == "duel":
		var keep_d: Array = []
		for h in hazards:
			if h["state"] == "warn":
				h["warn"] = float(h["warn"]) - delta
				if float(h["warn"]) <= 0.0:
					h["state"] = "fire"; h["fire"] = _fire_time(h["type"]); _apply_hazard(h)
			elif h["state"] == "fire":
				if h["type"] == "saw": _tick_saw(h)
				elif h["type"] == "shock": _tick_shock(h)
				else: _tick_stationary_hazard(h)
				h["fire"] = float(h["fire"]) - delta
				if float(h["fire"]) <= 0.0: continue
			keep_d.append(h)
		hazards = keep_d
		return
	_hazard_timer -= delta
	if _hazard_timer <= 0.0:
		_spawn_hazard(); _hazard_timer = _hazard_interval()
	var keep: Array = []
	for h in hazards:
		if h["state"] == "warn":
			h["warn"] = float(h["warn"]) - delta
			if float(h["warn"]) <= 0.0:
				h["state"] = "fire"; h["fire"] = _fire_time(h["type"]); _apply_hazard(h)
				if state != State.PLAY: return
		elif h["state"] == "fire":
			if h["type"] == "saw": _tick_saw(h)
			elif h["type"] == "shock": _tick_shock(h)
			else: _tick_stationary_hazard(h)
			if state != State.PLAY: return
			h["fire"] = float(h["fire"]) - delta
			if float(h["fire"]) <= 0.0: continue
		keep.append(h)
	hazards = keep

func _fire_time(htype: String) -> float:
	var m: float = float(active_effects["fire_mult"])
	match htype:
		"laser": return LASER_FIRE * m
		"mine": return MINE_FIRE * m
		"meteor": return METEOR_FIRE * m
		"pulse": return PULSE_FIRE * m
		"bomb": return BOMB_FIRE * m
		"saw": return SAW_TRAVEL * m
		"shock": return SHOCK_FIRE * m
	return 0.4

func _cluster_center() -> Vector2:
	if enemies.is_empty(): return dot_pos
	var candidates: Array = []
	var centroid := Vector2.ZERO
	for e in enemies:
		candidates.append(e["pos"] as Vector2); centroid += e["pos"]
	centroid /= float(enemies.size()); candidates.append(centroid)
	for i in 6:
		candidates.append(centroid + Vector2(randf_range(-80, 80), randf_range(-80, 80)))
	var best_pos: Vector2 = candidates[0]; var best_count := 0
	for c in candidates:
		var count := 0
		for e in enemies:
			if (c as Vector2).distance_to(e["pos"]) < 90.0: count += 1
		if count > best_count: best_count = count; best_pos = c
	return best_pos

func _predict_meet(_wt: float) -> Vector2:
	var c := _cluster_center()
	var to_player := dot_pos - c
	if to_player.length() < 0.01: return c
	if enemies.size() == 1 and enemies[0]["type"] == "boss":
		return c
	return c + to_player * (0.4 + float(active_effects["lead_bonus"]))

func _predict_enemy_meet(warning_time: float, lead_factor: float = 0.7) -> Vector2:
	if enemies.is_empty(): return dot_pos
	var c := _cluster_center()
	var total_vel := Vector2.ZERO; var count := 0
	for e in enemies:
		var ep: Vector2 = e["pos"]
		if ep.distance_to(c) < 140.0:
			var to_dot: Vector2 = dot_pos - ep
			if to_dot.length() > 0.01:
				total_vel += to_dot.normalized() * float(e["speed"]); count += 1
	if count == 0: return c
	return c + (total_vel / float(count)) * warning_time * (lead_factor + float(active_effects["lead_bonus"]))

func _damage_enemy(e: Dictionary) -> bool:
	if e["type"] == "boss" and float(e.get("hit_cd", 0.0)) > 0.0: return false
	if e["type"] == "boss": e["hit_cd"] = ENEMY_HIT_COOLDOWN
	e["hp"] = int(e.get("hp", 1)) - 1
	return int(e["hp"]) <= 0

func _spawn_hazard() -> void:
	_play_sfx("hazard_warn")
	var r := randf()
	if r < 0.20: _spawn_laser()
	elif r < 0.34: _spawn_minefield()
	elif r < 0.46: _spawn_meteor()
	elif r < 0.58: _spawn_pulse()
	elif r < 0.72: _spawn_bomb()
	elif r < 0.90: _spawn_saw()
	else: _spawn_shock()

func _spawn_laser() -> void:
	var center := _predict_meet(LASER_WARN)
	var h_score := 0; var v_score := 0
	for e in enemies:
		if abs((e["pos"] as Vector2).y - center.y) < LASER_BAND: h_score += 1
		if abs((e["pos"] as Vector2).x - center.x) < LASER_BAND: v_score += 1
	var axis := "h" if h_score >= v_score else "v"
	var pos := center.y if axis == "h" else center.x
	if axis == "h": pos = clampf(pos, play_rect.position.y + LASER_BAND, play_rect.end.y - LASER_BAND)
	else: pos = clampf(pos, play_rect.position.x + LASER_BAND, play_rect.end.x - LASER_BAND)
	hazards.append({"type": "laser", "state": "warn",
		"warn": LASER_WARN, "fire": 0.0, "data": {"axis": axis, "pos": pos}})

func _spawn_minefield() -> void:
	var center := _predict_meet(MINE_WARN)
	for i in randi_range(3, 5):
		var p := center + Vector2(randf_range(-60, 60), randf_range(-60, 60))
		p.x = clampf(p.x, play_rect.position.x + MINE_RADIUS, play_rect.end.x - MINE_RADIUS)
		p.y = clampf(p.y, play_rect.position.y + MINE_RADIUS, play_rect.end.y - MINE_RADIUS)
		hazards.append({"type": "mine", "state": "warn",
			"warn": MINE_WARN + randf_range(-0.15, 0.15), "fire": 0.0,
			"data": {"pos": p, "radius": MINE_RADIUS}})

func _spawn_meteor() -> void:
	var center := _predict_enemy_meet(METEOR_WARN, 0.8)
	var p := center
	p.x = clampf(p.x, play_rect.position.x + METEOR_RADIUS, play_rect.end.x - METEOR_RADIUS)
	p.y = clampf(p.y, play_rect.position.y + METEOR_RADIUS, play_rect.end.y - METEOR_RADIUS)
	hazards.append({"type": "meteor", "state": "warn",
		"warn": METEOR_WARN, "fire": 0.0, "data": {"pos": p, "radius": METEOR_RADIUS}})

func _spawn_pulse() -> void:
	var center := _predict_meet(PULSE_WARN)
	var p := Vector2(
		clampf(center.x, play_rect.position.x + PULSE_RADIUS, play_rect.end.x - PULSE_RADIUS),
		clampf(center.y, play_rect.position.y + PULSE_RADIUS, play_rect.end.y - PULSE_RADIUS))
	hazards.append({"type": "pulse", "state": "warn",
		"warn": PULSE_WARN, "fire": 0.0, "data": {"pos": p, "radius": PULSE_RADIUS}})

func _spawn_bomb() -> void:
	var center := _predict_enemy_meet(BOMB_WARN, 0.8)
	var p := Vector2(
		clampf(center.x, play_rect.position.x + BOMB_RADIUS, play_rect.end.x - BOMB_RADIUS),
		clampf(center.y, play_rect.position.y + BOMB_RADIUS, play_rect.end.y - BOMB_RADIUS))
	hazards.append({"type": "bomb", "state": "warn",
		"warn": BOMB_WARN, "fire": 0.0, "data": {"pos": p, "radius": BOMB_RADIUS}})

func _spawn_saw() -> void:
	var r := randf()
	if r < 0.35: _spawn_saw_line()
	elif r < 0.60: _spawn_saw_diagonal()
	elif r < 0.85: _spawn_saw_spiral()
	else: _spawn_saw_random()

func _add_saw_linear(start: Vector2, end: Vector2) -> void:
	hazards.append({"type": "saw", "state": "warn", "warn": SAW_WARN, "fire": 0.0,
		"data": {"path": "linear", "start": start, "end": end, "current": start}})

func _spawn_saw_line() -> void:
	var center := _predict_meet(SAW_WARN)
	var axis := "h" if randf() < 0.5 else "v"
	var from_neg := randf() < 0.5
	var start: Vector2; var end: Vector2
	if axis == "h":
		start = Vector2(play_rect.position.x - SAW_RADIUS if from_neg else play_rect.end.x + SAW_RADIUS, center.y)
		end = Vector2(play_rect.end.x + SAW_RADIUS if from_neg else play_rect.position.x - SAW_RADIUS, center.y)
	else:
		start = Vector2(center.x, play_rect.position.y - SAW_RADIUS if from_neg else play_rect.end.y + SAW_RADIUS)
		end = Vector2(center.x, play_rect.end.y + SAW_RADIUS if from_neg else play_rect.position.y - SAW_RADIUS)
	_add_saw_linear(start, end)

func _spawn_saw_diagonal() -> void:
	var pad := SAW_RADIUS + 10.0
	var corners: Array = [
		Vector2(play_rect.position.x - pad, play_rect.position.y - pad),
		Vector2(play_rect.end.x + pad, play_rect.position.y - pad),
		Vector2(play_rect.position.x - pad, play_rect.end.y + pad),
		Vector2(play_rect.end.x + pad, play_rect.end.y + pad)]
	var idx := randi() % 4
	_add_saw_linear(corners[idx], corners[3 - idx])

func _spawn_saw_spiral() -> void:
	var center: Vector2
	if enemies.is_empty(): center = play_rect.get_center()
	else: center = _cluster_center()
	center.x = clampf(center.x, play_rect.position.x + 100, play_rect.end.x - 100)
	center.y = clampf(center.y, play_rect.position.y + 100, play_rect.end.y - 100)
	var rotations := 2.0 + randf() * 1.0
	var start_angle := randf() * TAU
	var start_radius := 30.0
	var end_radius := minf(play_rect.size.x, play_rect.size.y) * 0.35
	var origin := center + Vector2(cos(start_angle), sin(start_angle)) * start_radius
	hazards.append({"type": "saw", "state": "warn", "warn": SAW_WARN, "fire": 0.0,
		"data": {"path": "spiral", "center": center, "start_angle": start_angle,
			"rotations": rotations, "start_radius": start_radius,
			"end_radius": end_radius, "current": origin}})

func _spawn_saw_random() -> void:
	var n := randi_range(2, 3)
	for k in n:
		var edge := randi() % 4
		var start: Vector2; var end: Vector2
		match edge:
			0:
				start = Vector2(randf_range(play_rect.position.x, play_rect.end.x), play_rect.position.y - SAW_RADIUS)
				end = Vector2(randf_range(play_rect.position.x, play_rect.end.x), play_rect.end.y + SAW_RADIUS)
			1:
				start = Vector2(play_rect.end.x + SAW_RADIUS, randf_range(play_rect.position.y, play_rect.end.y))
				end = Vector2(play_rect.position.x - SAW_RADIUS, randf_range(play_rect.position.y, play_rect.end.y))
			2:
				start = Vector2(randf_range(play_rect.position.x, play_rect.end.x), play_rect.end.y + SAW_RADIUS)
				end = Vector2(randf_range(play_rect.position.x, play_rect.end.x), play_rect.position.y - SAW_RADIUS)
			_:
				start = Vector2(play_rect.position.x - SAW_RADIUS, randf_range(play_rect.position.y, play_rect.end.y))
				end = Vector2(play_rect.end.x + SAW_RADIUS, randf_range(play_rect.position.y, play_rect.end.y))
		_add_saw_linear(start, end)

func _spawn_shock() -> void:
	var center := _predict_meet(SHOCK_WARN)
	var p := Vector2(
		clampf(center.x, play_rect.position.x + 80, play_rect.end.x - 80),
		clampf(center.y, play_rect.position.y + 80, play_rect.end.y - 80))
	hazards.append({"type": "shock", "state": "warn",
		"warn": SHOCK_WARN, "fire": 0.0, "data": {"pos": p, "max_r": SHOCK_MAX_R}})

func _saw_pos_at(d: Dictionary, prog: float) -> Vector2:
	var path: String = d.get("path", "linear")
	if path == "spiral":
		var center: Vector2 = d["center"]
		var sa: float = float(d["start_angle"]); var rot: float = float(d["rotations"])
		var r0: float = float(d["start_radius"]); var r1: float = float(d["end_radius"])
		return center + Vector2(cos(sa + rot * TAU * prog), sin(sa + rot * TAU * prog)) * lerpf(r0, r1, prog)
	return (d["start"] as Vector2).lerp(d["end"], prog)

func _tick_saw(h: Dictionary) -> void:
	var d: Dictionary = h["data"]
	var total := SAW_TRAVEL * float(active_effects["fire_mult"])
	var prog := clampf((total - float(h["fire"])) / total, 0.0, 1.0)
	var cur := _saw_pos_at(d, prog)
	d["current"] = cur
	if current_mode == "duel":
		if cur.distance_to(p1_pos) < SAW_RADIUS + DUEL_PLAYER_RADIUS: _burst(p1_pos, Color(1, 0.3, 0.3), 20)
		if cur.distance_to(p2_pos) < SAW_RADIUS + DUEL_PLAYER_RADIUS: _burst(p2_pos, Color(0.3, 0.6, 1.0), 20)
		return
	if cur.distance_to(dot_pos) < SAW_RADIUS + DOT_RADIUS and not _is_invulnerable(): _die(); return
	var survivors: Array = []
	for e in enemies:
		if cur.distance_to(e["pos"]) < SAW_RADIUS + float(e["radius"]):
			if _damage_enemy(e):
				_burst(e["pos"], e["color"], 20); kills_this_run += 1
				achv_stats["kills"] = int(achv_stats["kills"]) + 1
				_add_combo()
				_float_text(e["pos"], "+%d" % (5 if current_mode == "waveless" else 0), Color(1, 0.85, 0.4))
				_maybe_drop_powerup(e["pos"])
				if e["type"] == "boss": _on_boss_killed(e["pos"])
				elif e["type"] == "splitter":
					if bool(no_tier_owned.get("split_bonus", false)): _award_money(10)
					var fs := _enemy_stats("normal")
					var sp := _enemy_speed() * float(fs["speed_mult"])
					for i in 2:
						var ang := randf() * TAU
						var off := Vector2(cos(ang), sin(ang)) * 22.0
						survivors.append({"pos": (e["pos"] as Vector2) + off, "speed": sp,
							"type": "normal", "radius": float(fs["radius"]), "color": fs["color"]})
				continue
			else:
				_burst(e["pos"], Color(1, 1, 1), 4)
				survivors.append(e)
				continue
		survivors.append(e)
	enemies = survivors

func _tick_shock(_h: Dictionary) -> void: pass

func _tick_stationary_hazard(h: Dictionary) -> void:
	if current_mode == "duel": return
	var survivors: Array = []
	for e in enemies:
		if _point_in_hazard(e["pos"], h):
			if _damage_enemy(e):
				_burst(e["pos"], e["color"], 20); kills_this_run += 1
				achv_stats["kills"] = int(achv_stats["kills"]) + 1
				_add_combo()
				_maybe_drop_powerup(e["pos"])
				if e["type"] == "boss": _on_boss_killed(e["pos"])
				elif e["type"] == "splitter":
					if bool(no_tier_owned.get("split_bonus", false)): _award_money(10)
					var fs := _enemy_stats("normal")
					var sp := _enemy_speed() * float(fs["speed_mult"])
					for i in 2:
						var ang := randf() * TAU
						var off := Vector2(cos(ang), sin(ang)) * 22.0
						survivors.append({"pos": (e["pos"] as Vector2) + off, "speed": sp,
							"type": "normal", "radius": float(fs["radius"]), "color": fs["color"]})
				continue
			else:
				_burst(e["pos"], Color(1, 1, 1), 4)
				survivors.append(e)
				continue
		survivors.append(e)
	enemies = survivors
	if _point_in_hazard(dot_pos, h) and not _is_invulnerable(): _die()

func _point_in_hazard(p: Vector2, h: Dictionary) -> bool:
	var d: Dictionary = h["data"]
	var m: float = float(active_effects["aoe_mult"])
	match h["type"]:
		"laser":
			var band := LASER_BAND * m
			if d["axis"] == "h": return abs(p.y - float(d["pos"])) < band
			return abs(p.x - float(d["pos"])) < band
		"mine", "meteor", "pulse", "bomb": return p.distance_to(d["pos"]) < float(d["radius"]) * m
		"shock": return p.distance_to(d["pos"]) < float(d["max_r"]) * m
	return false

func _apply_hazard(h: Dictionary) -> void:
	_play_sfx("hazard_fire")
	if settings["screen_shake"]:
		match h["type"]:
			"laser": shake = max(shake, 8.0)
			"mine": shake = max(shake, 6.0)
			"meteor": shake = max(shake, 12.0)
			"pulse": shake = max(shake, 10.0)
			"bomb": shake = max(shake, 16.0)
			"shock": shake = max(shake, 18.0)
	var survivors: Array = []
	for e in enemies:
		if _point_in_hazard(e["pos"], h):
			if _damage_enemy(e):
				_burst(e["pos"], e["color"], 20); kills_this_run += 1
				achv_stats["kills"] = int(achv_stats["kills"]) + 1
				_add_combo()
				_maybe_drop_powerup(e["pos"])
				if e["type"] == "boss": _on_boss_killed(e["pos"])
				elif e["type"] == "splitter":
					if bool(no_tier_owned.get("split_bonus", false)): _award_money(10)
					var fs := _enemy_stats("normal")
					var sp := _enemy_speed() * float(fs["speed_mult"])
					for i in 2:
						var ang := randf() * TAU
						var off := Vector2(cos(ang), sin(ang)) * 22.0
						survivors.append({"pos": (e["pos"] as Vector2) + off, "speed": sp,
							"type": "normal", "radius": float(fs["radius"]), "color": fs["color"]})
				continue
			else:
				_burst(e["pos"], Color(1, 1, 1), 4)
				survivors.append(e)
				continue
		survivors.append(e)
	enemies = survivors
	if _point_in_hazard(dot_pos, h) and not _is_invulnerable(): _die()

func _enemy_speed() -> float:
	if current_mode == "waveless": return ENEMY_BASE_SPEED * (1.0 + waveless_time * 0.02)
	return ENEMY_BASE_SPEED * (1.0 + 0.2 * floor((wave - 1) / 5.0))

func _pick_type() -> String:
	var pool: Array = ["normal", "normal"]
	if current_mode == "waveless":
		if waveless_time > 30.0: pool.append("heavy")
		if waveless_time > 45.0: pool.append("splitter")
	else:
		if wave >= 5: pool.append("heavy")
		if wave >= 7: pool.append("splitter")
	return pool[randi() % pool.size()]

func _enemy_stats(etype: String) -> Dictionary:
	match etype:
		"heavy": return {"radius": 24.0, "speed_mult": 0.65, "color": Color(0.55, 0.40, 0.45)}
		"splitter": return {"radius": 16.0, "speed_mult": 1.1, "color": Color(0.85, 0.65, 0.55)}
		"boss": return {"radius": BOSS_RADIUS, "speed_mult": BOSS_SPEED_MULT, "color": Color(0.85, 0.25, 0.35)}
		_: return {"radius": 15.0, "speed_mult": 1.0, "color": Color(0.68, 0.68, 0.75)}

func _spawn_enemy() -> void:
	var etype := _pick_type()
	var stats := _enemy_stats(etype)
	var p := Vector2.ZERO
	for attempt in 30:
		match randi() % 4:
			0: p = Vector2(randf_range(play_rect.position.x, play_rect.end.x), play_rect.position.y)
			1: p = Vector2(play_rect.end.x, randf_range(play_rect.position.y, play_rect.end.y))
			2: p = Vector2(randf_range(play_rect.position.x, play_rect.end.x), play_rect.end.y)
			_: p = Vector2(play_rect.position.x, randf_range(play_rect.position.y, play_rect.end.y))
		if p.distance_to(dot_pos) >= MIN_SPAWN_DISTANCE: break
	enemies.append({"pos": p, "speed": _enemy_speed() * float(stats["speed_mult"]),
		"type": etype, "radius": float(stats["radius"]), "color": stats["color"]})

func _spawn_boss() -> void:
	var stats := _enemy_stats("boss")
	var p := Vector2(play_rect.position.x + play_rect.size.x * 0.5, play_rect.position.y + 60.0)
	enemies.append({"pos": p, "speed": _enemy_speed() * float(stats["speed_mult"]),
		"type": "boss", "radius": float(stats["radius"]), "color": stats["color"],
		"hp": BOSS_HP})

func _on_boss_killed(at: Vector2) -> void:
	achv_stats["bosses_killed"] = int(achv_stats["bosses_killed"]) + 1
	_award_money(BOSS_MONEY_REWARD)
	var actual := int(BOSS_MONEY_REWARD * float(active_effects["money_mult"]))
	_show_toast("BOSS! +$%d" % actual)
	_burst(at, Color(1, 0.8, 0.3), 50)
	_burst(at, Color(1, 1, 1), 30)
	shake = 25.0 if settings["screen_shake"] else 0.0
	hitstop_timer = HITSTOP_TIME * 2.0
	_play_sfx("win")
	var types := ["shield", "slowmo", "magnet", "cash"]
	for i in 3:
		powerups.append({"pos": at + Vector2(randf_range(-70, 70), randf_range(-70, 70)),
			"type": types[randi() % types.size()], "age": 0.0})

# NEW: split _die() into slow-mo trigger and finalize
func _die() -> void:
	if state != State.PLAY: return
	if current_mode == "duel": return
	if _is_invulnerable(): return
	if revives_remaining > 0:
		revives_remaining -= 1
		_show_toast("REVIVED! %d left" % revives_remaining)
		_play_sfx("win")
		shake = 20.0 if settings["screen_shake"] else 0.0
		_burst(dot_pos, Color(0.4, 1.0, 0.5), 40)
		enemies.clear(); hazards.clear(); powerups.clear()
		combo_count = 0; combo_timer = 0.0
		dot_pos = play_rect.get_center(); key_vel = Vector2.ZERO
		shield_timer = 2.0 + (1.5 if bool(no_tier_owned.get("dash", false)) else 0.0)
		wave_delay_timer = 0.0
		_start_wave()
		return
	# NEW: brief dramatic slow-mo before game-over
	_burst(dot_pos, Color(1.0, 0.2, 0.25), 60)
	shake = 26.0 if settings["screen_shake"] else 0.0
	_play_sfx("death")
	death_slowmo_timer = DEATH_SLOWMO_TIME
	enemies.clear(); hazards.clear(); powerups.clear()
	dash_timer = 0.0
	combo_count = 0; combo_timer = 0.0

func _finalize_death() -> void:
	if state != State.PLAY: return
	state = State.OVER
	_set_mouse_visible(true)
	if current_mode == "classic":
		_record_score("classic", float(wave))
		achv_stats["classic_best_wave"] = maxi(int(achv_stats["classic_best_wave"]), wave)
		var earned: int = 20 * maxi(0, wave - 1)
		if earned > 0: _award_money(earned)
	elif current_mode == "waveless":
		_record_score("waveless", float(kills_this_run))
		achv_stats["waveless_best"] = maxf(float(achv_stats["waveless_best"]), waveless_time)
		if kills_this_run > 0: _award_money(5 * kills_this_run)
	_save_scores()

func _win_speedrun() -> void:
	if state != State.PLAY: return
	state = State.WIN; _play_sfx("win"); _set_mouse_visible(true)
	_record_score("speedrun", speedrun_time)
	achv_stats["speedrun_wins"] = int(achv_stats["speedrun_wins"]) + 1
	achv_stats["fastest_speedrun"] = minf(float(achv_stats["fastest_speedrun"]), speedrun_time)
	var bonus: int = int(600.0 * maxf(0.0, 1.0 - minf(speedrun_time, 180.0) / 180.0))
	_award_money(300 + bonus)
	_save_scores()

func _load_scores() -> void:
	scores = {"classic": [], "speedrun": [], "waveless": []}
	money = 0; owned_skins = ["classic"]; current_skin = "classic"
	owned_trails = ["basic"]; current_trail = "basic"
	owned_upgrades = {}; no_tier_owned = {}
	custom_bg_path = ""; custom_bg_texture = null
	custom_orb_path = ""; custom_orb_texture = null
	custom_trail_path = ""; custom_trail_texture = null
	achievements_unlocked = []
	achv_stats = _default_achv_stats()
	current_slot = 1
	classic_checkpoints = [0, 0, 0, 0, 0]
	classic_checkpoint = 0
	settings = {
		"sfx": true, "music": true, "screen_shake": true,
		"show_hitboxes": false, "show_fps": false, "arrow_keys": true,
		"background": "nebula",
	}
	tutorial_seen = {"classic": false, "speedrun": false, "waveless": false, "duel": false}
	if not FileAccess.file_exists(SAVE_PATH): _compute_active_effects(); return
	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if f == null: _compute_active_effects(); return
	var data = JSON.parse_string(f.get_as_text())
	f.close()
	if data is Dictionary:
		if data.has("settings") and data["settings"] is Dictionary:
			for k in settings:
				if data["settings"].has(k): settings[k] = data["settings"][k]
		if data.has("custom_audio") and data["custom_audio"] is Dictionary:
			for k in data["custom_audio"]:
				var p: String = data["custom_audio"][k]
				if FileAccess.file_exists(p): custom_audio_paths[k] = p
		if data.has("custom_bg_path"):
			custom_bg_path = str(data["custom_bg_path"])
			_load_custom_bg_texture(custom_bg_path)
		if data.has("custom_orb_path"):
			custom_orb_path = str(data["custom_orb_path"])
			_load_custom_orb_texture(custom_orb_path)
		if data.has("custom_trail_path"):
			custom_trail_path = str(data["custom_trail_path"])
			_load_custom_trail_texture(custom_trail_path)
		if data.has("tutorial_seen") and data["tutorial_seen"] is Dictionary:
			for k in tutorial_seen:
				if data["tutorial_seen"].has(k): tutorial_seen[k] = bool(data["tutorial_seen"][k])
			if data["tutorial_seen"].has("infinite") and not data["tutorial_seen"].has("waveless"):
				tutorial_seen["waveless"] = bool(data["tutorial_seen"]["infinite"])
		if data.has("achievements") and data["achievements"] is Array:
			for a in data["achievements"]:
				if typeof(a) == TYPE_STRING and not a in achievements_unlocked:
					achievements_unlocked.append(a)
		if data.has("achv_stats") and data["achv_stats"] is Dictionary:
			for k in achv_stats:
				if data["achv_stats"].has(k): achv_stats[k] = data["achv_stats"][k]
		if data.has("current_slot"): current_slot = clampi(int(data["current_slot"]), 1, 5)
		if data.has("classic_checkpoints") and data["classic_checkpoints"] is Array:
			for i in range(min(5, data["classic_checkpoints"].size())):
				classic_checkpoints[i] = int(data["classic_checkpoints"][i])
		if data.has("money"): money = int(data["money"])
		if data.has("owned_skins") and data["owned_skins"] is Array:
			for s in data["owned_skins"]:
				if typeof(s) == TYPE_STRING and not s in owned_skins: owned_skins.append(s)
		if data.has("current_skin"): current_skin = str(data["current_skin"])
		if data.has("owned_trails") and data["owned_trails"] is Array:
			for s in data["owned_trails"]:
				if typeof(s) == TYPE_STRING and not s in owned_trails: owned_trails.append(s)
		if data.has("current_trail"): current_trail = str(data["current_trail"])
		if data.has("no_tier_owned") and data["no_tier_owned"] is Dictionary:
			for k in data["no_tier_owned"]:
				no_tier_owned[k] = bool(data["no_tier_owned"][k])
		if data.has("owned_upgrades") and data["owned_upgrades"] is Dictionary:
			for k in data["owned_upgrades"]:
				owned_upgrades[k] = clampi(int(data["owned_upgrades"][k]), 0, _get_upgrade_max_level(k))
		if data.has("scores") and data["scores"] is Dictionary:
			for mode in ["classic", "speedrun", "waveless"]:
				if data["scores"].has(mode) and data["scores"][mode] is Array:
					var arr: Array = []
					for v in data["scores"][mode]:
						if typeof(v) == TYPE_FLOAT or typeof(v) == TYPE_INT: arr.append(float(v))
					arr.sort()
					if mode != "speedrun": arr.reverse()
					while arr.size() > 10: arr.pop_back()
					scores[mode] = arr
	for aid in achievements_unlocked:
		_grant_achievement_skin(aid)
	if not "classic" in owned_skins: owned_skins.append("classic")
	if not current_skin in owned_skins: current_skin = "classic"
	if not "basic" in owned_trails: owned_trails.append("basic")
	if not current_trail in owned_trails: current_trail = "basic"
	_compute_active_effects()

func _save_scores() -> void:
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f == null: return
	var save_data := {
		"money": money,
		"owned_skins": owned_skins,
		"current_skin": current_skin,
		"owned_trails": owned_trails,
		"current_trail": current_trail,
		"owned_upgrades": owned_upgrades,
		"no_tier_owned": no_tier_owned,
		"scores": scores,
		"achievements": achievements_unlocked,
		"achv_stats": achv_stats,
		"settings": settings,
		"custom_audio": custom_audio_paths,
		"custom_bg_path": custom_bg_path,
		"custom_orb_path": custom_orb_path,
		"custom_trail_path": custom_trail_path,
		"tutorial_seen": tutorial_seen,
		"current_slot": current_slot,
		"classic_checkpoints": classic_checkpoints,
		# NEW: persist daily bonus state
		"last_daily_bonus_day": _last_daily_bonus_day,
	}
	f.store_string(JSON.stringify(save_data))
	f.close()

func _record_score(mode: String, value: float) -> void:
	if not scores.has(mode): return
	var arr: Array = scores[mode]
	arr.append(value)
	if mode == "speedrun": arr.sort()
	else: arr.sort(); arr.reverse()
	while arr.size() > 10: arr.pop_back()
	scores[mode] = arr

func _best(mode: String) -> float:
	if not scores.has(mode): return 0.0
	var arr: Array = scores[mode]
	return float(arr[0]) if arr.size() > 0 else 0.0

func _fmt_time(s: float) -> String:
	if s < 0.0: s = 0.0
	return "%d:%02d.%02d" % [int(s) / 60, int(s) % 60, int((s - floor(s)) * 100.0)]

func _burst(at: Vector2, col: Color, count: int) -> void:
	for i in count:
		var ang := randf() * TAU
		var spd := randf_range(70.0, 300.0) * SPEED_SCALE
		var life := randf_range(0.3, 0.7)
		particles.append({"pos": at, "vel": Vector2(cos(ang), sin(ang)) * spd,
			"life": life, "max": life, "col": col, "size": randf_range(2.5, 6.0)})

func _update_particles(delta: float) -> void:
	var keep: Array = []
	for p in particles:
		p["life"] = float(p["life"]) - delta
		if float(p["life"]) > 0.0:
			p["pos"] = (p["pos"] as Vector2) + (p["vel"] as Vector2) * delta
			p["vel"] = (p["vel"] as Vector2) * 0.93
			keep.append(p)
	particles = keep

func _draw_scanlines() -> void:
	var c := Color(0.15, 0.35, 0.15, 0.08)
	var off := fmod(t * 15.0, SCANLINE_SPACING)
	var y := play_rect.position.y + off
	while y < play_rect.end.y:
		draw_line(Vector2(play_rect.position.x, y), Vector2(play_rect.end.x, y), c, 1.0)
		y += SCANLINE_SPACING

func _draw_casing_background() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0.72, 0.68, 0.60))
	draw_rect(Rect2(0, 0, screen.x, play_rect.position.y), Color(0.80, 0.76, 0.68))
	draw_rect(Rect2(0, play_rect.end.y, screen.x, screen.y - play_rect.end.y), Color(0.55, 0.51, 0.43))
	draw_rect(Rect2(0, play_rect.position.y, play_rect.position.x, play_rect.size.y), Color(0.72, 0.68, 0.60))
	draw_rect(Rect2(play_rect.end.x, play_rect.position.y, screen.x - play_rect.end.x, play_rect.size.y), Color(0.65, 0.61, 0.53))
	draw_circle(Vector2(60, screen.y - 50), 8, Color(0.6, 0.55, 0.45, 0.3))
	draw_circle(Vector2(screen.x - 80, 30), 12, Color(0.6, 0.55, 0.45, 0.2))

func _draw_screen_vignette() -> void:
	for i in range(8):
		var inset := i * 4.0
		var alpha := (8.0 - i) / 8.0 * 0.18
		draw_rect(play_rect.grow(-inset), Color(0, 0, 0, alpha), false, 4.0)

func _draw_glass_reflection() -> void:
	for i in range(3):
		var y := play_rect.position.y + 14.0 + i * 6.0
		draw_line(Vector2(play_rect.position.x + 30 + i * 40, y),
			Vector2(play_rect.end.x - 30 - i * 40, y), Color(1, 1, 1, 0.06), 1.0)

func _draw_tube_bezel() -> void:
	draw_rect(play_rect, Color(0.08, 0.08, 0.06), false, 8.0)
	draw_rect(play_rect.grow(4), Color(0.30, 0.28, 0.24), false, 6.0)
	draw_rect(play_rect.grow(8), Color(0.55, 0.50, 0.42), false, 2.0)

func _draw_casing_details() -> void:
	var row_y := play_rect.end.y + 40.0
	for i in range(5):
		var vy := 14.0 + i * 5.0
		draw_rect(Rect2(screen.x - 110, vy, 90, 3), Color(0.48, 0.44, 0.36))
		draw_line(Vector2(screen.x - 110, vy + 3), Vector2(screen.x - 20, vy + 3), Color(0.6, 0.55, 0.45), 1.0)
	draw_string(font, Vector2(18, screen.y - 14), "AT-9000  \u2122",
		HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(0.32, 0.28, 0.20))
	draw_string(font, Vector2(18, screen.y - 30), "CURSOR CHAOS SYSTEMS",
		HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.4, 0.35, 0.25))
	var bs := Vector2(36, 22); var bc := screen.x * 0.5
	var bxs := [bc - 60, bc, bc + 60]
	var bcols := [Color(0.42, 0.38, 0.32), Color(0.42, 0.38, 0.32), Color(0.62, 0.18, 0.12)]
	for i in range(3):
		var br := Rect2(Vector2(bxs[i] - bs.x * 0.5, row_y - bs.y * 0.5), bs)
		draw_rect(br, bcols[i])
		draw_rect(Rect2(br.position, Vector2(br.size.x, 2)), Color(0.65, 0.60, 0.52))
		draw_rect(Rect2(Vector2(br.position.x, br.end.y - 2), Vector2(br.size.x, 2)), Color(0.20, 0.18, 0.14))
		draw_rect(br, Color(0.10, 0.09, 0.08), false, 1.0)
	for i in range(2):
		var kp := Vector2(screen.x - 100 - i * 36, row_y)
		draw_circle(kp, 12.0, Color(0.30, 0.26, 0.22))
		draw_circle(kp, 10.0, Color(0.50, 0.46, 0.38))
		draw_circle(kp, 8.0, Color(0.42, 0.38, 0.32))
		var na: float = 0.5 + i * 1.2
		draw_line(kp, kp + Vector2(cos(na), sin(na)) * 6.0, Color(0.15, 0.12, 0.10), 1.5)
	var led := Vector2(screen.x - 40, row_y)
	var glow_amt := 0.5 + 0.5 * sin(t * 3.0)
	draw_circle(led, 14.0, Color(0.2, 0.7, 0.3, 0.1 + 0.1 * glow_amt))
	draw_circle(led, 10.0, Color(0.20, 0.18, 0.15))
	draw_circle(led, 8.0, Color(0.15, 0.55, 0.20))
	draw_circle(led, 5.0, Color(0.35, 0.90, 0.40))
	draw_circle(led, 2.5, Color(0.85, 1.0, 0.85))

func _draw_background() -> void:
	match settings["background"]:
		"nebula": _draw_bg_nebula()
		"aurora": _draw_bg_aurora()
		"grid": _draw_bg_grid()
		"sunset": _draw_bg_sunset()
		"ocean": _draw_bg_ocean()
		"void": _draw_bg_void()
		"custom": _draw_bg_custom()
		_: _draw_bg_nebula()

func _draw_bg_custom() -> void:
	if custom_bg_texture == null:
		_draw_bg_nebula(); return
	var ts := custom_bg_texture.get_size()
	if ts.x <= 0 or ts.y <= 0:
		_draw_bg_nebula(); return
	var sc := maxf(screen.x / ts.x, screen.y / ts.y)
	var ds := ts * sc
	draw_texture_rect(custom_bg_texture, Rect2((screen - ds) * 0.5, ds), false)

func _draw_bg_nebula() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0.02, 0.02, 0.06))
	for i in range(80):
		var seed := i * 17.13
		var sx := fmod(seed * 71.3 + menu_bg_seed * 0.37, screen.x)
		var sy := fmod(seed * 43.7 + menu_bg_seed * 0.61, screen.y)
		var twinkle := 0.4 + 0.6 * sin(t * 0.8 + i * 0.7)
		draw_circle(Vector2(sx, sy), 0.8 + 0.6 * sin(t * 1.2 + i * 0.3), Color(1, 1, 1, twinkle * 0.7))
	var clouds := [
		{"b": Vector2(0.3, 0.4), "c": Color(0.4, 0.15, 0.6), "s": 0.03, "p": 0.0, "sz": 320.0},
		{"b": Vector2(0.7, 0.6), "c": Color(0.1, 0.25, 0.5), "s": -0.04, "p": 1.3, "sz": 380.0},
		{"b": Vector2(0.5, 0.2), "c": Color(0.55, 0.2, 0.4), "s": 0.05, "p": 2.1, "sz": 280.0},
		{"b": Vector2(0.2, 0.75), "c": Color(0.15, 0.35, 0.55), "s": -0.03, "p": 3.5, "sz": 340.0},
	]
	for cl in clouds:
		var cx: float = cl["b"].x * screen.x + sin(t * float(cl["s"]) + float(cl["p"])) * 80.0
		var cy: float = cl["b"].y * screen.y + cos(t * float(cl["s"]) * 1.3 + float(cl["p"])) * 60.0
		var cc: Color = cl["c"]
		for layer in range(6):
			draw_circle(Vector2(cx, cy), float(cl["sz"]) * (1.0 - layer * 0.13),
				Color(cc.r, cc.g, cc.b, 0.05 + layer * 0.015))

func _draw_bg_aurora() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0.01, 0.02, 0.05))
	for i in range(40):
		var seed := i * 23.7
		draw_circle(Vector2(fmod(seed * 71.3 + menu_bg_seed * 0.37, screen.x),
			fmod(seed * 43.7, screen.y * 0.6)), 1.0, Color(1, 1, 1, (0.3 + 0.4 * sin(t * 0.6 + i)) * 0.5))
	var cols := [Color(0.3, 0.9, 0.5), Color(0.3, 0.7, 1.0), Color(0.6, 0.35, 0.9)]
	for bi in range(cols.size()):
		var c: Color = cols[bi]
		var x := -20.0
		while x < screen.x + 20.0:
			var wave := sin(x * 0.007 + t * (0.3 + bi * 0.15) + bi * 1.7) * (50.0 + bi * 15.0)
			var wave2 := cos(x * 0.011 - t * (0.3 + bi * 0.15) * 0.6 + bi * 2.2) * (50.0 + bi * 15.0) * 0.4
			var y := screen.y * (0.35 + bi * 0.12) + wave + wave2
			draw_line(Vector2(x, y - (180.0 + bi * 20.0)), Vector2(x, y + (180.0 + bi * 20.0) * 0.2),
				Color(c.r, c.g, c.b, 0.09 + 0.06 * sin(x * 0.01 + t * 0.8 + bi * 1.7)), 14.0)
			x += 12.0

func _draw_bg_grid() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0.02, 0.03, 0.05))
	var sp := 50.0
	var dx := fmod(t * 20.0, sp); var dy := fmod(t * 20.0, sp)
	var y := -sp + dy
	while y < screen.y + sp:
		draw_line(Vector2(0, y), Vector2(screen.x, y), Color(0.2, 0.6, 1.0, 0.08), 1.0); y += sp
	var x := -sp + dx
	while x < screen.x + sp:
		draw_line(Vector2(x, 0), Vector2(x, screen.y), Color(0.2, 0.6, 1.0, 0.08), 1.0); x += sp
	var scan_y := fmod(t * 60.0, screen.y)
	draw_line(Vector2(0, scan_y), Vector2(screen.x, scan_y), Color(0.4, 0.85, 1.0, 0.15), 2.0)

func _draw_bg_sunset() -> void:
	for i in range(30):
		var f := i / 30.0
		var col: Color
		if f < 0.5: col = Color(0.95, 0.45, 0.2).lerp(Color(0.5, 0.15, 0.4), f * 2.0)
		else: col = Color(0.5, 0.15, 0.4).lerp(Color(0.05, 0.03, 0.15), (f - 0.5) * 2.0)
		draw_rect(Rect2(0, i * screen.y / 30.0, screen.x, screen.y / 30.0 + 1), col)
	var sp := Vector2(screen.x * 0.5, screen.y * 0.55)
	var sr := 90.0 + sin(t * 0.3) * 3.0
	for i in range(10):
		draw_circle(sp, sr * (1.0 + i * 0.15), Color(1, 0.7, 0.4, 0.08 - i * 0.007))
	draw_circle(sp, sr, Color(1, 0.85, 0.6, 0.9))
	draw_circle(sp, sr * 0.85, Color(1, 0.95, 0.8, 0.95))

func _draw_bg_ocean() -> void:
	for i in range(30):
		var f := i / 30.0
		draw_rect(Rect2(0, i * screen.y / 30.0, screen.x, screen.y / 30.0 + 1),
			Color(0.05, 0.15, 0.3).lerp(Color(0.01, 0.03, 0.1), f))
	for layer in range(3):
		var x := 0.0
		while x < screen.x + 10:
			var y := screen.y * (0.3 + layer * 0.2) + sin(x * 0.02 + t * (0.4 + layer * 0.2) + layer * 2.0) * (30.0 + layer * 15.0) + cos(x * 0.013 - t * (0.4 + layer * 0.2) * 0.8 + layer) * (30.0 + layer * 15.0) * 0.6
			draw_circle(Vector2(x, y), 8.0, Color(0.4, 0.7, 1.0, 0.08 + 0.05 * sin(x * 0.01 + t * 1.5)))
			x += 15.0

func _draw_bg_void() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0.005, 0.005, 0.01))
	for i in range(60):
		var seed := i * 41.7
		draw_circle(Vector2(fmod(seed * 71.3 + t * 5.0 + menu_bg_seed, screen.x + 100.0) - 50.0,
			fmod(seed * 43.7 + menu_bg_seed, screen.y)),
			0.6 + 0.4 * sin(t * 0.9 + i * 0.5),
			Color(0.85, 0.9, 1.0, (0.3 + 0.7 * (0.5 + 0.5 * sin(t * 0.5 + i * 1.3))) * 0.6))

func _draw_shop_icon(center: Vector2, size: float, col: Color) -> void:
	var bw := size * 0.7; var bh := size * 0.65
	var bag := Rect2(center - Vector2(bw * 0.5, bh * 0.15), Vector2(bw, bh))
	draw_arc(center + Vector2(0, -bh * 0.4), bw * 0.35, PI, TAU, 10, col, 2.5)
	draw_rect(bag, Color(col.r, col.g, col.b, 0.15))
	draw_rect(bag, col, false, 2.5)
	var ds_w: float = font.get_string_size("$", HORIZONTAL_ALIGNMENT_LEFT, -1, int(bh * 0.7)).x
	draw_string(font, Vector2(center.x - ds_w * 0.5, center.y + bh * 0.32), "$",
		HORIZONTAL_ALIGNMENT_LEFT, -1, int(bh * 0.7), col)

func _draw_settings_icon(center: Vector2, size: float, col: Color) -> void:
	var r := size * 0.32
	for i in range(8):
		var ang := i * TAU / 8.0 + t * 0.15
		draw_line(center + Vector2(cos(ang), sin(ang)) * (r - 1.0),
			center + Vector2(cos(ang), sin(ang)) * (r + 4.0), col, 2.5)
	draw_arc(center, r, 0, TAU, 24, col, 2.5)
	draw_circle(center, r * 0.35, Color(col.r, col.g, col.b, 0.25))
	draw_arc(center, r * 0.35, 0, TAU, 16, col, 1.5)

func _draw_achv_icon(center: Vector2, size: float, col: Color) -> void:
	var cw := size * 0.55; var ch := size * 0.5
	var cr := Rect2(center.x - cw*0.5, center.y - ch*0.6, cw, ch)
	draw_arc(Vector2(cr.position.x, center.y - ch*0.1), ch*0.35, PI*0.5, PI*1.5, 8, col, 2.0)
	draw_arc(Vector2(cr.end.x, center.y - ch*0.1), ch*0.35, -PI*0.5, PI*0.5, 8, col, 2.0)
	draw_rect(cr, col)
	draw_rect(Rect2(center.x - 3, cr.end.y, 6, size*0.15), col)
	draw_rect(Rect2(center.x - cw*0.4, cr.end.y + size*0.15, cw*0.8, 3), col)

# NEW: quit icon (power symbol)
func _draw_quit_icon(center: Vector2, size: float, col: Color) -> void:
	var r := size * 0.35
	draw_arc(center + Vector2(0, 2), r, PI * 0.3, PI * 1.7, 20, col, 2.5)
	draw_line(center + Vector2(0, -r * 1.1 + 2), center + Vector2(0, -r * 0.1), col, 2.5)

func _draw_saw_body(center: Vector2, radius: float, rotation: float, glow_col: Color, live: bool) -> void:
	var gp := 0.85 + 0.15 * sin(t * 15.0)
	if live:
		draw_circle(center, (radius + 14.0) * gp, Color(glow_col.r, glow_col.g, glow_col.b, 0.28))
		draw_circle(center, (radius + 7.0) * gp, Color(glow_col.r, glow_col.g, glow_col.b, 0.45))
	else:
		draw_circle(center, (radius + 10.0) * gp, Color(glow_col.r, glow_col.g, glow_col.b, 0.22))
	var teeth := 12
	var pts := PackedVector2Array()
	for i in range(teeth * 2):
		var ang := rotation + i * TAU / (teeth * 2)
		var r := radius + 7.0 if i % 2 == 1 else radius
		pts.append(center + Vector2(cos(ang), sin(ang)) * r)
	draw_colored_polygon(pts, Color(0.42, 0.42, 0.50))
	draw_circle(center, radius * 0.72, Color(0.52, 0.52, 0.60))
	draw_circle(center, radius * 0.50, Color(0.65, 0.65, 0.72))
	draw_circle(center, radius * 0.28, Color(0.50, 0.50, 0.58))
	for i in range(pts.size()):
		var a := pts[i]; var b := pts[(i + 1) % pts.size()]
		if ((a + b) * 0.5).distance_to(center) > radius + 2.0:
			draw_line(a, b, Color(0.95, 0.95, 1.0, 0.85), 1.5)
		else:
			draw_line(a, b, Color(0.30, 0.30, 0.38, 0.6), 1.0)
	draw_circle(center, radius * 0.18, Color(0.22, 0.22, 0.28))
	draw_circle(center + Vector2(-1, -1), radius * 0.09, Color(0.60, 0.60, 0.68))
	draw_arc(center, radius * 0.85, PI + 0.4, PI + 1.4, 12, Color(1, 1, 1, 0.35), 2.0)

func _draw() -> void:
	var off := Vector2.ZERO
	if shake > 0.0 and settings["screen_shake"]:
		off = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
	draw_set_transform(off, 0.0, Vector2.ONE)
	_draw_casing_background()
	match state:
		State.MENU: _draw_background(); _draw_menu()
		State.SETTINGS: _draw_background(); draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.68)); _draw_settings()
		State.SHOP: _draw_background(); draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.35)); _draw_shop()
		State.ACHIEVEMENTS: _draw_background(); draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.55)); _draw_achievements()
		State.CLASSIC_SLOTS: _draw_background(); draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.55)); _draw_classic_slots()
		State.TUTORIAL: _draw_background(); draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.82)); _draw_tutorial()
		State.PLAY, State.PAUSED, State.OVER, State.WIN:
			draw_rect(play_rect, Color(0.03, 0.05, 0.03))
			_draw_world(); _draw_hitboxes(); _draw_scanlines()
			_draw_screen_vignette(); _draw_glass_reflection()
			_draw_tube_bezel(); _draw_casing_details()
			match state:
				State.PLAY:
					_draw_hud()
					if settings["show_fps"]: _draw_fps()
				State.PAUSED:
					_draw_hud()
					if settings["show_fps"]: _draw_fps()
					_draw_pause()
				_: _draw_over()
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	_draw_toast()
	_draw_streak_callout()
	if fade_alpha > 0.0:
		draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, fade_alpha))

# NEW: streak callout rendering
func _draw_streak_callout() -> void:
	if streak_callout_timer <= 0.0 or streak_callout_text == "": return
	var a: float = clampf(streak_callout_timer / 0.4, 0.0, 1.0)
	if streak_callout_timer > 1.2: a = (1.6 - streak_callout_timer) / 0.4
	var sc := 1.0 + 0.2 * sin(t * 12.0)
	var sz := int(44 * sc)
	var w: float = font.get_string_size(streak_callout_text, HORIZONTAL_ALIGNMENT_LEFT, -1, sz).x
	draw_string(font, Vector2((screen.x - w) * 0.5, screen.y * 0.20), streak_callout_text,
		HORIZONTAL_ALIGNMENT_LEFT, -1, sz, Color(1, 0.85, 0.4, a))

# NEW: floating text particles
func _draw_text_particles() -> void:
	for tp in text_particles:
		var a: float = clampf(float(tp["life"]) / float(tp["max"]), 0.0, 1.0)
		var c: Color = tp["col"]
		var w: float = font.get_string_size(tp["text"], HORIZONTAL_ALIGNMENT_LEFT, -1, 14).x
		draw_string(font, (tp["pos"] as Vector2) - Vector2(w * 0.5, 0),
			tp["text"], HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(c.r, c.g, c.b, a))

# NEW: dash trail rendering
func _draw_dash_trail() -> void:
	if dash_trail.is_empty(): return
	var skin: Array = _get_skin(current_skin)
	var col := _skin_glow(skin)
	for dt in dash_trail:
		var a: float = clampf(float(dt["life"]) / 0.25, 0.0, 1.0)
		draw_circle(dt["pos"], DOT_RADIUS * (0.7 + 0.5 * a), Color(col.r, col.g, col.b, a * 0.35))

func _draw_trail() -> void:
	if dot_trail.is_empty(): return
	if current_trail == CUSTOM_TRAIL_ID and custom_trail_texture != null:
		var ts := custom_trail_texture.get_size()
		if ts.x > 0 and ts.y > 0:
			var base := DOT_RADIUS * 1.2 / maxf(ts.x, ts.y)
			for i in range(dot_trail.size()):
				var tr: Dictionary = dot_trail[i]
				var age: float = float(tr["age"])
				var frac: float = 1.0 - age / TRAIL_LIFE
				if frac <= 0.0: continue
				var ds := ts * base * frac
				draw_texture_rect(custom_trail_texture, Rect2((tr["pos"] as Vector2) - ds * 0.5, ds), false)
			return
	var trail: Array = _get_trail(current_trail)
	var style: String = str(trail[3])
	var colA: Color = trail[4]
	var colB: Color = trail[5]
	var n := dot_trail.size()
	if style == "fade":
		for i in range(n):
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var c := colA.lerp(colB, 1.0 - frac)
			draw_circle(tr["pos"], DOT_RADIUS * frac * 0.75, Color(c.r, c.g, c.b, frac * 0.4))
	elif style == "ribbon":
		var pts := PackedVector2Array()
		for i in range(n):
			pts.append(dot_trail[i]["pos"])
		if pts.size() >= 2:
			for i in range(pts.size() - 1):
				var fr := float(i) / float(pts.size() - 1)
				var c := colA.lerp(colB, fr)
				draw_line(pts[i], pts[i + 1], Color(c.r, c.g, c.b, fr * 0.55), DOT_RADIUS * 1.1 * fr)
	elif style == "sparks":
		for i in range(n):
			if i % 2 != 0: continue
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var c := colA.lerp(colB, frac)
			var jitter := Vector2(sin(t * 30.0 + i) * 6.0, cos(t * 25.0 + i) * 6.0)
			draw_circle((tr["pos"] as Vector2) + jitter, 3.0 + 3.0 * frac, Color(c.r, c.g, c.b, frac * 0.75))
	elif style == "comet":
		for i in range(n):
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var c := colA.lerp(colB, 1.0 - frac)
			draw_circle(tr["pos"], DOT_RADIUS * 0.55 * frac, Color(c.r, c.g, c.b, frac * 0.55))
			draw_circle(tr["pos"], DOT_RADIUS * 0.25 * frac, Color(1, 1, 1, frac * 0.35))
	elif style == "rainbow":
		for i in range(n):
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var c := Color.from_hsv(fmod(float(i) / float(n) + t * 0.5, 1.0), 0.9, 1.0)
			draw_circle(tr["pos"], DOT_RADIUS * 0.7 * frac, Color(c.r, c.g, c.b, frac * 0.5))
	elif style == "zigzag":
		var pts := PackedVector2Array()
		for i in range(n):
			var p: Vector2 = dot_trail[i]["pos"]
			var perp := Vector2(-(dot_pos.y - p.y), dot_pos.x - p.x).normalized()
			pts.append(p + perp * sin(i * 0.9 + t * 20.0) * 8.0)
		for i in range(pts.size() - 1):
			var fr := float(i) / float(max(1, pts.size() - 1))
			var c := colA.lerp(colB, fr)
			draw_line(pts[i], pts[i + 1], Color(c.r, c.g, c.b, fr * 0.8), 3.0)
	elif style == "bubbles":
		for i in range(n):
			if i % 2 != 0: continue
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var c := colA.lerp(colB, frac)
			draw_circle(tr["pos"], DOT_RADIUS * 0.5 * frac, Color(c.r, c.g, c.b, frac * 0.3))
			draw_arc(tr["pos"], DOT_RADIUS * 0.5 * frac, 0, TAU, 16, Color(c.r, c.g, c.b, frac * 0.7), 1.5)
	elif style == "stars":
		for i in range(n):
			if i % 3 != 0: continue
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var c := colA.lerp(colB, frac)
			var pp: Vector2 = tr["pos"]
			var r := DOT_RADIUS * 0.45 * frac
			draw_line(pp + Vector2(-r, 0), pp + Vector2(r, 0), Color(c.r, c.g, c.b, frac * 0.8), 2.0)
			draw_line(pp + Vector2(0, -r), pp + Vector2(0, r), Color(c.r, c.g, c.b, frac * 0.8), 2.0)
	elif style == "double":
		for i in range(n):
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var p: Vector2 = tr["pos"]
			var perp := Vector2(-(dot_pos.y - p.y), dot_pos.x - p.x).normalized() * 10.0 * frac
			draw_circle(p + perp, DOT_RADIUS * 0.35 * frac, Color(colA.r, colA.g, colA.b, frac * 0.55))
			draw_circle(p - perp, DOT_RADIUS * 0.35 * frac, Color(colB.r, colB.g, colB.b, frac * 0.55))
	elif style == "glow":
		for i in range(n):
			var tr: Dictionary = dot_trail[i]
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			var pulse := 0.7 + 0.3 * sin(t * 12.0 + i * 0.5)
			var c := colA.lerp(colB, 1.0 - frac)
			draw_circle(tr["pos"], DOT_RADIUS * 0.9 * frac, Color(c.r, c.g, c.b, frac * 0.2 * pulse))
			draw_circle(tr["pos"], DOT_RADIUS * 0.45 * frac, Color(c.r, c.g, c.b, frac * 0.45))
	else:
		for tr in dot_trail:
			var age: float = float(tr["age"])
			var frac: float = 1.0 - age / TRAIL_LIFE
			if frac <= 0.0: continue
			draw_circle(tr["pos"], DOT_RADIUS * frac * 0.7, Color(colA.r, colA.g, colA.b, frac * 0.35))

func _draw_world() -> void:
	if current_mode == "duel": _draw_duel_world(); return
	for h in hazards: _draw_hazard(h)
	for p in particles:
		var pc: Color = p["col"]
		var a: float = clampf(float(p["life"]) / float(p["max"]), 0.0, 1.0)
		var sz: float = float(p["size"])
		draw_circle(p["pos"], sz * 1.8, Color(pc.r, pc.g, pc.b, a * 0.4))
		pc.a = a
		draw_circle(p["pos"], sz * a, pc)
	for e in enemies:
		var ep: Vector2 = e["pos"]; var er: float = e["radius"]; var ec: Color = e["color"]
		var breathe := 0.9 + 0.1 * sin(t * 3.0 + ep.x * 0.02)
		draw_circle(ep + Vector2(3, 4), er + 1.0, Color(0, 0, 0, 0.35))
		var glow2 := clampf(1.0 - ep.distance_to(dot_pos) / 300.0, 0.0, 1.0)
		draw_circle(ep, er + 6.0 + 4.0 * glow2, Color(ec.r, ec.g, ec.b, 0.10 + 0.15 * glow2))
		draw_circle(ep, er * breathe, ec)
		draw_circle(ep + Vector2(-er * 0.3, -er * 0.3), er * 0.35,
			Color(minf(ec.r + 0.25, 1.0), minf(ec.g + 0.25, 1.0), minf(ec.b + 0.25, 1.0), 0.7))
		var eye_off: Vector2 = dot_pos - ep
		if eye_off.length() > 0.01: eye_off = eye_off.normalized() * (er * 0.4)
		draw_circle(ep + eye_off, er * 0.28, Color(0.08, 0.08, 0.10))
		draw_circle(ep + eye_off + Vector2(-er * 0.05, -er * 0.05), er * 0.08, Color(1, 1, 1, 0.6))
		if e["type"] == "heavy": draw_arc(ep, er + 4.0, 0, TAU, 24, Color(1, 0.6, 0.3, 0.5), 2.0)
		elif e["type"] == "splitter": draw_arc(ep, er + 4.0, 0, TAU, 24, Color(1, 0.85, 0.5, 0.5), 1.5)
		elif e["type"] == "boss":
			var hp_frac := float(e.get("hp", BOSS_HP)) / float(BOSS_HP)
			var bw := 110.0
			var by := ep.y - er - 30.0
			draw_rect(Rect2(ep.x - bw*0.5, by, bw, 8), Color(0, 0, 0, 0.7))
			draw_rect(Rect2(ep.x - bw*0.5, by, bw * hp_frac, 8), Color(1, 0.3, 0.3))
			draw_rect(Rect2(ep.x - bw*0.5, by, bw, 8), Color(1, 1, 1, 0.5), false, 1.5)
			draw_arc(ep, er + 6.0, 0, TAU, 32, Color(1, 0.4, 0.4, 0.5), 2.0)

	for pu in powerups:
		var ppos: Vector2 = pu["pos"]
		var ptype: String = str(pu["type"])
		var age: float = float(pu["age"])
		var fade := 1.0
		if age > POWERUP_LIFETIME - 2.0: fade = (POWERUP_LIFETIME - age) / 2.0
		fade = clampf(fade, 0.0, 1.0)
		var pcol: Color
		match ptype:
			"shield": pcol = Color(0.3, 0.6, 1.0)
			"slowmo": pcol = Color(0.6, 0.3, 1.0)
			"magnet": pcol = Color(1.0, 0.5, 0.8)
			"cash": pcol = Color(0.4, 1.0, 0.4)
			_: pcol = Color(1, 1, 1)
		var pdp := ppos + Vector2(0, sin(t * 3.0 + ppos.x * 0.01) * 3.0)
		draw_circle(pdp, POWERUP_RADIUS + 10.0, Color(pcol.r, pcol.g, pcol.b, 0.15 * fade))
		draw_circle(pdp, POWERUP_RADIUS, Color(pcol.r, pcol.g, pcol.b, 0.9 * fade))
		draw_arc(pdp, POWERUP_RADIUS, 0, TAU, 20, Color(1, 1, 1, fade), 2.0)
		var icon := ""
		match ptype:
			"shield": icon = "S"
			"slowmo": icon = "T"
			"magnet": icon = "M"
			"cash": icon = "$"
		var iw: float = font.get_string_size(icon, HORIZONTAL_ALIGNMENT_LEFT, -1, 20).x
		draw_string(font, Vector2(pdp.x - iw * 0.5, pdp.y + 7), icon, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(1, 1, 1, fade))

	_draw_dash_trail()
	_draw_trail()

	var skin: Array = _get_skin(current_skin)
	var primary := _skin_primary(skin); var core := _skin_core(skin); var glow_c := _skin_glow(skin)
	var nearest := 1e9
	for e in enemies: nearest = minf(nearest, (e["pos"] as Vector2).distance_to(dot_pos))
	var pulse_amt: float = clampf(1.0 - nearest / PULSE_RANGE, 0.0, 1.0)
	if state == State.PLAY:
		if shield_timer > 0.0:
			var sp := 0.7 + 0.3 * sin(t * 8.0)
			draw_circle(dot_pos, DOT_RADIUS + 24.0, Color(0.3, 0.6, 1.0, 0.2 * sp))
			draw_arc(dot_pos, DOT_RADIUS + 22.0, 0, TAU, 32, Color(0.3, 0.6, 1.0, 0.7 * sp), 2.5)
		if dash_timer > 0.0:
			var dp := 0.7 + 0.3 * sin(t * 30.0)
			draw_circle(dot_pos, DOT_RADIUS + 20.0, Color(1, 1, 1, 0.25 * dp))
			draw_arc(dot_pos, DOT_RADIUS + 18.0, 0, TAU, 32, Color(1, 1, 1, 0.8), 2.5)
		var beat: float = 0.6 + 0.4 * sin(t * 20.0)
		var core_r := DOT_RADIUS + 6.0 * pulse_amt * beat
		draw_circle(dot_pos + Vector2(-3.0, 0), DOT_RADIUS, Color(1, 0.1, 0.1, 0.25))
		draw_circle(dot_pos + Vector2(3.0, 0), DOT_RADIUS, Color(0.1, 0.4, 1.0, 0.25))
		draw_circle(dot_pos, core_r + 26.0 * pulse_amt, Color(glow_c.r, glow_c.g, glow_c.b, 0.10 * pulse_amt + 0.06))
		draw_circle(dot_pos, core_r + 12.0 * pulse_amt, Color(primary.r, primary.g, primary.b, 0.28 * pulse_amt + 0.15))
		if current_skin == CUSTOM_ORB_ID and custom_orb_texture != null:
			var ts := custom_orb_texture.get_size()
			if ts.x > 0 and ts.y > 0:
				var sc := (DOT_RADIUS * 2.0) / maxf(ts.x, ts.y)
				var ds := ts * sc
				draw_texture_rect(custom_orb_texture, Rect2(dot_pos - ds * 0.5, ds), false)
		else:
			draw_circle(dot_pos, DOT_RADIUS, primary)
			draw_circle(dot_pos + Vector2(-4, -4), DOT_RADIUS * 0.45, core)
		var blink := sin(t * 30.0)
		if blink > 0.4: draw_circle(dot_pos, DOT_RADIUS * 0.22, Color(1, 1, 1, (blink - 0.4) / 0.6))
	else:
		if current_skin == CUSTOM_ORB_ID and custom_orb_texture != null:
			var ts := custom_orb_texture.get_size()
			if ts.x > 0 and ts.y > 0:
				var sc := (DOT_RADIUS * 2.0) / maxf(ts.x, ts.y)
				var ds := ts * sc
				draw_texture_rect(custom_orb_texture, Rect2(dot_pos - ds * 0.5, ds), false)
		else:
			draw_circle(dot_pos, DOT_RADIUS, primary)
			draw_circle(dot_pos + Vector2(-4, -4), DOT_RADIUS * 0.4, core)

	if joy_active:
		var knob := joy_base + joy_vec * JOY_RADIUS
		draw_circle(joy_base, JOY_RADIUS, Color(1, 1, 1, 0.08))
		draw_arc(joy_base, JOY_RADIUS, 0, TAU, 40, Color(1, 1, 1, 0.35), 2.5)
		draw_circle(knob, 26.0, Color(1, 1, 1, 0.25))
		draw_arc(knob, 26.0, 0, TAU, 24, Color(1, 1, 1, 0.6), 2.0)
	if current_mode == "duel":
		if joy_p1_active:
			var knob := joy_p1_base + joy_p1_vec * JOY_RADIUS
			draw_circle(joy_p1_base, JOY_RADIUS, Color(1, 0.4, 0.4, 0.08))
			draw_arc(joy_p1_base, JOY_RADIUS, 0, TAU, 40, Color(1, 0.4, 0.4, 0.4), 2.5)
			draw_circle(knob, 26.0, Color(1, 0.4, 0.4, 0.3))
			draw_arc(knob, 26.0, 0, TAU, 24, Color(1, 0.4, 0.4, 0.7), 2.0)
		if joy_p2_active:
			var knob := joy_p2_base + joy_p2_vec * JOY_RADIUS
			draw_circle(joy_p2_base, JOY_RADIUS, Color(0.4, 0.6, 1.0, 0.08))
			draw_arc(joy_p2_base, JOY_RADIUS, 0, TAU, 40, Color(0.4, 0.6, 1.0, 0.4), 2.5)
			draw_circle(knob, 26.0, Color(0.4, 0.6, 1.0, 0.3))
			draw_arc(knob, 26.0, 0, TAU, 24, Color(0.4, 0.6, 1.0, 0.7), 2.0)
	_draw_text_particles()

func _draw_duel_world() -> void:
	var mp := machine_pos
	draw_circle(mp + Vector2(3, 4), 52.0, Color(0, 0, 0, 0.35))
	draw_circle(mp, 52.0, Color(0.14, 0.14, 0.18))
	draw_arc(mp, 52.0, 0, TAU, 48, Color(0.4, 0.4, 0.5), 3.0)
	draw_circle(mp, 28.0, Color(0.2, 0.2, 0.26))
	draw_circle(mp, 14.0, Color(0.35, 0.35, 0.45))
	var mpulse := 0.5 + 0.5 * sin(t * 4.0)
	draw_circle(mp, 7.0 + 2.0 * mpulse, Color(0.6, 0.6, 0.8, 0.6))
	if duel_phase == "charging":
		var gc := Color(1, 0.3, 0.3, 0.55) if duel_winner == "red" else Color(0.3, 0.6, 1.0, 0.55)
		var p2: float = 0.5 + 0.5 * sin(t * 30.0)
		draw_circle(mp, 72.0 + 10.0 * p2, Color(gc.r, gc.g, gc.b, 0.15 + 0.2 * p2))
		draw_arc(mp, 72.0 + 10.0 * p2, 0, TAU, 48, Color(gc.r, gc.g, gc.b, 0.8), 3.0)
	for c in crystals:
		var cp: Vector2 = c["pos"]; var age: float = float(c["age"])
		var lf := clampf(1.0 - age / DUEL_CRYSTAL_LIFETIME, 0.0, 1.0)
		var fade := clampf(lf * 2.0, 0.0, 1.0)
		var dp := cp + Vector2(0, sin(t * 4.0) * 2.0)
		draw_circle(dp, DUEL_CRYSTAL_RADIUS + 14.0, Color(0.7, 0.4, 1.0, 0.15 * fade))
		draw_circle(dp, DUEL_CRYSTAL_RADIUS + 7.0, Color(0.8, 0.5, 1.0, 0.4 * fade))
		draw_circle(dp, DUEL_CRYSTAL_RADIUS, Color(0.9, 0.6, 1.0, fade))
		draw_circle(dp + Vector2(-2, -2), DUEL_CRYSTAL_RADIUS * 0.5, Color(1, 1, 1, 0.9 * fade))
		draw_arc(dp, DUEL_CRYSTAL_RADIUS + 9.0, -PI / 2.0, -PI / 2.0 + TAU * lf, 24, Color(0.95, 0.75, 1.0, 0.75), 2.0)
	var pr := 0.6 + 0.4 * sin(t * 12.0)
	draw_circle(p1_pos + Vector2(2, 3), DUEL_PLAYER_RADIUS + 2.0, Color(0, 0, 0, 0.35))
	draw_circle(p1_pos, DUEL_PLAYER_RADIUS + 12.0 * pr, Color(1, 0.2, 0.2, 0.18))
	draw_circle(p1_pos, DUEL_PLAYER_RADIUS + 5.0, Color(1, 0.2, 0.2, 0.4))
	draw_circle(p1_pos, DUEL_PLAYER_RADIUS, Color(1, 0.25, 0.25))
	draw_circle(p1_pos + Vector2(-4, -4), DUEL_PLAYER_RADIUS * 0.5, Color(1, 0.85, 0.85))
	draw_circle(p2_pos + Vector2(2, 3), DUEL_PLAYER_RADIUS + 2.0, Color(0, 0, 0, 0.35))
	draw_circle(p2_pos, DUEL_PLAYER_RADIUS + 12.0 * pr, Color(0.2, 0.5, 1.0, 0.18))
	draw_circle(p2_pos, DUEL_PLAYER_RADIUS + 5.0, Color(0.2, 0.5, 1.0, 0.4))
	draw_circle(p2_pos, DUEL_PLAYER_RADIUS, Color(0.25, 0.5, 1.0))
	draw_circle(p2_pos + Vector2(-4, -4), DUEL_PLAYER_RADIUS * 0.5, Color(0.85, 0.9, 1.0))
	if duel_phase == "charging":
		var tp := p1_pos if duel_winner == "blue" else p2_pos
		var p3: float = 0.5 + 0.5 * sin(t * 40.0)
		draw_line(mp, tp, Color(1, 0.9, 0.5, 0.35 + 0.35 * p3), 2.0)
		draw_arc(tp, 24.0 + 8.0 * p3, 0, TAU, 24, Color(1, 0.9, 0.5, 0.75), 2.0)
	elif duel_phase == "done" or duel_phase == "beam":
		var bc := Color(1, 0.35, 0.35, 1.0) if duel_winner == "red" else Color(0.4, 0.6, 1.0, 1.0)
		draw_line(mp, duel_laser_end, Color(1, 1, 1, 0.9), DUEL_LASER_WIDTH)
		draw_line(mp, duel_laser_end, Color(bc.r, bc.g, bc.b, 0.95), DUEL_LASER_WIDTH + 8.0)
		draw_line(mp, duel_laser_end, Color(1, 1, 0.9, 1.0), DUEL_LASER_WIDTH * 0.35)

func _draw_hitboxes() -> void:
	if not settings["show_hitboxes"]: return
	if current_mode == "duel":
		draw_arc(p1_pos, DUEL_PLAYER_RADIUS, 0, TAU, 24, Color(0.3, 1.0, 1.0, 0.8), 1.0)
		draw_arc(p2_pos, DUEL_PLAYER_RADIUS, 0, TAU, 24, Color(0.3, 1.0, 1.0, 0.8), 1.0)
		for c in crystals: draw_arc(c["pos"], DUEL_PICKUP_RADIUS, 0, TAU, 24, Color(1.0, 0.3, 1.0, 0.6), 1.0)
		return
	draw_arc(dot_pos, DOT_RADIUS, 0, TAU, 32, Color(0.3, 1.0, 1.0, 0.95), 1.5)
	var aoe: float = float(active_effects["aoe_mult"])
	for e in enemies: draw_arc(e["pos"], float(e["radius"]), 0, TAU, 24, Color(0.3, 1.0, 1.0, 0.65), 1.0)
	for h in hazards:
		var d: Dictionary = h["data"]
		var c := Color(1.0, 0.3, 1.0, 0.75)
		match h["type"]:
			"laser":
				var axis: String = d["axis"]; var pos: float = float(d["pos"])
				var band := LASER_BAND * aoe
				if axis == "h":
					draw_line(Vector2(play_rect.position.x, pos - band), Vector2(play_rect.end.x, pos - band), c, 1.0)
					draw_line(Vector2(play_rect.position.x, pos + band), Vector2(play_rect.end.x, pos + band), c, 1.0)
				else:
					draw_line(Vector2(pos - band, play_rect.position.y), Vector2(pos - band, play_rect.end.y), c, 1.0)
					draw_line(Vector2(pos + band, play_rect.position.y), Vector2(pos + band, play_rect.end.y), c, 1.0)
			"saw": draw_arc(d["current"], SAW_RADIUS, 0, TAU, 24, c, 1.0)
			"shock": draw_arc(d["pos"], float(d["max_r"]) * aoe, 0, TAU, 48, c, 1.0)
			_: draw_arc(d["pos"], float(d["radius"]) * aoe, 0, TAU, 32, c, 1.0)

func _draw_fps() -> void:
	draw_string(font, Vector2(play_rect.end.x - 100, play_rect.end.y - 12),
		"%d fps" % Engine.get_frames_per_second(), HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(0.6, 0.6, 0.6))

func _draw_meteor_warn(pos: Vector2, radius: float, tr: float) -> void:
	var pulse := 0.7 + 0.3 * sin(t * 14.0)
	for i in range(3):
		draw_arc(pos, radius * (0.35 + 0.25 * i) * (1.0 - tr * 0.2), 0, TAU, 32, Color(1.0, 0.5, 0.2, 0.35 - i * 0.08), 2.0)
	draw_circle(pos, radius * 0.5 * tr, Color(1.0, 0.5, 0.2, 0.15 * pulse))
	draw_arc(pos, radius, 0, TAU, 48, Color(1.0, 0.4, 0.15, 0.8), 2.5)
	var ch := radius * 0.6 * (1.0 - tr * 0.5)
	var cc := Color(1, 0.5, 0.2, 0.9)
	draw_line(pos + Vector2(-ch, 0), pos + Vector2(-ch * 0.4, 0), cc, 2.0)
	draw_line(pos + Vector2(ch * 0.4, 0), pos + Vector2(ch, 0), cc, 2.0)
	draw_line(pos + Vector2(0, -ch), pos + Vector2(0, -ch * 0.4), cc, 2.0)
	draw_line(pos + Vector2(0, ch * 0.4), pos + Vector2(0, ch), cc, 2.0)
	var from := pos + Vector2(-radius * 3.5, -radius * 3.5)
	var curr := from.lerp(pos, 1.0 - tr)
	var rs := radius * 0.55
	for i in range(10):
		var bt := 1.0 - tr - (i + 1) * 0.05
		if bt < 0.0: break
		draw_circle(from.lerp(pos, bt), rs * (1.0 - i * 0.07) * (0.7 + 0.3 * sin(t * 25.0 + i)),
			Color(1, 0.45 - i * 0.03, 0.15, (1.0 - float(i) / 10.0) * 0.75))
	var verts := PackedVector2Array()
	var pts_l := [Vector2(-1.0, -0.3), Vector2(-0.6, -1.0), Vector2(0.3, -0.9),
		Vector2(1.0, -0.4), Vector2(0.9, 0.4), Vector2(0.4, 1.0),
		Vector2(-0.4, 0.9), Vector2(-0.9, 0.3)]
	for rp in pts_l: verts.append(curr + (rp as Vector2).rotated(t * 3.0) * rs * 0.7)
	draw_circle(curr, rs * 1.1, Color(1, 0.4, 0.1, 0.3))
	draw_circle(curr, rs * 0.7, Color(1, 0.6, 0.25, 0.5))
	draw_colored_polygon(verts, Color(0.35, 0.22, 0.15))
	for i in range(verts.size()):
		draw_line(verts[i], verts[(i + 1) % verts.size()], Color(0.55, 0.35, 0.2), 1.5)
	draw_circle(curr + Vector2(-rs * 0.2, -rs * 0.2), rs * 0.22, Color(0.7, 0.5, 0.3, 0.8))

func _draw_meteor_explode(pos: Vector2, radius: float, prog: float) -> void:
	var f := 1.0 - prog
	draw_circle(pos, radius * (0.4 + f * 1.6), Color(1.0, 0.4, 0.1, f * 0.85))
	draw_circle(pos, radius * (0.3 + f * 1.1), Color(1.0, 0.7, 0.2, f * 0.8))
	draw_circle(pos, radius * (0.2 + f * 0.6), Color(1.0, 0.95, 0.7, f))
	for i in range(14):
		var ang := i * TAU / 14.0 + t * 0.3
		var ln := radius * (0.3 + f * 1.3)
		draw_line(pos + Vector2(cos(ang), sin(ang)) * radius * 0.15,
			pos + Vector2(cos(ang), sin(ang)) * ln, Color(1.0, 0.55, 0.2, f * 0.75), 3.0)
	draw_arc(pos, radius * (0.5 + f * 2.2), 0, TAU, 48, Color(1.0, 0.7, 0.4, f * 0.6), 3.5)

func _draw_bomb_warn(pos: Vector2, radius: float, tr: float) -> void:
	var pulse := 0.7 + 0.3 * sin(t * 16.0)
	for i in range(3):
		draw_arc(pos, radius * (0.35 + 0.25 * i), 0, TAU, 40, Color(1.0, 0.3, 0.2, 0.3 - i * 0.08), 1.5)
	draw_circle(pos, radius * 0.4, Color(1, 0.3, 0.2, 0.1 * pulse))
	draw_arc(pos, radius, 0, TAU, 48, Color(1, 0.35, 0.2, 0.85), 2.5)
	var ch := radius * 0.7
	var cc := Color(1, 0.4, 0.2, 0.8)
	draw_line(pos + Vector2(-ch, 0), pos + Vector2(-ch * 0.5, 0), cc, 2.0)
	draw_line(pos + Vector2(ch * 0.5, 0), pos + Vector2(ch, 0), cc, 2.0)
	draw_line(pos + Vector2(0, -ch), pos + Vector2(0, -ch * 0.5), cc, 2.0)
	draw_line(pos + Vector2(0, ch * 0.5), pos + Vector2(0, ch), cc, 2.0)
	var bs := radius * 0.35
	var bp := pos + Vector2(0, -radius * 4.0 * (1.0 - tr))
	draw_circle(pos + Vector2(0, radius * 0.4), bs * (0.5 + 0.6 * tr), Color(0, 0, 0, 0.25 + 0.15 * tr))
	var fs := bp + Vector2(0, -bs * 0.75)
	var fpts := PackedVector2Array()
	for i in range(7):
		var f01 := float(i) / 6.0
		fpts.append(fs + Vector2(sin(f01 * 4.0 + t * 3.0) * bs * 0.4 + sin(t * 8.0) * 2.0 * f01, -f01 * bs * 1.4))
	for i in range(fpts.size() - 1):
		draw_line(fpts[i], fpts[i + 1], Color(0.35, 0.25, 0.15), 3.5)
		draw_line(fpts[i], fpts[i + 1], Color(0.55, 0.40, 0.25), 1.5)
	var sp := fpts[fpts.size() - 1]
	var sp_p := 0.6 + 0.4 * sin(t * 35.0)
	draw_circle(sp, bs * 0.4 * sp_p, Color(1, 0.6, 0.1, 0.4))
	draw_circle(sp, bs * 0.25 * sp_p, Color(1, 0.9, 0.4, 0.85))
	draw_circle(bp, bs, Color(0.08, 0.06, 0.05))
	draw_circle(bp + Vector2(-bs * 0.3, -bs * 0.3), bs * 0.55, Color(0.25, 0.20, 0.18))
	draw_circle(bp + Vector2(-bs * 0.4, -bs * 0.4), bs * 0.25, Color(0.55, 0.50, 0.45, 0.9))

func _draw_bomb_explode(pos: Vector2, radius: float, prog: float) -> void:
	var f := 1.0 - prog
	draw_circle(pos, radius * (0.4 + f * 1.8), Color(1.0, 0.35, 0.1, f * 0.9))
	draw_circle(pos, radius * (0.3 + f * 1.2), Color(1.0, 0.65, 0.2, f * 0.85))
	draw_circle(pos, radius * (0.2 + f * 0.7), Color(1.0, 0.95, 0.6, f))
	for i in range(20):
		var ang := i * TAU / 20.0 + 0.15
		var ln := radius * (0.2 + f * 1.6)
		draw_line(pos + Vector2(cos(ang), sin(ang)) * radius * 0.1,
			pos + Vector2(cos(ang), sin(ang)) * ln, Color(1.0, 0.5, 0.2, f * 0.85), 2.5)
	draw_arc(pos, radius * (0.4 + f * 2.4), 0, TAU, 48, Color(0.15, 0.10, 0.08, f * 0.5), 4.0)

func _draw_hazard(h: Dictionary) -> void:
	var d: Dictionary = h["data"]
	var aoe: float = float(active_effects["aoe_mult"])
	var fm: float = float(active_effects["fire_mult"])
	match h["type"]:
		"laser":
			var axis: String = d["axis"]; var pos: float = float(d["pos"])
			var band := LASER_BAND * aoe
			if h["state"] == "warn":
				var a: float = 0.3 + 0.3 * sin(t * 30.0)
				var col := Color(1.0, 0.3, 0.35, a); var edge := Color(1.0, 0.4, 0.45, 0.95)
				if axis == "h":
					draw_rect(Rect2(play_rect.position.x, pos - band, play_rect.size.x, band * 2.0), col)
					draw_line(Vector2(play_rect.position.x, pos - band), Vector2(play_rect.end.x, pos - band), edge, 2.5)
					draw_line(Vector2(play_rect.position.x, pos + band), Vector2(play_rect.end.x, pos + band), edge, 2.5)
				else:
					draw_rect(Rect2(pos - band, play_rect.position.y, band * 2.0, play_rect.size.y), col)
					draw_line(Vector2(pos - band, play_rect.position.y), Vector2(pos - band, play_rect.end.y), edge, 2.5)
					draw_line(Vector2(pos + band, play_rect.position.y), Vector2(pos + band, play_rect.end.y), edge, 2.5)
			else:
				var f: float = float(h["fire"]) / (LASER_FIRE * fm)
				var col := Color(1.0, 0.9, 0.9, f)
				if axis == "h": draw_rect(Rect2(play_rect.position.x, pos - band, play_rect.size.x, band * 2.0), col)
				else: draw_rect(Rect2(pos - band, play_rect.position.y, band * 2.0, play_rect.size.y), col)
		"mine":
			var pos: Vector2 = d["pos"]; var radius: float = float(d["radius"]) * aoe
			if h["state"] == "warn":
				var a: float = 0.25 + 0.35 * sin(t * 28.0)
				draw_circle(pos, radius, Color(1.0, 0.3, 0.2, a * 0.5))
				draw_arc(pos, radius, 0, TAU, 32, Color(1.0, 0.4, 0.25, 0.95), 2.5)
				draw_circle(pos, 6.0, Color(1.0, 0.35, 0.2))
			else:
				var f: float = float(h["fire"]) / (MINE_FIRE * fm)
				draw_circle(pos, radius * (1.0 + (1.0 - f) * 0.4), Color(1.0, 0.5, 0.2, f * 0.9))
				draw_arc(pos, radius * (1.0 + (1.0 - f) * 0.4), 0, TAU, 32, Color(1.0, 0.9, 0.6, f), 3.0)
		"meteor":
			var pos: Vector2 = d["pos"]; var radius: float = float(d["radius"]) * aoe
			if h["state"] == "warn":
				_draw_meteor_warn(pos, radius, clampf(float(h["warn"]) / METEOR_WARN, 0.0, 1.0))
			else:
				_draw_meteor_explode(pos, radius, 1.0 - float(h["fire"]) / (METEOR_FIRE * fm))
		"pulse":
			var pos: Vector2 = d["pos"]; var radius: float = float(d["radius"]) * aoe
			if h["state"] == "warn":
				var tr: float = clampf(float(h["warn"]) / PULSE_WARN, 0.0, 1.0)
				draw_circle(pos, radius * (1.0 - tr * 0.6), Color(0.4, 0.6, 1.0, 0.15))
				draw_arc(pos, radius * (1.0 - tr * 0.6), 0, TAU, 48, Color(0.5, 0.7, 1.0, 0.95), 3.0)
				draw_circle(pos, 8.0 + 6.0 * sin(t * 20.0), Color(0.6, 0.8, 1.0, 0.9))
			else:
				var f: float = float(h["fire"]) / (PULSE_FIRE * fm)
				draw_circle(pos, radius * 0.5, Color(0.5, 0.7, 1.0, f * 0.4))
				draw_arc(pos, radius, 0, TAU, 48, Color(0.8, 0.9, 1.0, f), 3.0)
				draw_arc(pos, radius * (1.0 - f * 0.8), 0, TAU, 48, Color(0.9, 0.95, 1.0, f), 4.0)
		"bomb":
			var pos: Vector2 = d["pos"]; var radius: float = float(d["radius"]) * aoe
			if h["state"] == "warn":
				_draw_bomb_warn(pos, radius, 1.0 - clampf(float(h["warn"]) / BOMB_WARN, 0.0, 1.0))
			else:
				_draw_bomb_explode(pos, radius, 1.0 - float(h["fire"]) / (BOMB_FIRE * fm))
		"saw":
			var current: Vector2 = d["current"]
			if h["state"] == "warn":
				if d.get("path", "linear") == "spiral":
					var center: Vector2 = d["center"]
					var r0: float = float(d["start_radius"]); var r1: float = float(d["end_radius"])
					var rot: float = float(d["rotations"]); var sa: float = float(d["start_angle"])
					var pts := PackedVector2Array()
					for i in 40:
						var t01 := float(i) / 39.0
						pts.append(center + Vector2(cos(sa + rot * TAU * t01), sin(sa + rot * TAU * t01)) * lerpf(r0, r1, t01))
					for i in pts.size() - 1: draw_line(pts[i], pts[i + 1], Color(1.0, 0.35, 0.3, 0.35), 1.5)
				else:
					draw_line(d["start"], d["end"], Color(1.0, 0.35, 0.3, 0.35), 2.0)
				_draw_saw_body(current, SAW_RADIUS, t * 4.0, Color(1, 0.5, 0.4), false)
			else:
				var prog := clampf((SAW_TRAVEL * fm - float(h["fire"])) / (SAW_TRAVEL * fm), 0.0, 1.0)
				for j in range(5):
					var tp := prog - (j + 1) * 0.025
					if tp < 0.0: break
					draw_circle(_saw_pos_at(d, tp), SAW_RADIUS * (0.85 - j * 0.08),
						Color(1.0, 0.4, 0.3, (1.0 - float(j) / 5.0) * 0.35))
				_draw_saw_body(current, SAW_RADIUS, t * 20.0, Color(1, 0.45, 0.35), true)
		"shock":
			var pos: Vector2 = d["pos"]; var max_r: float = float(d["max_r"]) * aoe
			if h["state"] == "warn":
				var tr: float = 1.0 - clampf(float(h["warn"]) / SHOCK_WARN, 0.0, 1.0)
				draw_circle(pos, max_r, Color(0.5, 0.65, 1.0, 0.08 + 0.08 * sin(t * 20.0)))
				draw_arc(pos, max_r * tr, 0, TAU, 64, Color(0.6, 0.7, 1.0, 0.6), 2.0)
				draw_arc(pos, max_r, 0, TAU, 64, Color(0.6, 0.7, 1.0, 0.8), 3.0)
				draw_circle(pos, 6.0 + 4.0 * sin(t * 20.0), Color(0.75, 0.85, 1.0, 0.95))
			else:
				var total := SHOCK_FIRE * fm
				var prog: float = clampf((total - float(h["fire"])) / total, 0.0, 1.0)
				var ring_r := max_r * prog
				var f: float = 1.0 - prog
				draw_arc(pos, ring_r, 0, TAU, 64, Color(0.7, 0.85, 1.0, f), 4.0)
				draw_arc(pos, ring_r - 10.0, 0, TAU, 64, Color(0.5, 0.7, 1.0, f * 0.5), 6.0)

func _draw_hud() -> void:
	if current_mode == "duel": _draw_duel_hud(); return
	var ox := play_rect.position.x + UI_MARGIN; var oy := play_rect.position.y + UI_MARGIN
	match current_mode:
		"classic":
			draw_string(font, Vector2(ox, oy + 8), "Wave %d" % wave, HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color(0.92, 0.92, 0.98))
		"speedrun":
			draw_string(font, Vector2(ox, oy + 8), "Wave %d of %d" % [wave, SPEEDRUN_TARGET], HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color(0.92, 0.92, 0.98))
			draw_string(font, Vector2(ox, oy + 32), _fmt_time(speedrun_time), HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(1.0, 0.85, 0.4))
		"waveless":
			draw_string(font, Vector2(ox, oy + 8), _fmt_time(waveless_time), HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color(0.92, 0.92, 0.98))
			draw_string(font, Vector2(ox, oy + 32), "Kills: %d" % kills_this_run, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(1.0, 0.85, 0.4))
	if current_mode != "waveless":
		var ey := 52.0 if current_mode == "speedrun" else 32.0
		draw_string(font, Vector2(ox, oy + ey), "Enemies left: %d" % (enemies.size() + to_spawn), HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(0.55, 0.55, 0.65))
	var mtxt := "$%d" % money
	var mw: float = font.get_string_size(mtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
	var money_col := Color(1, 0.85, 0.4)
	if _money_flash > 0.0:
		var fa := _money_flash / 0.6
		money_col = money_col.lerp(Color(0.4, 1.0, 0.5), fa)
	draw_string(font, Vector2(play_rect.end.x - mw - UI_MARGIN, oy + 8), mtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, money_col)
	var bv := _best(current_mode)
	var bt := "Best: —"
	if bv > 0.0:
		if current_mode == "classic": bt = "Best: W%d" % int(bv)
		elif current_mode == "waveless": bt = "Best: %d kills" % int(bv)
		else: bt = "Best: %s" % _fmt_time(bv)
	var btw: float = font.get_string_size(bt, HORIZONTAL_ALIGNMENT_LEFT, -1, 13).x
	draw_string(font, Vector2(play_rect.end.x - btw - UI_MARGIN, oy + 30), bt, HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color(0.65, 0.65, 0.75))
	var max_rev := int(active_effects["max_revives"])
	var effect_y := oy + 50.0
	if max_rev > 0:
		for i in range(max_rev):
			var pip_col := Color(0.4, 1.0, 0.5) if i < revives_remaining else Color(0.25, 0.35, 0.28, 0.7)
			draw_circle(Vector2(play_rect.end.x - UI_MARGIN - 6 - i * 16, oy + 50), 5.0, pip_col)
		effect_y = oy + 72.0
		if bool(no_tier_owned.get("revive_regen", false)) and revives_remaining < max_rev:
			var prog := clampf(_revive_regen_timer / _revive_regen_interval, 0.0, 1.0)
			var left := maxf(0.0, _revive_regen_interval - _revive_regen_timer)
			var rg_txt := "Phoenix Core  %.1fs" % left
			var rg_w: float = font.get_string_size(rg_txt, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
			var rg_x: float = play_rect.end.x - UI_MARGIN - rg_w
			draw_string(font, Vector2(rg_x, oy + 68), rg_txt, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(1.0, 0.75, 0.35))
			var bar_w := 90.0
			var bar_x: float = play_rect.end.x - UI_MARGIN - bar_w
			var bar_y := oy + 72.0
			draw_rect(Rect2(bar_x, bar_y, bar_w, 5), Color(0, 0, 0, 0.6))
			draw_rect(Rect2(bar_x, bar_y, bar_w * prog, 5), Color(1.0, 0.75, 0.35))
			draw_rect(Rect2(bar_x, bar_y, bar_w, 5), Color(1, 1, 1, 0.35), false, 1.0)
			effect_y = oy + 88.0
	# NEW: dash cooldown pip
	if current_mode != "duel":
		var dc := 1.0 - clampf(dash_cooldown / DASH_COOLDOWN, 0.0, 1.0)
		var dcx: float = ox
		var dcy: float = oy + 52.0
		draw_rect(Rect2(dcx, dcy, 60, 5), Color(0, 0, 0, 0.6))
		draw_rect(Rect2(dcx, dcy, 60 * dc, 5), Color(0.4, 1.0, 0.5) if dc >= 1.0 else Color(0.6, 0.6, 0.7))
		draw_rect(Rect2(dcx, dcy, 60, 5), Color(1, 1, 1, 0.35), false, 1.0)
		draw_string(font, Vector2(dcx + 66, dcy + 5), "DASH [Space]", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color(0.6, 0.6, 0.7))
	if shield_timer > 0.0:
		draw_string(font, Vector2(ox, effect_y), "Shield %.1f" % shield_timer, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(0.3, 0.6, 1.0)); effect_y += 20.0
	if slowmo_timer > 0.0:
		draw_string(font, Vector2(ox, effect_y), "Slow-mo %.1f" % slowmo_timer, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(0.6, 0.3, 1.0)); effect_y += 20.0
	if magnet_timer > 0.0:
		draw_string(font, Vector2(ox, effect_y), "Magnet %.1f" % magnet_timer, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(1.0, 0.5, 0.8))
	# NEW: combo display
	if combo_count >= 3:
		var ctxt := "x%d" % combo_count
		var cw: float = font.get_string_size(ctxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 24).x
		var pulse := 1.0 + 0.15 * sin(t * 15.0)
		var ccol := Color(1, 0.85, 0.4)
		if combo_count >= 25: ccol = Color(1, 0.3, 0.3)
		elif combo_count >= 10: ccol = Color(1, 0.6, 0.2)
		draw_string(font, Vector2(play_rect.position.x + (play_rect.size.x - cw) * 0.5, oy + 30),
			ctxt, HORIZONTAL_ALIGNMENT_LEFT, -1, int(24 * pulse), ccol)
	if wave_announce_timer > 0.0 and current_mode != "waveless":
		var a2: float = min(1.0, wave_announce_timer)
		var is_boss := current_mode == "classic" and wave % BOSS_WAVE_INTERVAL == 0
		var sc := 1.0 + (0.30 if is_boss else 0.15) * sin(t * 8.0) * (1.0 - a2)
		var wtxt := "BOSS!" if is_boss else "Wave %d" % wave
		var wcol := Color(1, 0.35, 0.4) if is_boss else Color(1, 1, 1)
		var ww: float = font.get_string_size(wtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, int(56 * sc)).x
		draw_string(font, Vector2(play_rect.position.x + (play_rect.size.x - ww) * 0.5, oy + play_rect.size.y * 0.3),
			wtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, int(56 * sc), Color(wcol.r, wcol.g, wcol.b, a2))

func _draw_duel_hud() -> void:
	var ox := play_rect.position.x + UI_MARGIN; var oy := play_rect.position.y + UI_MARGIN
	var p_max: int = DUEL_LIVES_START + int(active_effects["extra_lives"])
	draw_string(font, Vector2(ox, oy + 8), "Red: %d / %d" % [p1_crystals, DUEL_TARGET], HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color(1, 0.3, 0.3))
	draw_string(font, Vector2(ox, oy + 28), "Arrow Keys", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(1, 0.5, 0.5, 0.7))
	for i in range(p1_lives): draw_circle(Vector2(ox + 6 + i * 16, oy + 46), 5.0, Color(1, 0.35, 0.35))
	for i in range(p_max - p1_lives): draw_circle(Vector2(ox + 6 + (p1_lives + i) * 16, oy + 46), 5.0, Color(0.3, 0.3, 0.3, 0.5))
	var blue_text := "Blue: %d / %d" % [p2_crystals, DUEL_TARGET]
	var btw: float = font.get_string_size(blue_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 22).x
	draw_string(font, Vector2(play_rect.end.x - btw - UI_MARGIN, oy + 8), blue_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color(0.3, 0.6, 1.0))
	for i in range(p2_lives): draw_circle(Vector2(play_rect.end.x - UI_MARGIN - 6 - i * 16, oy + 46), 5.0, Color(0.4, 0.6, 1.0))
	for i in range(p_max - p2_lives): draw_circle(Vector2(play_rect.end.x - UI_MARGIN - 6 - (p2_lives + i) * 16, oy + 46), 5.0, Color(0.3, 0.3, 0.3, 0.5))
	if duel_phase == "charging":
		var msg := "Laser firing in %.1f..." % max(0.0, duel_charge_timer)
		var mw: float = font.get_string_size(msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 26).x
		draw_string(font, Vector2(play_rect.position.x + (play_rect.size.x - mw) * 0.5, oy + play_rect.size.y * 0.15), msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 26, Color(1, 0.9, 0.4))
	elif duel_phase == "beam":
		var msg := "Round reset in %.1f" % max(0.0, duel_beam_timer)
		var mw: float = font.get_string_size(msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 24).x
		draw_string(font, Vector2(play_rect.position.x + (play_rect.size.x - mw) * 0.5, oy + play_rect.size.y * 0.15), msg, HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color(1, 0.7, 0.4))

func _draw_over() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.65))
	var big := "Game Over"; var col := Color(1.0, 0.28, 0.33)
	var sub1 := ""; var sub2 := ""
	if current_mode == "duel":
		if p1_lives <= 0: big = "Blue Wins!"; col = Color(0.4, 0.65, 1.0)
		elif p2_lives <= 0: big = "Red Wins!"; col = Color(1.0, 0.35, 0.35)
		sub1 = "Red: %d lives  \u2022  Blue: %d lives" % [maxi(0, p1_lives), maxi(0, p2_lives)]
	else:
		var is_win := state == State.WIN and current_mode == "speedrun"
		if is_win:
			big = "You Won!"; col = Color(0.4, 1.0, 0.5)
			sub1 = "Congratulations!"
			var earned: int = 300 + int(600.0 * maxf(0.0, 1.0 - minf(speedrun_time, 180.0) / 180.0))
			sub2 = "You beat wave %d in %s.  +$%d" % [SPEEDRUN_TARGET, _fmt_time(speedrun_time), earned]
		else:
			match current_mode:
				"classic":
					sub1 = "Reached wave %d." % wave
					if classic_checkpoint > 0: sub2 = "Checkpoint: Wave %d" % classic_checkpoint
				"speedrun":
					sub1 = "Died on wave %d of %d." % [wave, SPEEDRUN_TARGET]
					sub2 = "Time: %s" % _fmt_time(speedrun_time)
				"waveless":
					var earned: int = 5 * kills_this_run
					sub1 = "Survived %s." % _fmt_time(waveless_time)
					sub2 = "%d kills  +$%d" % [kills_this_run, earned]
	var bigw: float = font.get_string_size(big, HORIZONTAL_ALIGNMENT_LEFT, -1, 52).x
	draw_string(font, Vector2((screen.x - bigw) * 0.5, screen.y * 0.32), big, HORIZONTAL_ALIGNMENT_LEFT, -1, 52, col)
	var y := screen.y * 0.32 + 40.0
	if sub1 != "":
		var w1: float = font.get_string_size(sub1, HORIZONTAL_ALIGNMENT_LEFT, -1, 22).x
		draw_string(font, Vector2((screen.x - w1) * 0.5, y), sub1, HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color(1.0, 0.85, 0.4)); y += 32.0
	if sub2 != "":
		var w2: float = font.get_string_size(sub2, HORIZONTAL_ALIGNMENT_LEFT, -1, 20).x
		draw_string(font, Vector2((screen.x - w2) * 0.5, y), sub2, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(0.92, 0.92, 0.98))
	var bw := 200.0; var bh := 52.0; var gap := 24.0
	var total_w := bw * 2.0 + gap
	var bx := (screen.x - total_w) * 0.5
	var by := screen.y * 0.60
	overlay_btn_left = Rect2(bx, by, bw, bh)
	overlay_btn_right = Rect2(bx + bw + gap, by, bw, bh)
	_draw_button(overlay_btn_left, "Retry [Space]")
	_draw_button(overlay_btn_right, "Menu [Esc]")

func _draw_pause() -> void:
	draw_rect(Rect2(Vector2.ZERO, screen), Color(0, 0, 0, 0.78))
	var t1w: float = font.get_string_size("Paused", HORIZONTAL_ALIGNMENT_LEFT, -1, 48).x
	draw_string(font, Vector2((screen.x - t1w) * 0.5, 80), "Paused", HORIZONTAL_ALIGNMENT_LEFT, -1, 48, Color(1, 1, 1))
	var mt := "Mode: " + current_mode.capitalize() + "   \u2022   $%d" % money
	var mtw: float = font.get_string_size(mt, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
	draw_string(font, Vector2((screen.x - mtw) * 0.5, 110), mt, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.9, 0.8, 0.4))
	var bw := 150.0; var bh := 48.0; var gap := 14.0
	var total_w := bw * 3.0 + gap * 2.0
	var bx := (screen.x - total_w) * 0.5
	var by := screen.y - 85.0
	overlay_btn_left = Rect2(bx, by, bw, bh)
	overlay_btn_mid = Rect2(bx + bw + gap, by, bw, bh)
	overlay_btn_right = Rect2(bx + bw * 2.0 + gap * 2.0, by, bw, bh)
	_draw_button(overlay_btn_left, "Resume [Esc]")
	_draw_button(overlay_btn_mid, "Settings")
	_draw_button(overlay_btn_right, "Menu")

func _draw_tutorial() -> void:
	var bigw: float = font.get_string_size("How to Play", HORIZONTAL_ALIGNMENT_LEFT, -1, 52).x
	draw_string(font, Vector2((screen.x - bigw) * 0.5, screen.y * 0.14), "How to Play", HORIZONTAL_ALIGNMENT_LEFT, -1, 52, Color(1.0, 0.85, 0.4))
	var ml := "Mode: " + tutorial_mode.capitalize()
	var mlw: float = font.get_string_size(ml, HORIZONTAL_ALIGNMENT_LEFT, -1, 20).x
	draw_string(font, Vector2((screen.x - mlw) * 0.5, screen.y * 0.14 + 34), ml, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(0.7, 0.7, 0.85))
	var lines: Array = []
	match tutorial_mode:
		"classic":
			lines.append("Move with WASD or arrow keys. Space to DASH (i-frames!).")
			lines.append("Every wave you clear earns you $20.")
			lines.append("Checkpoint saved every 5 waves - retry resumes there.")
			lines.append("Every 10th wave is a BOSS - kill it for $200.")
			lines.append("Lure enemies into hazards, then leave before it fires.")
			lines.append("Kill quickly to build a combo multiplier - go for streaks!")
			lines.append("If you own Second Wind, you revive on death.")
			lines.append("On touch screens: arrow keys on = joystick, off = tap to move.")
		"speedrun":
			lines.append("Same rules as Classic, but the clock is running.")
			lines.append("Reach wave 20 as fast as you can.")
			lines.append("Space to DASH (i-frames!) out of danger.")
			lines.append("Faster wins earn more money (up to $900).")
		"waveless":
			lines.append("No waves. Enemies stream in constantly.")
			lines.append("Every enemy you kill earns you $5.")
			lines.append("Space to DASH (i-frames!) when overwhelmed.")
			lines.append("At 2.5 minutes, bosses start spawning.")
			lines.append("Survive as long as you can.")
		"duel":
			lines.append("1v1. Red uses Arrow Keys. Blue uses W A S D.")
			lines.append("On touch: left half drives Red, right half drives Blue.")
			lines.append("Dash is disabled in Duel (two players, one key).")
			lines.append("Crystals spawn, but each one vanishes after 7 seconds.")
			lines.append("First to 3 crystals triggers the machine's laser.")
			lines.append("Laser hits the loser, costing one life.")
			lines.append("Last player standing wins.")
	var y := screen.y * 0.34
	for line in lines:
		var lw: float = font.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1, 19).x
		draw_string(font, Vector2((screen.x - lw) * 0.5, y), line, HORIZONTAL_ALIGNMENT_LEFT, -1, 19, Color(0.92, 0.92, 0.98)); y += 26.0
	tutorial_btn = Rect2((screen.x - 240) * 0.5, screen.y - 100, 240, 52)
	_draw_button(tutorial_btn, "Start [Space]")

func _draw_classic_slots() -> void:
	var title := "CLASSIC - SELECT SLOT"
	var tw: float = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, 44).x
	draw_string(font, Vector2((screen.x - tw) * 0.5, UI_MARGIN + 25), title, HORIZONTAL_ALIGNMENT_LEFT, -1, 44, Color(1.0, 0.85, 0.4))
	var subtitle := "Each slot saves only your checkpoint - money, skins, trails, and upgrades are shared."
	var sw: float = font.get_string_size(subtitle, HORIZONTAL_ALIGNMENT_LEFT, -1, 14).x
	draw_string(font, Vector2((screen.x - sw) * 0.5, UI_MARGIN + 50), subtitle, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color(0.6, 0.6, 0.7))
	classic_slot_rects.clear(); classic_new_rects.clear()
	var row_w := minf(720.0, screen.x - UI_MARGIN * 2.0)
	var row_h := 88.0; var gap := 10.0
	var start_y := UI_MARGIN + 80.0
	var start_x := (screen.x - row_w) * 0.5
	var pb_w := 130.0; var pb_h := 44.0
	var nb_w := 110.0
	for i in range(5):
		var sn := i + 1
		var rect := Rect2(start_x, start_y + i * (row_h + gap), row_w, row_h)
		var checkpoint: int = int(classic_checkpoints[i])
		var is_current := sn == current_slot
		draw_rect(rect, Color(0.20, 0.28, 0.22, 0.9) if is_current else Color(0.16, 0.16, 0.22, 0.9))
		draw_rect(rect, Color(1, 0.85, 0.4) if is_current else Color(0.4, 0.4, 0.5), false, 2.0)
		draw_string(font, Vector2(rect.position.x + 20, rect.position.y + 32), "SLOT %d" % sn,
			HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color(1, 1, 1))
		if checkpoint > 0:
			draw_string(font, Vector2(rect.position.x + 20, rect.position.y + 60),
				"Checkpoint: Wave %d" % checkpoint, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.4, 1.0, 0.5))
			draw_string(font, Vector2(rect.position.x + 20, rect.position.y + 78),
				"Retry resumes from here", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.55, 0.55, 0.6))
		else:
			draw_string(font, Vector2(rect.position.x + 20, rect.position.y + 60),
				"No checkpoint yet", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(0.55, 0.55, 0.6))
			draw_string(font, Vector2(rect.position.x + 20, rect.position.y + 78),
				"Starting fresh from Wave 1", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.5, 0.5, 0.55))
		var pbx := rect.end.x - pb_w - 20
		var play_btn := Rect2(pbx, rect.position.y + (row_h - pb_h) * 0.5, pb_w, pb_h)
		var phov := play_btn.has_point(get_global_mouse_position())
		draw_rect(play_btn, Color(0.25, 0.35, 0.28) if phov else Color(0.18, 0.28, 0.22))
		draw_rect(play_btn, Color(0.4, 1.0, 0.5) if phov else Color(0.3, 0.8, 0.4), false, 2.0)
		var plbl := "\u25B6 Play"
		var plw: float = font.get_string_size(plbl, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
		draw_string(font, Vector2(play_btn.position.x + (pb_w - plw) * 0.5, play_btn.position.y + pb_h * 0.5 + 6),
			plbl, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(1, 1, 1))
		classic_slot_rects.append({"rect": play_btn, "slot": sn})
		if checkpoint > 0:
			var new_btn := Rect2(pbx - nb_w - 10, rect.position.y + (row_h - pb_h) * 0.5, nb_w, pb_h)
			var nhov := new_btn.has_point(get_global_mouse_position())
			draw_rect(new_btn, Color(0.35, 0.25, 0.25) if nhov else Color(0.22, 0.18, 0.18))
			draw_rect(new_btn, Color(1, 0.5, 0.5) if nhov else Color(0.6, 0.35, 0.4), false, 2.0)
			var nlbl := "\u21BB New"
			var nlw: float = font.get_string_size(nlbl, HORIZONTAL_ALIGNMENT_LEFT, -1, 16).x
			draw_string(font, Vector2(new_btn.position.x + (nb_w - nlw) * 0.5, new_btn.position.y + pb_h * 0.5 + 5),
				nlbl, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(1, 1, 1))
			classic_new_rects.append({"rect": new_btn, "slot": sn})
	classic_back_rect = Rect2((screen.x - 200) * 0.5, screen.y - UI_MARGIN - 50, 200, 44)
	_draw_button(classic_back_rect, "Back [Esc]")

func _draw_shop() -> void:
	var title := "SHOP"
	var tw: float = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, 54).x
	draw_string(font, Vector2((screen.x - tw) * 0.5, UI_MARGIN + 30), title, HORIZONTAL_ALIGNMENT_LEFT, -1, 54, Color(1, 0.85, 0.4))
	var mtxt := "$%d" % money
	var mw: float = font.get_string_size(mtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 32).x
	draw_string(font, Vector2(screen.x - mw - UI_MARGIN, UI_MARGIN + 30), mtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 32, Color(1, 0.85, 0.4))
	var ty := UI_MARGIN + 60.0; var tw_ := 152.0; var th := 40.0; var tg := 12.0
	var tabs := ["skins", "trails", "upgrades", "no_tier"]
	var labels := {"skins": "Skins", "trails": "Trails", "upgrades": "Upgrades", "no_tier": "No Tier"}
	var ttw := tw_ * 4.0 + tg * 3.0
	var tx := (screen.x - ttw) * 0.5
	shop_tab_rects.clear()
	for i in range(tabs.size()):
		var key: String = tabs[i]
		var r := Rect2(tx + i * (tw_ + tg), ty, tw_, th)
		shop_tab_rects[key] = r
		var active := shop_current_tab == key
		draw_rect(r, Color(0.35, 0.30, 0.20) if active else Color(0.15, 0.15, 0.2))
		draw_rect(r, Color(1, 0.85, 0.4) if active else Color(0.4, 0.4, 0.5), false, 2.0)
		var lw: float = font.get_string_size(labels[key], HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
		draw_string(font, Vector2(r.position.x + (tw_ - lw) * 0.5, r.position.y + 27), labels[key], HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(1, 1, 1))
	shop_item_rects.clear()
	match shop_current_tab:
		"skins": _draw_skins_grid()
		"trails": _draw_trails_grid()
		"upgrades": _draw_upgrades_list()
		"no_tier": _draw_no_tier_list()
	shop_back_rect = Rect2((screen.x - 200) * 0.5, screen.y - UI_MARGIN - 50, 200, 44)
	_draw_button(shop_back_rect, "Back [Esc]")

func _draw_skins_grid() -> void:
	var cols := 5; var gap := 6.0
	var cw := ((screen.x - UI_MARGIN * 2.0) - (cols - 1) * gap) / cols
	cw = minf(cw, 170.0)
	var nr := int(ceil(float(SKINS.size() + 1) / float(cols)))
	var view_top := UI_MARGIN + 105.0
	var view_bot := screen.y - UI_MARGIN - 55.0
	var view_h := view_bot - view_top
	var ch := clampf((view_h - (nr - 1) * gap) / float(nr), 34.0, 90.0)
	var content_h := nr * ch + (nr - 1) * gap
	shop_scroll = clampf(shop_scroll, 0.0, maxf(0.0, content_h - view_h))
	var sy := view_top - shop_scroll
	var ey := view_bot
	var tw := cols * cw + (cols - 1) * gap
	var sx := (screen.x - tw) * 0.5
	for i in range(SKINS.size()):
		var skin: Array = SKINS[i]
		var c := i % cols; var r := i / cols
		var rect := Rect2(sx + c * (cw + gap), sy + r * (ch + gap), cw, ch)
		if rect.end.y > ey + 5.0: continue
		if rect.position.y < view_top - 5.0: continue
		shop_item_rects.append({"rect": rect, "index": i, "type": "skin"})
		var sid: String = skin[0]
		var achv_lock := _skin_achv_lock(skin)
		var locked := achv_lock != "" and not achv_lock in achievements_unlocked
		var owned := sid in owned_skins
		var equipped := sid == current_skin
		var price: int = skin[2]
		var can_buy := owned or money >= price
		var bg := Color(0.15, 0.15, 0.2)
		if locked: bg = Color(0.10, 0.10, 0.13)
		elif equipped: bg = Color(0.20, 0.35, 0.25)
		elif owned: bg = Color(0.18, 0.20, 0.26)
		draw_rect(rect, bg)
		draw_rect(rect, Color(0.3, 0.3, 0.35) if locked else (Color(0.7, 0.7, 0.8) if can_buy or owned else Color(0.4, 0.4, 0.5)), false, 1.5)
		var primary: Color = skin[3] if sid != "rainbow" else Color.from_hsv(fmod(t * 0.3 + i * 0.1, 1.0), 1.0, 1.0)
		var core: Color = skin[4]; var glow: Color = skin[5]
		if locked: primary = primary.darkened(0.7); core = core.darkened(0.7); glow = glow.darkened(0.7)
		var py := rect.position.y + ch * 0.30
		var pr := minf(11.0, ch * 0.20)
		var pp := Vector2(rect.position.x + cw * 0.5, py)
		draw_circle(pp, pr * 1.27, Color(glow.r, glow.g, glow.b, 0.3))
		draw_circle(pp, pr, primary)
		draw_circle(pp + Vector2(-2, -2), pr * 0.45, core)
		var ns: String = skin[1]
		var nsz := int(clampf(ch * 0.18, 10.0, 14.0))
		var nw: float = font.get_string_size(ns, HORIZONTAL_ALIGNMENT_LEFT, -1, nsz).x
		draw_string(font, Vector2(rect.position.x + (cw - nw) * 0.5, rect.position.y + ch * 0.62), ns, HORIZONTAL_ALIGNMENT_LEFT, -1, nsz, Color(1, 1, 1) if not locked else Color(0.55, 0.55, 0.6))
		var status := ""; var status_col := Color(0.9, 0.8, 0.4)
		if locked: status = "Locked"; status_col = Color(0.55, 0.55, 0.6)
		elif equipped: status = "Equipped"; status_col = Color(0.4, 1.0, 0.5)
		elif owned: status = "Owned"; status_col = Color(0.6, 0.8, 1.0)
		else:
			status = "$%d" % price
			if not can_buy: status_col = Color(0.6, 0.4, 0.4)
		var ssz := int(clampf(ch * 0.15, 9.0, 12.0))
		var sw: float = font.get_string_size(status, HORIZONTAL_ALIGNMENT_LEFT, -1, ssz).x
		draw_string(font, Vector2(rect.position.x + (cw - sw) * 0.5, rect.position.y + ch * 0.85), status, HORIZONTAL_ALIGNMENT_LEFT, -1, ssz, status_col)
	var ci := SKINS.size()
	var ccol := ci % cols; var crow := ci / cols
	var crect := Rect2(sx + ccol * (cw + gap), sy + crow * (ch + gap), cw, ch)
	if crect.end.y <= ey + 5.0 and crect.position.y >= view_top - 5.0:
		shop_item_rects.append({"rect": crect, "index": -1, "type": "custom_orb"})
		var cowned := CUSTOM_ORB_ID in owned_skins
		var cequipped := current_skin == CUSTOM_ORB_ID
		var ccan_buy := cowned or money >= CUSTOM_ORB_PRICE
		var cbg := Color(0.15, 0.15, 0.2)
		if cequipped: cbg = Color(0.20, 0.35, 0.25)
		elif cowned: cbg = Color(0.18, 0.20, 0.26)
		draw_rect(crect, cbg)
		draw_rect(crect, Color(0.7, 0.7, 0.8) if ccan_buy or cowned else Color(0.4, 0.4, 0.5), false, 1.5)
		var cpp := Vector2(crect.position.x + cw * 0.5, crect.position.y + ch * 0.30)
		var cpr := minf(11.0, ch * 0.20)
		if custom_orb_texture != null:
			var ots := custom_orb_texture.get_size()
			if ots.x > 0 and ots.y > 0:
				var osc := (cpr * 2.0) / maxf(ots.x, ots.y)
				var ods := ots * osc
				draw_texture_rect(custom_orb_texture, Rect2(cpp - ods * 0.5, ods), false)
		else:
			draw_circle(cpp, cpr, Color(0.5, 0.5, 0.6))
			draw_arc(cpp, cpr, 0, TAU, 20, Color(1, 1, 1, 0.6), 1.5)
		var cnsz := int(clampf(ch * 0.18, 10.0, 14.0))
		var cnm := "Custom Orb"
		var cnw: float = font.get_string_size(cnm, HORIZONTAL_ALIGNMENT_LEFT, -1, cnsz).x
		draw_string(font, Vector2(crect.position.x + (cw - cnw) * 0.5, crect.position.y + ch * 0.62), cnm, HORIZONTAL_ALIGNMENT_LEFT, -1, cnsz, Color(1, 1, 1))
		var cstatus := ""; var cscol := Color(0.9, 0.8, 0.4)
		if cequipped: cstatus = "Equipped"; cscol = Color(0.4, 1.0, 0.5)
		elif cowned: cstatus = "Owned"; cscol = Color(0.6, 0.8, 1.0)
		else:
			cstatus = "$%d" % CUSTOM_ORB_PRICE
			if not ccan_buy: cscol = Color(0.6, 0.4, 0.4)
		var cssz := int(clampf(ch * 0.15, 9.0, 12.0))
		var csw: float = font.get_string_size(cstatus, HORIZONTAL_ALIGNMENT_LEFT, -1, cssz).x
		draw_string(font, Vector2(crect.position.x + (cw - csw) * 0.5, crect.position.y + ch * 0.85), cstatus, HORIZONTAL_ALIGNMENT_LEFT, -1, cssz, cscol)

func _draw_trail_preview(center: Vector2, scale: float, trail: Array, locked: bool) -> void:
	var style: String = str(trail[3])
	var colA: Color = trail[4]
	var colB: Color = trail[5]
	if locked:
		colA = colA.darkened(0.7); colB = colB.darkened(0.7)
	var n := 8
	for i in range(n):
		var f := float(i) / float(n)
		var off := Vector2(-scale * 1.2 + f * scale * 1.2, sin(f * 6.0 + t * 3.0) * scale * 0.25)
		var p := center + off
		var a := f * 0.6
		var c := colA.lerp(colB, f)
		match style:
			"ribbon":
				if i > 0:
					var prev := center + Vector2(-scale * 1.2 + float(i - 1) / float(n) * scale * 1.2, sin(float(i - 1) / float(n) * 6.0 + t * 3.0) * scale * 0.25)
					draw_line(prev, p, Color(c.r, c.g, c.b, a), 3.0 * scale * 0.12)
			"rainbow":
				var rc := Color.from_hsv(fmod(f + t * 0.4, 1.0), 0.9, 1.0)
				draw_circle(p, scale * 0.18 * (0.4 + f), Color(rc.r, rc.g, rc.b, a))
			"stars":
				if i % 2 == 0:
					draw_line(p + Vector2(-2, 0), p + Vector2(2, 0), Color(c.r, c.g, c.b, a), 1.5)
					draw_line(p + Vector2(0, -2), p + Vector2(0, 2), Color(c.r, c.g, c.b, a), 1.5)
			"bubbles":
				if i % 2 == 0: draw_arc(p, scale * 0.18 * (0.5 + f), 0, TAU, 12, Color(c.r, c.g, c.b, a), 1.0)
			_:
				draw_circle(p, scale * 0.2 * (0.4 + f), Color(c.r, c.g, c.b, a))

func _draw_trails_grid() -> void:
	var cols := 4; var gap := 8.0
	var cw := ((screen.x - UI_MARGIN * 2.0) - (cols - 1) * gap) / cols
	cw = minf(cw, 200.0)
	var nr := int(ceil(float(TRAILS.size() + 1) / float(cols)))
	var sy := UI_MARGIN + 105.0
	var ey := screen.y - UI_MARGIN - 55.0
	var ch := clampf((ey - sy - (nr - 1) * gap) / float(nr), 60.0, 100.0)
	var tw := cols * cw + (cols - 1) * gap
	var sx := (screen.x - tw) * 0.5
	for i in range(TRAILS.size()):
		var trail: Array = TRAILS[i]
		var c := i % cols; var r := i / cols
		var rect := Rect2(sx + c * (cw + gap), sy + r * (ch + gap), cw, ch)
		if rect.end.y > ey + 5.0: break
		shop_item_rects.append({"rect": rect, "index": i, "type": "trail"})
		var tid: String = trail[0]
		var achv_lock := _trail_achv_lock(trail)
		var locked := achv_lock != "" and not achv_lock in achievements_unlocked
		var owned := tid in owned_trails
		var equipped := tid == current_trail
		var price: int = trail[2]
		var can_buy := owned or money >= price
		var bg := Color(0.15, 0.15, 0.2)
		if locked: bg = Color(0.10, 0.10, 0.13)
		elif equipped: bg = Color(0.20, 0.35, 0.25)
		elif owned: bg = Color(0.18, 0.20, 0.26)
		draw_rect(rect, bg)
		draw_rect(rect, Color(0.3, 0.3, 0.35) if locked else (Color(0.7, 0.7, 0.8) if can_buy or owned else Color(0.4, 0.4, 0.5)), false, 1.5)
		_draw_trail_preview(Vector2(rect.position.x + cw * 0.5, rect.position.y + ch * 0.30), 26.0, trail, locked)
		var ns: String = trail[1]
		var nsz := int(clampf(ch * 0.17, 10.0, 14.0))
		var nw: float = font.get_string_size(ns, HORIZONTAL_ALIGNMENT_LEFT, -1, nsz).x
		draw_string(font, Vector2(rect.position.x + (cw - nw) * 0.5, rect.position.y + ch * 0.62), ns, HORIZONTAL_ALIGNMENT_LEFT, -1, nsz, Color(1, 1, 1) if not locked else Color(0.55, 0.55, 0.6))
		var status := ""; var status_col := Color(0.9, 0.8, 0.4)
		if locked: status = "Locked"; status_col = Color(0.55, 0.55, 0.6)
		elif equipped: status = "Equipped"; status_col = Color(0.4, 1.0, 0.5)
		elif owned: status = "Owned"; status_col = Color(0.6, 0.8, 1.0)
		else:
			status = "$%d" % price
			if not can_buy: status_col = Color(0.6, 0.4, 0.4)
		var ssz := int(clampf(ch * 0.14, 9.0, 12.0))
		var sw: float = font.get_string_size(status, HORIZONTAL_ALIGNMENT_LEFT, -1, ssz).x
		draw_string(font, Vector2(rect.position.x + (cw - sw) * 0.5, rect.position.y + ch * 0.87), status, HORIZONTAL_ALIGNMENT_LEFT, -1, ssz, status_col)
	var ci := TRAILS.size()
	var ccol := ci % cols; var crow := ci / cols
	var crect := Rect2(sx + ccol * (cw + gap), sy + crow * (ch + gap), cw, ch)
	if crect.end.y <= ey + 5.0:
		shop_item_rects.append({"rect": crect, "index": -1, "type": "custom_trail"})
		var cowned := CUSTOM_TRAIL_ID in owned_trails
		var cequipped := current_trail == CUSTOM_TRAIL_ID
		var ccan_buy := cowned or money >= CUSTOM_TRAIL_PRICE
		var cbg := Color(0.15, 0.15, 0.2)
		if cequipped: cbg = Color(0.20, 0.35, 0.25)
		elif cowned: cbg = Color(0.18, 0.20, 0.26)
		draw_rect(crect, cbg)
		draw_rect(crect, Color(0.7, 0.7, 0.8) if ccan_buy or cowned else Color(0.4, 0.4, 0.5), false, 1.5)
		var cpc := Vector2(crect.position.x + cw * 0.5, crect.position.y + ch * 0.30)
		if custom_trail_texture != null:
			var tts := custom_trail_texture.get_size()
			if tts.x > 0 and tts.y > 0:
				for k in range(3):
					var kf := 1.0 - float(k) * 0.3
					var ksz := 22.0 * kf
					draw_texture_rect(custom_trail_texture, Rect2(cpc + Vector2(-36.0 + k * 18.0, 0), Vector2(ksz, ksz)), false)
		else:
			draw_circle(cpc, 12.0, Color(0.5, 0.5, 0.6))
			draw_arc(cpc, 12.0, 0, TAU, 20, Color(1, 1, 1, 0.6), 1.5)
		var cnsz := int(clampf(ch * 0.17, 10.0, 14.0))
		var cnm := "Custom Trail"
		var cnw: float = font.get_string_size(cnm, HORIZONTAL_ALIGNMENT_LEFT, -1, cnsz).x
		draw_string(font, Vector2(crect.position.x + (cw - cnw) * 0.5, crect.position.y + ch * 0.62), cnm, HORIZONTAL_ALIGNMENT_LEFT, -1, cnsz, Color(1, 1, 1))
		var cstatus := ""; var cscol := Color(0.9, 0.8, 0.4)
		if cequipped: cstatus = "Equipped"; cscol = Color(0.4, 1.0, 0.5)
		elif cowned: cstatus = "Owned"; cscol = Color(0.6, 0.8, 1.0)
		else:
			cstatus = "$%d" % CUSTOM_TRAIL_PRICE
			if not ccan_buy: cscol = Color(0.6, 0.4, 0.4)
		var cssz := int(clampf(ch * 0.14, 9.0, 12.0))
		var csw: float = font.get_string_size(cstatus, HORIZONTAL_ALIGNMENT_LEFT, -1, cssz).x
		draw_string(font, Vector2(crect.position.x + (cw - csw) * 0.5, crect.position.y + ch * 0.87), cstatus, HORIZONTAL_ALIGNMENT_LEFT, -1, cssz, cscol)

func _draw_upgrades_list() -> void:
	var rw := minf(700.0, screen.x - UI_MARGIN * 2.0)
	var rh := 56.0; var gap := 8.0
	var sx := (screen.x - rw) * 0.5
	var sy := UI_MARGIN + 120.0
	for i in range(UPGRADES.size()):
		var upg: Array = UPGRADES[i]
		var uid: String = upg[0]; var prices: Array = upg[2]; var descs: Array = upg[3]
		var cl: int = int(owned_upgrades.get(uid, 0)); var ml: int = prices.size()
		var rect := Rect2(sx, sy + i * (rh + gap), rw, rh)
		if rect.end.y > screen.y - UI_MARGIN - 60.0: break
		shop_item_rects.append({"rect": rect, "index": i, "type": "upgrade"})
		var maxed := cl >= ml
		var np: int = 0 if maxed else int(prices[cl])
		var cb := not maxed and money >= np
		var bg := Color(0.15, 0.15, 0.2)
		if maxed: bg = Color(0.20, 0.30, 0.22)
		elif cl > 0: bg = Color(0.18, 0.22, 0.30)
		draw_rect(rect, bg)
		draw_rect(rect, Color(0.4, 0.9, 0.5) if maxed else (Color(1, 0.85, 0.4) if cb else Color(0.6, 0.7, 0.9) if cl > 0 else Color(0.4, 0.4, 0.5)), false, 1.5)
		draw_string(font, Vector2(rect.position.x + 16, rect.position.y + 22),
			"%s  (Lvl %d/%d)" % [upg[1], cl, ml], HORIZONTAL_ALIGNMENT_LEFT, -1, 17, Color(1, 1, 1))
		var dt := ""
		if maxed: dt = "MAXED - " + str(descs[ml - 1])
		else: dt = "Next: " + str(descs[cl])
		draw_string(font, Vector2(rect.position.x + 16, rect.position.y + 42), dt, HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color(0.7, 0.7, 0.8))
		var st := ""; var sc := Color(0.9, 0.8, 0.4)
		if maxed: st = "MAXED"; sc = Color(0.4, 1.0, 0.5)
		else:
			st = "$%d" % np
			if not cb: sc = Color(0.6, 0.4, 0.4)
		var stw: float = font.get_string_size(st, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
		draw_string(font, Vector2(rect.end.x - stw - 16, rect.position.y + 32), st, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, sc)
		for p in range(ml):
			var px := rect.position.x + 16 + p * 12
			var py := rect.position.y + rect.size.y - 8
			if p < cl: draw_circle(Vector2(px, py), 4.0, Color(1, 0.85, 0.4))
			else:
				draw_circle(Vector2(px, py), 4.0, Color(0.3, 0.3, 0.4))
				draw_arc(Vector2(px, py), 4.0, 0, TAU, 16, Color(0.5, 0.5, 0.6), 1.0)

func _draw_no_tier_list() -> void:
	var rw := minf(700.0, screen.x - UI_MARGIN * 2.0)
	var rh := 52.0; var gap := 6.0
	var sx := (screen.x - rw) * 0.5
	var sy := UI_MARGIN + 120.0
	for i in range(NO_TIER_UPGRADES.size()):
		var upg: Array = NO_TIER_UPGRADES[i]
		var uid: String = upg[0]
		var owned := bool(no_tier_owned.get(uid, false))
		var price: int = int(upg[2])
		var rect := Rect2(sx, sy + i * (rh + gap), rw, rh)
		if rect.end.y > screen.y - UI_MARGIN - 60.0: break
		shop_item_rects.append({"rect": rect, "index": i, "type": "no_tier"})
		var cb := not owned and money >= price
		var bg := Color(0.15, 0.15, 0.2)
		if owned: bg = Color(0.18, 0.30, 0.34)
		draw_rect(rect, bg)
		draw_rect(rect, Color(0.4, 0.9, 1.0) if owned else (Color(1, 0.85, 0.4) if cb else Color(0.5, 0.5, 0.6)), false, 1.5)
		draw_string(font, Vector2(rect.position.x + 16, rect.position.y + 20),
			str(upg[1]), HORIZONTAL_ALIGNMENT_LEFT, -1, 17, Color(1, 1, 1))
		draw_string(font, Vector2(rect.position.x + 16, rect.position.y + 38),
			str(upg[3]), HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.7, 0.7, 0.8))
		var st := ""; var sc := Color(0.9, 0.8, 0.4)
		if owned: st = "OWNED"; sc = Color(0.4, 0.9, 1.0)
		else:
			st = "$%d" % price
			if not cb: sc = Color(0.6, 0.4, 0.4)
		var stw: float = font.get_string_size(st, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
		draw_string(font, Vector2(rect.end.x - stw - 16, rect.position.y + 30), st, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, sc)

func _draw_achievements() -> void:
	var title := "ACHIEVEMENTS"
	var tw: float = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, 48).x
	draw_string(font, Vector2((screen.x - tw) * 0.5, UI_MARGIN + 30), title, HORIZONTAL_ALIGNMENT_LEFT, -1, 48, Color(1, 0.85, 0.4))
	var counter := "%d / %d unlocked" % [achievements_unlocked.size(), ACHIEVEMENT_DEFS.size()]
	var cw: float = font.get_string_size(counter, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
	draw_string(font, Vector2((screen.x - cw) * 0.5, UI_MARGIN + 58), counter, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.75, 0.75, 0.85))
	var rw := minf(760.0, screen.x - UI_MARGIN * 2.0)
	var rh := 44.0; var gap := 6.0
	var sx := (screen.x - rw) * 0.5
	var sy := UI_MARGIN + 90.0
	var cwl := rw * 0.5 - gap * 0.5
	for i in range(ACHIEVEMENT_DEFS.size()):
		var ad: Array = ACHIEVEMENT_DEFS[i]
		var aid: String = ad[0]
		var unlocked := aid in achievements_unlocked
		var ci := i % 2; var ri := i / 2
		var rect := Rect2(sx + ci * (cwl + gap), sy + ri * (rh + gap), cwl, rh)
		if rect.end.y > screen.y - UI_MARGIN - 60.0: break
		draw_rect(rect, Color(0.20, 0.30, 0.24) if unlocked else Color(0.15, 0.15, 0.2))
		draw_rect(rect, Color(0.4, 0.9, 0.5) if unlocked else Color(0.4, 0.4, 0.5), false, 1.5)
		var ic := Color(1, 0.85, 0.4) if unlocked else Color(0.4, 0.4, 0.5)
		_draw_achv_icon(rect.position + Vector2(24, rh * 0.5), 28.0, ic)
		draw_string(font, Vector2(rect.position.x + 48, rect.position.y + 18), ad[1], HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color(1, 1, 1) if unlocked else Color(0.6, 0.6, 0.65))
		draw_string(font, Vector2(rect.position.x + 48, rect.position.y + 34), ad[2], HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.7, 0.9, 0.75) if unlocked else Color(0.5, 0.5, 0.55))
	achv_back_rect = Rect2((screen.x - 200) * 0.5, screen.y - UI_MARGIN - 50, 200, 44)
	_draw_button(achv_back_rect, "Back [Esc]")

func _draw_toast() -> void:
	if toast_timer <= 0.0 or toast_message == "": return
	var a := 1.0
	if toast_timer > 2.2: a = (2.5 - toast_timer) / 0.3
	elif toast_timer < 0.3: a = toast_timer / 0.3
	a = clampf(a, 0.0, 1.0)
	var tw: float = font.get_string_size(toast_message, HORIZONTAL_ALIGNMENT_LEFT, -1, 20).x
	var tr := Rect2((screen.x - tw - 60.0) * 0.5, 50, tw + 60.0, 40)
	draw_rect(tr, Color(0.1, 0.1, 0.15, 0.88 * a))
	draw_rect(tr, Color(1, 0.85, 0.4, a), false, 2.0)
	draw_string(font, Vector2((screen.x - tw) * 0.5, 76), toast_message, HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color(1, 1, 1, a))

# NEW: find cheapest unowned skin/trail for the "Next unlock" tease
func _next_unlock_hint() -> Dictionary:
	var best_price := 999999
	var best_name := ""
	for skin in SKINS:
		var sid: String = skin[0]
		if sid in owned_skins: continue
		if _skin_achv_lock(skin) != "": continue
		var pr: int = skin[2]
		if pr < best_price:
			best_price = pr; best_name = skin[1]
	for trail in TRAILS:
		var tid: String = trail[0]
		if tid in owned_trails: continue
		if _trail_achv_lock(trail) != "": continue
		var pr: int = trail[2]
		if pr < best_price:
			best_price = pr; best_name = trail[1]
	return {"price": best_price, "name": best_name}

func _draw_menu() -> void:
	var tw: float = font.get_string_size("Cursor Chaos", HORIZONTAL_ALIGNMENT_LEFT, -1, 54).x
	draw_string(font, Vector2((screen.x - tw) * 0.5, 140), "Cursor Chaos", HORIZONTAL_ALIGNMENT_LEFT, -1, 54, Color(1.0, 0.25, 0.3))
	var sub := "Clear every enemy. Bait the hazards. Survive."
	var sw: float = font.get_string_size(sub, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
	draw_string(font, Vector2((screen.x - sw) * 0.5, 168), sub, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.85, 0.75, 0.85))
	var mtxt := "$%d" % money
	var mw: float = font.get_string_size(mtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 26).x
	draw_string(font, Vector2(screen.x - mw - UI_MARGIN, UI_MARGIN + 20), mtxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 26, Color(1, 0.85, 0.4))
	# NEW: next unlock tease
	var hint := _next_unlock_hint()
	if hint["price"] < 999999 and hint["name"] != "":
		var htxt := "Next: %s ($%d)" % [hint["name"], hint["price"]]
		var hw: float = font.get_string_size(htxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
		draw_string(font, Vector2(screen.x - hw - UI_MARGIN, UI_MARGIN + 38), htxt, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.6, 0.8, 1.0))
	menu_button_rects.clear()
	var sb := 56.0; var sxx := UI_MARGIN
	var shopb := Rect2(sxx, UI_MARGIN, sb, sb)
	var achvb := Rect2(sxx, UI_MARGIN + sb + 12, sb, sb)
	var settb := Rect2(sxx, UI_MARGIN + (sb + 12) * 2, sb, sb)
	var quitb := Rect2(sxx, UI_MARGIN + (sb + 12) * 3, sb, sb)  # NEW
	menu_button_rects["shop"] = shopb; menu_button_rects["achievements"] = achvb
	menu_button_rects["settings"] = settb; menu_button_rects["quit"] = quitb
	var sh := shopb.has_point(get_global_mouse_position())
	draw_rect(shopb, Color(0.20, 0.20, 0.26, 0.9) if not sh else Color(0.30, 0.24, 0.32, 0.95))
	draw_rect(shopb, Color(1, 0.85, 0.4, 1.0) if sh else Color(1, 0.85, 0.4, 0.6), false, 2.0)
	_draw_shop_icon(shopb.get_center(), 30.0, Color(1, 0.85, 0.4))
	var ah := achvb.has_point(get_global_mouse_position())
	draw_rect(achvb, Color(0.20, 0.20, 0.26, 0.9) if not ah else Color(0.30, 0.24, 0.32, 0.95))
	draw_rect(achvb, Color(1, 0.85, 0.4, 1.0) if ah else Color(1, 0.85, 0.4, 0.6), false, 2.0)
	_draw_achv_icon(achvb.get_center(), 30.0, Color(1, 0.85, 0.4))
	var sth := settb.has_point(get_global_mouse_position())
	draw_rect(settb, Color(0.20, 0.20, 0.26, 0.9) if not sth else Color(0.30, 0.24, 0.32, 0.95))
	draw_rect(settb, Color(1, 1, 1, 1.0) if sth else Color(1, 1, 1, 0.6), false, 2.0)
	_draw_settings_icon(settb.get_center(), 30.0, Color(1, 1, 1))
	# NEW: quit button
	var qh := quitb.has_point(get_global_mouse_position())
	draw_rect(quitb, Color(0.20, 0.14, 0.14, 0.9) if not qh else Color(0.34, 0.18, 0.18, 0.95))
	draw_rect(quitb, Color(1, 0.4, 0.4, 1.0) if qh else Color(1, 0.4, 0.4, 0.6), false, 2.0)
	_draw_quit_icon(quitb.get_center(), 30.0, Color(1, 0.4, 0.4))
	var modes := [
		{"id": "classic", "label": "Classic [1]", "desc": "Survive as many waves as you can."},
		{"id": "speedrun", "label": "Speedrun [2]", "desc": "Reach wave 20 as fast as you can."},
		{"id": "waveless", "label": "Waveless [3]", "desc": "No waves. Survive as long as you can."},
		{"id": "duel", "label": "Duel [4]", "desc": "1v1. Red vs Blue. 3 lives each."},
	]
	var bw := minf(380.0, screen.x - UI_MARGIN * 2.0 - sb * 2.0 - 40.0)
	var bh := 58.0; var gap := 10.0
	var sy := 200.0
	for i in modes.size():
		var m: Dictionary = modes[i]
		var r := Rect2((screen.x - bw) * 0.5, sy + i * (bh + gap), bw, bh)
		menu_button_rects[m["id"]] = r
		var hov := r.has_point(get_global_mouse_position())
		draw_rect(r, Color(0.16, 0.16, 0.22, 0.9) if not hov else Color(0.28, 0.22, 0.30, 0.9))
		draw_rect(r, Color(1, 1, 1) if hov else Color(1.0, 0.30, 0.35), false, 2.0)
		draw_string(font, Vector2(r.position.x + 22, r.position.y + 26), m["label"], HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color(1, 1, 1))
		draw_string(font, Vector2(r.position.x + 22, r.position.y + 46), m["desc"], HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.65, 0.65, 0.72))
		if m["id"] != "duel":
			var bv := _best(m["id"])
			var bs := "Best: —"
			if bv > 0.0:
				if m["id"] == "classic": bs = "Best: W%d" % int(bv)
				elif m["id"] == "waveless": bs = "Best: %d kills" % int(bv)
				else: bs = "Best: %s" % _fmt_time(bv)
			var bsw: float = font.get_string_size(bs, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x
			draw_string(font, Vector2(r.position.x + r.size.x - bsw - 16, r.position.y + 32), bs, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(1.0, 0.85, 0.4))
	# NEW: stat cards bottom-center
	if screen.y > 620:
		var stats_y := screen.y - UI_MARGIN - 40
		var stat_lines := [
			"Kills: %d" % int(achv_stats["kills"]),
			"Bosses: %d" % int(achv_stats["bosses_killed"]),
			"Skins: %d/%d" % [owned_skins.size(), SKINS.size() + 1],
			"Trails: %d/%d" % [owned_trails.size(), TRAILS.size() + 1],
		]
		var total_w := 0.0
		for sl in stat_lines:
			total_w += font.get_string_size(sl, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x + 24.0
		var sx2 := (screen.x - total_w) * 0.5
		for sl in stat_lines:
			draw_string(font, Vector2(sx2, stats_y), sl, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.6, 0.6, 0.7))
			sx2 += font.get_string_size(sl, HORIZONTAL_ALIGNMENT_LEFT, -1, 12).x + 24.0

func _draw_settings() -> void:
	var tw: float = font.get_string_size("Settings", HORIZONTAL_ALIGNMENT_LEFT, -1, 46).x
	draw_string(font, Vector2((screen.x - tw) * 0.5, screen.y * 0.14), "Settings", HORIZONTAL_ALIGNMENT_LEFT, -1, 46, Color(1.0, 0.85, 0.4))
	var cw := screen.x * 0.42
	var clx := UI_MARGIN + 10.0
	var crx := screen.x * 0.53
	var sy := screen.y * 0.24
	var rh := 36.0
	draw_string(font, Vector2(clx, sy - 8), "Options", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.9, 0.7, 0.3))
	settings_rows.clear()
	var tg := [
		{"key": "sfx", "label": "Sound Effects", "type": "toggle"},
		{"key": "music", "label": "Music", "type": "toggle"},
		{"key": "screen_shake", "label": "Screen Shake", "type": "toggle"},
		{"key": "show_hitboxes", "label": "Show Hitboxes", "type": "toggle"},
		{"key": "show_fps", "label": "Show FPS", "type": "toggle"},
		{"key": "arrow_keys", "label": "Keyboard Movement", "type": "toggle"},
		{"key": "background", "label": "Background", "type": "cycle"},
	]
	var y := sy + 8.0
	for i in tg.size():
		var r: Dictionary = tg[i]
		var rect := Rect2(clx, y, cw, rh - 6)
		settings_rows[r["key"]] = rect
		var hov := rect.has_point(get_global_mouse_position())
		draw_rect(rect, Color(0.14, 0.14, 0.18) if not hov else Color(0.22, 0.18, 0.24))
		draw_rect(rect, Color(0.6, 0.6, 0.7), false, 1.5)
		draw_string(font, Vector2(rect.position.x + 14, rect.position.y + 22), r["label"], HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(1, 1, 1))
		if r["type"] == "cycle":
			var rr := Rect2(rect.position.x + rect.size.x - 30, rect.position.y + (rh - 6) * 0.5 - 11, 22, 22)
			bg_refresh_rect = rr
			var rhov := rr.has_point(get_global_mouse_position())
			_draw_refresh_icon(rr.get_center(), 8.0, Color(1, 1, 1) if rhov else (Color(0.6, 0.85, 1.0) if custom_bg_path != "" else Color(0.5, 0.5, 0.6)))
			var bn := ""
			if settings["background"] == "custom":
				bn = "Custom: " + (custom_bg_path.get_file() if custom_bg_path != "" else "(no file)")
				if bn.length() > 20: bn = bn.substr(0, 17) + "..."
			else:
				for bg in BACKGROUNDS:
					if bg[0] == settings["background"]:
						bn = bg[1]; break
			var bw2: float = font.get_string_size(bn, HORIZONTAL_ALIGNMENT_LEFT, -1, 16).x
			draw_string(font, Vector2(rect.position.x + rect.size.x - bw2 - 42, rect.position.y + 22), bn, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(0.6, 0.85, 1.0))
			draw_string(font, Vector2(rect.position.x + rect.size.x - bw2 - 58, rect.position.y + 22), "\u25B8", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color(0.6, 0.85, 1.0, 0.7))
		else:
			var v: bool = settings[r["key"]]
			var vs := "On" if v else "Off"
			var vc := Color(0.4, 1.0, 0.5) if v else Color(0.6, 0.4, 0.4)
			var vw: float = font.get_string_size(vs, HORIZONTAL_ALIGNMENT_LEFT, -1, 16).x
			draw_string(font, Vector2(rect.position.x + rect.size.x - vw - 14, rect.position.y + 22), vs, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, vc)
		y += rh
	reset_tut_btn = Rect2(clx, y + 16, cw, 40)
	_draw_button(reset_tut_btn, "Reset Tutorials")
	draw_string(font, Vector2(crx, sy - 8), "Custom Audio", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.9, 0.7, 0.3))
	audio_row_rects.clear(); audio_refresh_rects.clear()
	var as_ := [
		{"key": "music", "label": "Music"}, {"key": "click", "label": "Click"},
		{"key": "hazard_warn", "label": "Warning"}, {"key": "hazard_fire", "label": "Blast"},
		{"key": "death", "label": "Death"}, {"key": "wave", "label": "Wave Start"}, {"key": "win", "label": "Win"},
	]
	y = sy + 8.0
	for i in as_.size():
		var a: Dictionary = as_[i]
		var rect := Rect2(crx, y, cw, rh - 6)
		audio_row_rects[a["key"]] = rect
		var hov := rect.has_point(get_global_mouse_position())
		draw_rect(rect, Color(0.14, 0.14, 0.18) if not hov else Color(0.22, 0.18, 0.24))
		draw_rect(rect, Color(0.6, 0.6, 0.7), false, 1.5)
		draw_string(font, Vector2(rect.position.x + 14, rect.position.y + 14), a["label"], HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color(0.75, 0.75, 0.85))
		var dn := "Default"; var dc := Color(0.55, 0.55, 0.65)
		if custom_streams.has(a["key"]):
			var p: String = custom_audio_paths.get(a["key"], "")
			dn = p.get_file()
			if dn.length() > 22: dn = dn.substr(0, 19) + "..."
			dc = Color(0.4, 1.0, 0.5)
		elif custom_audio_paths.has(a["key"]):
			dn = "(missing file)"; dc = Color(0.9, 0.5, 0.4)
		draw_string(font, Vector2(rect.position.x + 14, rect.position.y + 28), dn, HORIZONTAL_ALIGNMENT_LEFT, -1, 10, dc)
		var rr := Rect2(rect.position.x + rect.size.x - 34, rect.position.y + (rh - 6) * 0.5 - 11, 22, 22)
		audio_refresh_rects[a["key"]] = rr
		var rhov := rr.has_point(get_global_mouse_position())
		_draw_refresh_icon(rr.get_center(), 8.0, Color(1, 1, 1) if rhov else (Color(0.4, 1.0, 0.5) if custom_streams.has(a["key"]) else Color(0.5, 0.5, 0.6)))
		y += rh
	draw_string(font, Vector2(crx, screen.y - 130), "Click a row to load a file. Click the arrow to reset.", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color(0.55, 0.55, 0.65))
	settings_back_rect = Rect2((screen.x - 200) * 0.5, screen.y - UI_MARGIN - 50, 200, 44)
	_draw_button(settings_back_rect, "Back [Esc]")

func _draw_refresh_icon(center: Vector2, radius: float, col: Color) -> void:
	var gap := 0.8
	draw_arc(center, radius, gap, TAU - gap, 20, col, 2.0)
	var ta := TAU - gap
	var tip := center + Vector2(cos(ta), sin(ta)) * radius
	var tan := Vector2(-sin(ta), cos(ta)); var nor := Vector2(cos(ta), sin(ta))
	draw_colored_polygon(PackedVector2Array([tip, tip - tan * 4.0 + nor * 4.0, tip - tan * 4.0 - nor * 4.0]), col)

func _draw_button(r: Rect2, label: String) -> void:
	var hov := r.has_point(get_global_mouse_position())
	draw_rect(r, Color(0.20, 0.20, 0.26) if not hov else Color(0.30, 0.24, 0.32))
	draw_rect(r, Color(1.0, 0.35, 0.4) if hov else Color(1.0, 0.25, 0.30), false, 2.0)
	var lw: float = font.get_string_size(label, HORIZONTAL_ALIGNMENT_LEFT, -1, 18).x
	draw_string(font, Vector2(r.position.x + (r.size.x - lw) * 0.5, r.position.y + r.size.y * 0.5 + 6), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(1, 1, 1))
