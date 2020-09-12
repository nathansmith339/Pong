extends Node2D

func _ready() -> void:
    var vp_rect = get_viewport_rect()

    $Left.add_to_group('goals')
    $Right.add_to_group('goals')

    $Left.position = Vector2(0, vp_rect.size.y / 2)
    $Left/CollisionShape2D.shape.extents = Vector2(2, vp_rect.size.y)

    $Right.position = Vector2(vp_rect.size.x, vp_rect.size.y / 2)
    $Right/CollisionShape2D.shape.extents = Vector2(2, vp_rect.size.y)
