extends Node2D

var debug_draw : bool = false

var debug_draw_points : Array
var debug_draw_lines : Array

var scores : Dictionary = {
    'player': 0,
    'enemy': 0
}

func _ready() -> void:
    debug_draw_points = Array()
    debug_draw_lines = Array()

    $Background.rect_min_size = get_viewport_rect().size
    update()

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_released('game_quit'):
        get_tree().quit()

func _draw() -> void:
    if debug_draw == true:
        for point in debug_draw_points:
            draw_circle(point, 3, ColorN('red'))

        for coords in debug_draw_lines:
            draw_line(coords[0], coords[1], ColorN('red'))

    var vp_rect = get_viewport_rect().size
    draw_line(Vector2(vp_rect.x / 2, 0), Vector2(vp_rect.x / 2, vp_rect.y), ColorN('white'))

func score(who : String) -> void:
    scores[who] += 1
    update_scores()

func update_scores():
    $GUILayer/GUI/HBoxContainer/PlayerScore.text = str(scores['player'])
    $GUILayer/GUI/HBoxContainer/EnemyScore.text = str(scores['enemy'])

