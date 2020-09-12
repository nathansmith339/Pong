extends StaticBody2D

var enemy_paddle : KinematicBody2D

func _enter_tree() -> void:
    add_to_group('enemy_guard')

func _ready() -> void:
    enemy_paddle = get_parent().find_node('EnemyPaddle')

    var vp_rect = get_viewport_rect().size

    $CollisionShape2D.position = Vector2(enemy_paddle.offset + 10, vp_rect.y / 2)
    $CollisionShape2D.shape.extents = Vector2(10, vp_rect.y / 2)

    position = Vector2()
